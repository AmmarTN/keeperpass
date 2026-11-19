import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/dtos/import_items_dto.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/usecases/data/import_items.dart';
import 'package:keeperpass/core/usecases/data/record_export.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/export_record.dart';
import 'package:keeperpass/infrastructure/models/vault/tag_registry_entry.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/features/data_io/cubit/export_cubit.dart';

void main() {
  final DateTime now = DateTime.utc(2026, 11, 1, 9, 41);
  late VaultSessionService vault;

  setUp(() {
    vault = VaultSessionService()
      ..open(VaultSnapshot.empty(vaultName: 'My Vault'), 'pw', now);
  });

  test('import adds every draft to the vault, tags registered (web '
      'addItems)', () {
    final int added = ImportItems(vault, now: () => now)(
      ImportItemsDto(
        vaultId: kPersonalVaultId,
        drafts: <({String name, List<String> tags, List<Field> fields})>[
          (
            name: 'GitHub',
            tags: <String>['work'],
            fields: <Field>[
              Field.of(name: 'Password', type: FieldType.password, value: 'x'),
            ],
          ),
          (name: 'Notes', tags: <String>[], fields: <Field>[]),
        ],
      ),
    ).getOrElse(() => -1);

    expect(added, 2);
    final List<VaultItem> items = vault.snapshot!.items;
    expect(items.map((VaultItem i) => i.name), <String>['GitHub', 'Notes']);
    expect(items.every((VaultItem i) => i.vaultId == kPersonalVaultId), isTrue);
    expect(items.first.created, now);
    expect(items.first.updated, now);
    expect(items.first.history, isEmpty);
    expect(items.first.id, isNot(items.last.id));
    expect(
      vault.snapshot!.tagRegistry.map((TagRegistryEntry e) => e.name),
      contains('work'),
    );
  });

  test('an export is remembered newest first, at most ten', () {
    final RecordExport record = RecordExport(vault);
    for (int i = 0; i < 12; i++) {
      record(
        ExportRecord(
          at: now.add(Duration(minutes: i)),
          format: 'csv',
          scope: 'All Vaults',
          itemCount: i,
          fileName: 'keeperpass-all-vaults.csv',
        ),
      );
    }
    final List<ExportRecord> history = vault.snapshot!.exportHistory;
    expect(history, hasLength(kExportHistoryLimit));
    expect(history.first.itemCount, 11);
    expect(history.last.itemCount, 2);
  });

  test('export file names as the web: keeperpass-<slug>.csv', () {
    expect(exportFileName('all-vaults'), 'keeperpass-all-vaults.csv');
    expect(exportFileName('My Vault'), 'keeperpass-my-vault.csv');
    expect(exportFileName('  Work & Life! '), 'keeperpass-work-life.csv');
  });
}
