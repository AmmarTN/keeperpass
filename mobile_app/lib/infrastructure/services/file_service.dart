import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';
import 'package:share_plus/share_plus.dart';

/// A text file chosen in the system picker.
class PickedTextFile {
  const PickedTextFile({required this.name, required this.text, this.size});

  final String name;

  /// In bytes, when the picker knows it.
  final int? size;

  /// Read as UTF-8 (bad bytes replaced, as the browser's `File.text()`);
  /// null when the file could not be read.
  final String? text;
}

/// The system's file picker and share sheet (Settings › Data). Both are
/// screens of the system, so they run inside [LockService.duringExternalUi]
/// — "Immediately" would otherwise lock the vault behind them.
@lazySingleton
class FileService {
  FileService(this._lock);

  final LockService _lock;

  /// One file with one of [extensions]; null when nothing was chosen.
  Future<PickedTextFile?> pickText(List<String> extensions) =>
      _lock.duringExternalUi(() async {
        final PlatformFile? file = await FilePicker.pickFile(
          type: FileType.custom,
          allowedExtensions: extensions,
        );
        if (file == null) return null;
        String? text;
        try {
          text = utf8.decode(await file.readAsBytes(), allowMalformed: true);
        } on Object {
          text = null;
        }
        return PickedTextFile(
          name: file.name,
          size: file.lengthSync() ?? await file.length(),
          text: text,
        );
      });

  /// Hands [content] to the share sheet as [fileName]. [onHandedOver] runs
  /// once the sheet has it (the web records an export once the download is
  /// handed to the browser). The copy written for the sheet is deleted when
  /// it closes, so no plain file stays on the phone.
  Future<void> shareText({
    required String fileName,
    required String content,
    required String mimeType,
    void Function()? onHandedOver,
  }) => _lock.duringExternalUi(() async {
    final Directory folder = await Directory.systemTemp.createTemp('export');
    try {
      final File file = File('${folder.path}/$fileName');
      await file.writeAsString(content, flush: true);
      final Future<ShareResult> sharing = SharePlus.instance.share(
        ShareParams(files: <XFile>[XFile(file.path, mimeType: mimeType)]),
      );
      onHandedOver?.call();
      await sharing;
    } finally {
      await folder.delete(recursive: true);
    }
  });
}
