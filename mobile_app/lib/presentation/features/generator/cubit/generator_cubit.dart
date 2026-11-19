import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/generator/get_word_list.dart';
import 'package:keeperpass/core/utils/generator/generator.dart';
import 'package:keeperpass/core/utils/validation/password_strength.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';

part 'generator_cubit.freezed.dart';
part 'generator_state.dart';

/// Words a passphrase may have, and its default (the Generator tab's,
/// web `GeneratorPanel`: 3–12).
const int kMinWordCount = 3;
const int kMaxWordCount = 12;
const int kDefaultWordCount = 4;

/// Characters a random string may have, and its default (web
/// `GeneratorPanel`: 5–150).
const int kMinLength = 5;
const int kMaxLength = 150;
const int kDefaultLength = 20;

/// Passwords and passphrases (web `GeneratorPanel` / `GeneratePasswordDialog`):
/// every change of an option makes a new suggestion, nothing leaves until
/// the caller takes [GeneratorState.value] — or, on the Generator tab,
/// copies it.
@injectable
class GeneratorCubit extends Cubit<GeneratorState> {
  GeneratorCubit(
    this._getWordList,
    this._clipboard, {
    @ignoreParam this._random = secureRandomBytes,
  }) : super(const GeneratorState());

  final GetWordList _getWordList;
  final ClipboardService _clipboard;
  final RandomBytes _random;
  final Map<String, List<String>> _words = <String, List<String>>{};

  /// A first suggestion.
  Future<void> start() => _generate(state);

  Future<void> setMode(GeneratorMode mode) =>
      _generate(state.copyWith(mode: mode));

  Future<void> setWordCount(int count) => _generate(
    state.copyWith(wordCount: count.clamp(kMinWordCount, kMaxWordCount)),
  );

  Future<void> setSeparator(String separator) =>
      _generate(state.copyWith(separator: separator));

  Future<void> setLanguage(String language) =>
      _generate(state.copyWith(language: language));

  Future<void> setLength(int length) =>
      _generate(state.copyWith(length: length.clamp(kMinLength, kMaxLength)));

  Future<void> setLowercase(bool on) =>
      _generate(state.copyWith(lowercase: on));

  Future<void> setUppercase(bool on) =>
      _generate(state.copyWith(uppercase: on));

  Future<void> setDigits(bool on) => _generate(state.copyWith(digits: on));

  Future<void> setSymbols(bool on) => _generate(state.copyWith(symbols: on));

  /// Another suggestion with the same options.
  Future<void> regenerate() => _generate(state);

  /// Copies the suggestion (web `GeneratorPanel.copy`), a secret; null when
  /// there is nothing to copy.
  Future<Copied?> copy() async {
    if (state.value.isEmpty) return null;
    return (clearsIn: await _clipboard.copy(state.value, sensitive: true));
  }

  Future<void> _generate(GeneratorState next) async {
    if (next.mode == GeneratorMode.randomString) {
      final String charset =
          (next.lowercase ? GeneratorAlphabets.lowercase : '') +
          (next.uppercase ? GeneratorAlphabets.uppercase : '') +
          (next.digits ? GeneratorAlphabets.digits : '') +
          (next.symbols ? GeneratorAlphabets.symbols : '');
      emit(
        next.copyWith(
          value: charset.isEmpty
              ? ''
              : randomString(next.length, charset, random: _random),
        ),
      );
      return;
    }
    emit(next);
    final List<String> words = await _wordsFor(next.language);
    if (isClosed) return;
    // A later change wins over a list that loaded late.
    if (state != next) return;
    emit(
      next.copyWith(
        value: generatePassphrase(
          words,
          next.wordCount,
          next.separator,
          random: _random,
        ),
      ),
    );
  }

  Future<List<String>> _wordsFor(String language) async {
    final List<String>? cached = _words[language];
    if (cached != null) return cached;
    final Either<Failure, List<String>> loaded = await _getWordList(language);
    return _words[language] = loaded.getOrElse(() => const <String>[]);
  }
}
