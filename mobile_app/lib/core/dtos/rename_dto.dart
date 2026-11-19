import 'package:freezed_annotation/freezed_annotation.dart';

part 'rename_dto.freezed.dart';

/// Renaming a vault (by [id]) or a tag ([id] is its current name) to
/// [name].
@freezed
abstract class RenameDto with _$RenameDto {
  const factory RenameDto({required String id, required String name}) =
      _RenameDto;
}
