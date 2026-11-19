import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/presentation/features/security/cubit/security_view.dart';
import 'package:keeperpass/presentation/features/security/widgets/security_texts.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';

import '../../../helpers/vault_world.dart';

void main() {
  setUpAll(initializeDateFormatting);

  test('time left: fives of seconds, then whole minutes, rounded up', () {
    expect(timeLeftText(const Duration(milliseconds: 300)), 'about 5 seconds');
    expect(timeLeftText(const Duration(seconds: 7)), 'about 10 seconds');
    expect(timeLeftText(const Duration(seconds: 10)), 'about 10 seconds');
    expect(timeLeftText(const Duration(seconds: 58)), 'about 55 seconds');
    expect(timeLeftText(const Duration(seconds: 61)), 'about 2 minutes');
    expect(timeLeftText(const Duration(minutes: 1)), 'about 1 minute');
  });

  test('last checked: just now, today at a time, else the date', () {
    final DateTime at = DateTime(2026, 11, 1, 9, 41);
    expect(
      lastCheckedText(at, at.add(const Duration(seconds: 59)), 'en'),
      'Last checked just now',
    );
    expect(
      lastCheckedText(at, DateTime(2026, 11, 1, 9, 45), 'en'),
      'Last checked today at 9:41 AM',
    );
    expect(
      lastCheckedText(at, DateTime(2026, 11, 2, 0, 5), 'en'),
      'Last checked Nov 1, 2026, 9:41 AM',
    );
  });

  test('“Same as”: up to three names, then a count; own fields alone', () {
    final VaultRow row = buildVaultRow(
      snapshot: securityBoardsVault(DateTime(2026)),
      item: securityBoardsVault(DateTime(2026)).items.first,
      favourite: false,
      findings: const {},
      locale: 'en',
    );
    SecurityRow shared(List<String> names) => SecurityRow(
      row: row,
      kind: SecurityDetailKind.sameAs,
      sharedWith: names,
    );
    expect(detailText(shared(<String>['Instagram'])), 'Same as Instagram');
    expect(detailText(shared(<String>['A', 'B', 'C'])), 'Same as A, B and C');
    expect(
      detailText(shared(<String>['A', 'B', 'C', 'D'])),
      'Same as 4 other items',
    );
    expect(
      detailText(SecurityRow(row: row, kind: SecurityDetailKind.sameAsField)),
      'Same as another password in this item',
    );
    expect(
      detailText(SecurityRow(row: row, kind: SecurityDetailKind.vault)),
      'My Vault',
    );
  });
}
