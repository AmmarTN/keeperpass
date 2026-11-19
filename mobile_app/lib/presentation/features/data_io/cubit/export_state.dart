part of 'export_cubit.dart';

/// What can be exported: All Vaults, or one vault, with its item count.
@freezed
abstract class ExportSource with _$ExportSource {
  const factory ExportSource({
    required String label,
    required int items,

    /// Null for All Vaults.
    String? vaultId,
  }) = _ExportSource;
}

@freezed
abstract class ExportState with _$ExportState {
  const ExportState._();

  const factory ExportState({
    @Default(<ExportSource>[]) List<ExportSource> sources,

    /// The chosen vault; null is All Vaults (web: the default).
    String? vaultId,

    /// The share sheet is up.
    @Default(false) bool exporting,
  }) = _ExportState;

  ExportSource? get source =>
      sources.where((ExportSource s) => s.vaultId == vaultId).firstOrNull;

  /// Nothing to write from an empty vault (web `canExport`).
  bool get canExport => (source?.items ?? 0) > 0 && !exporting;
}
