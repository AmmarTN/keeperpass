part of 'import_cubit.dart';

/// Why a file cannot be imported (web `settings.import.*`).
enum ImportError {
  /// "This file could not be read as CSV."
  invalidCsv,

  /// "No items found in this file."
  noItems,
}

/// A vault the items can go to: "Work · 4 items".
@freezed
abstract class ImportVault with _$ImportVault {
  const factory ImportVault({
    required String id,
    required String label,
    required int items,
  }) = _ImportVault;
}

@freezed
abstract class ImportState with _$ImportState {
  const ImportState._();

  const factory ImportState({
    @Default('') String fileName,

    /// In bytes, when known.
    int? size,
    @Default(<ItemDraft>[]) List<ItemDraft> drafts,
    ImportError? error,
    @Default(<ImportVault>[]) List<ImportVault> vaults,
    String? vaultId,
  }) = _ImportState;

  /// Something to import, and somewhere to put it (web `canImport`).
  bool get canImport => drafts.isNotEmpty && vaultId != null;
}
