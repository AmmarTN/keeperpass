import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/theme_preference.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/core/usecases/audit/run_audit.dart';
import 'package:keeperpass/core/usecases/auth/reconnect.dart';
import 'package:keeperpass/core/usecases/common/get_country_names.dart';
import 'package:keeperpass/core/usecases/common/get_icon_catalog.dart';
import 'package:keeperpass/core/usecases/common/get_relative_time_formatter.dart';
import 'package:keeperpass/core/usecases/common/get_saved_locale.dart';
import 'package:keeperpass/core/usecases/common/get_theme_preference.dart';
import 'package:keeperpass/core/usecases/common/save_locale.dart';
import 'package:keeperpass/core/usecases/common/save_theme_preference.dart';
import 'package:keeperpass/core/usecases/data/import_items.dart';
import 'package:keeperpass/core/usecases/data/record_export.dart';
import 'package:keeperpass/core/usecases/generator/generate_secret.dart';
import 'package:keeperpass/core/usecases/generator/get_word_list.dart';
import 'package:keeperpass/core/usecases/items/create_item.dart';
import 'package:keeperpass/core/usecases/items/delete_history_entry.dart';
import 'package:keeperpass/core/usecases/items/delete_items.dart';
import 'package:keeperpass/core/usecases/items/move_items.dart';
import 'package:keeperpass/core/usecases/items/restore_history_entry.dart';
import 'package:keeperpass/core/usecases/items/toggle_favourite.dart';
import 'package:keeperpass/core/usecases/items/update_item.dart';
import 'package:keeperpass/core/usecases/recent/get_recent_items.dart';
import 'package:keeperpass/core/usecases/recent/record_recent_item.dart';
import 'package:keeperpass/core/usecases/recent/watch_recent_items.dart';
import 'package:keeperpass/core/usecases/settings/apply_privacy_settings.dart';
import 'package:keeperpass/core/usecases/settings/get_block_screenshots.dart';
import 'package:keeperpass/core/usecases/settings/get_clipboard_clear_delay.dart';
import 'package:keeperpass/core/usecases/settings/get_hide_in_switcher.dart';
import 'package:keeperpass/core/usecases/settings/save_block_screenshots.dart';
import 'package:keeperpass/core/usecases/settings/save_clipboard_clear_delay.dart';
import 'package:keeperpass/core/usecases/settings/save_hide_in_switcher.dart';
import 'package:keeperpass/core/usecases/tags/add_tag.dart';
import 'package:keeperpass/core/usecases/tags/delete_tags.dart';
import 'package:keeperpass/core/usecases/tags/rename_tag.dart';
import 'package:keeperpass/core/usecases/vault/change_secret.dart';
import 'package:keeperpass/core/usecases/vault/check_newer_version.dart';
import 'package:keeperpass/core/usecases/vault/connect_migration_target.dart';
import 'package:keeperpass/core/usecases/vault/get_migration_targets.dart';
import 'package:keeperpass/core/usecases/vault/move_vault.dart';
import 'package:keeperpass/core/usecases/vault/reload_vault.dart';
import 'package:keeperpass/core/usecases/vault/save_vault.dart';
import 'package:keeperpass/core/usecases/vaults/add_vault.dart';
import 'package:keeperpass/core/usecases/vaults/delete_vaults.dart';
import 'package:keeperpass/core/usecases/vaults/rename_vault.dart';
import 'package:keeperpass/core/utils/crypto/sha1.dart';
import 'package:keeperpass/core/utils/icons/icon_catalog.dart';
import 'package:keeperpass/core/utils/text/relative_time.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/clipboard_local_data_source.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/history_entry.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/repositories/breach_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/bundled_data_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/locale_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/recent_items_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/theme_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/camera_permission_service.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/infrastructure/services/file_service.dart';
import 'package:keeperpass/infrastructure/services/link_service.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';
import 'package:keeperpass/infrastructure/services/privacy_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/bottom_nav_bar/bottom_nav_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/connectivity/connectivity_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/language/language_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/lock/lock_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/theme/theme_cubit.dart';
import 'package:keeperpass/presentation/features/change_secret/cubit/change_secret_cubit.dart';
import 'package:keeperpass/presentation/features/codes/cubit/codes_cubit.dart';
import 'package:keeperpass/presentation/features/data_io/cubit/export_cubit.dart';
import 'package:keeperpass/presentation/features/data_io/cubit/import_cubit.dart';
import 'package:keeperpass/presentation/features/edit_item/cubit/edit_item_cubit.dart';
import 'package:keeperpass/presentation/features/generator/cubit/generator_cubit.dart';
import 'package:keeperpass/presentation/features/item_detail/cubit/item_detail_cubit.dart';
import 'package:keeperpass/presentation/features/move_vault/cubit/move_vault_cubit.dart';
import 'package:keeperpass/presentation/features/scan_qr/cubit/scan_cubit.dart';
import 'package:keeperpass/presentation/features/scan_qr/widgets/scan_camera.dart';
import 'package:keeperpass/presentation/features/security/cubit/security_cubit.dart';
import 'package:keeperpass/presentation/features/settings/cubit/settings_cubit.dart';
import 'package:keeperpass/presentation/features/tags/cubit/tags_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_cubit.dart';
import 'package:keeperpass/presentation/features/vaults/cubit/my_vaults_cubit.dart';

import 'fake_vault_layer.dart';
import 'screen_states.dart';

/// Breach lookups answered from a set of compromised passwords; with a
/// [gate], every lookup waits until it opens (a check in progress).
class FakeBreachRepository implements IBreachRepository {
  final Set<String> compromised = <String>{};
  Failure? failure;
  int lookups = 0;
  Completer<void>? gate;

  @override
  Future<Either<Failure, bool>> isCompromised(String hash) async {
    lookups++;
    await gate?.future;
    final Failure? failure = this.failure;
    if (failure != null) return Left(failure);
    return Right(compromised.map(sha1Hex).contains(hash));
  }
}

/// Recently Used in memory.
class FakeRecentItemsRepository implements IRecentItemsRepository {
  final StreamController<List<String>> _changes =
      StreamController<List<String>>.broadcast();

  @override
  List<String> ids = <String>[];

  @override
  Stream<List<String>> get changes => _changes.stream;

  @override
  Future<Either<Failure, Unit>> record(String id) async {
    ids = <String>[id, ...ids.where((String e) => e != id)];
    _changes.add(ids);
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> forget(Iterable<String> gone) async {
    ids = ids.where((String id) => !gone.contains(id)).toList();
    _changes.add(ids);
    return const Right(unit);
  }
}

/// A clipboard that remembers what was copied, and whether as a secret.
class FakeClipboard implements IClipboardLocalDataSource {
  final List<String> copied = <String>[];
  final List<bool> sensitive = <bool>[];
  final List<Duration?> expiries = <Duration?>[];
  final List<String> cleared = <String>[];

  /// Something else was copied since (the clear must leave it).
  bool replaced = false;

  @override
  Future<String?> copy(
    String text, {
    required bool sensitive,
    Duration? expiresIn,
  }) async {
    copied.add(text);
    this.sensitive.add(sensitive);
    expiries.add(expiresIn);
    replaced = false;
    return 'copy-${copied.length}';
  }

  @override
  Future<bool> clearIfOurs(String marker) async {
    if (replaced || marker != 'copy-${copied.length}') return false;
    cleared.add(marker);
    return true;
  }
}

/// The app-switcher cover and screenshot blocking, as last applied.
class FakePrivacy extends PrivacyService {
  bool? hideInSwitcher;
  bool? blockScreenshots;

  @override
  Future<void> apply({
    required bool hideInSwitcher,
    required bool blockScreenshots,
  }) async {
    this.hideInSwitcher = hideInSwitcher;
    this.blockScreenshots = blockScreenshots;
  }
}

/// Camera access as the phone would answer: [access] until asked, then
/// [answer]; Settings opened count.
class FakeCameraPermission extends CameraPermissionService {
  CameraAccess access = CameraAccess.askable;
  CameraAccess answer = CameraAccess.allowed;
  int asked = 0;
  int settingsOpened = 0;

  /// While set, reading camera access waits for it.
  Completer<void>? holdStatus;

  @override
  Future<CameraAccess> status() async {
    await holdStatus?.future;
    return access;
  }

  @override
  Future<CameraAccess> request() async {
    asked++;
    return access = answer;
  }

  @override
  Future<void> openSettings() async => settingsOpened++;
}

/// A camera with no picture: [show] is a QR code read, [fail] a problem.
class StillCamera implements ScanCamera {
  final StreamController<String> _reads = StreamController<String>.broadcast();
  final StreamController<ScanCameraProblem> _problems =
      StreamController<ScanCameraProblem>.broadcast();
  final ValueNotifier<bool?> _light = ValueNotifier<bool?>(false);
  int starts = 0;
  int stops = 0;
  bool disposed = false;

  void show(String raw) => _reads.add(raw);

  void fail(ScanCameraProblem problem) => _problems.add(problem);

  /// A camera without a light.
  void noLight() => _light.value = null;

  @override
  Widget view(BuildContext context) =>
      const ColoredBox(color: Color(0xFF000000));

  @override
  Stream<String> get reads => _reads.stream;

  @override
  Stream<ScanCameraProblem> get problems => _problems.stream;

  @override
  ValueListenable<bool?> get light => _light;

  @override
  Future<void> toggleLight() async {
    final bool? on = _light.value;
    if (on != null) _light.value = !on;
  }

  @override
  Future<void> start() async => starts++;

  @override
  Future<void> stop() async => stops++;

  @override
  Future<void> dispose() async => disposed = true;
}

/// The theme kept on the phone, in memory.
class MemoryThemeRepository implements IThemeRepository {
  ThemePreference saved = ThemePreference.auto;

  @override
  Future<Either<Failure, ThemePreference>> getThemePreference() async =>
      Right(saved);

  @override
  Future<Either<Failure, Unit>> saveThemePreference(
    ThemePreference preference,
  ) async {
    saved = preference;
    return const Right(unit);
  }
}

/// The language kept on the phone, in memory.
class MemoryLocaleRepository implements ILocaleRepository {
  String? saved;

  @override
  Future<Either<Failure, String?>> getSavedLocale() async => Right(saved);

  @override
  Future<Either<Failure, Unit>> saveLocale(String localeCode) async {
    saved = localeCode;
    return const Right(unit);
  }
}

/// The file picker and share sheet: [picked] is what the picker hands
/// back; [shared] records each file given to the sheet.
class FakeFiles extends FileService {
  FakeFiles() : super(LockService());

  PickedTextFile? picked;
  final List<({String fileName, String content, String mimeType})> shared =
      <({String fileName, String content, String mimeType})>[];

  /// How many times the picker opened; while [holdPick] is set, it stays up.
  int picks = 0;
  Completer<void>? holdPick;

  @override
  Future<PickedTextFile?> pickText(List<String> extensions) async {
    picks++;
    await holdPick?.future;
    return picked;
  }

  @override
  Future<void> shareText({
    required String fileName,
    required String content,
    required String mimeType,
    void Function()? onHandedOver,
  }) async {
    shared.add((fileName: fileName, content: content, mimeType: mimeType));
    onHandedOver?.call();
  }
}

class FakeLinks extends LinkService {
  final List<Uri> opened = <Uri>[];

  @override
  Future<bool> open(Uri uri) async {
    opened.add(uri);
    return true;
  }
}

/// The bundled tables, read from the repository's assets.
class FileBundledData implements IBundledDataRepository {
  Map<String, dynamic> _read(String name) =>
      jsonDecode(File('assets/i18n/$name.json').readAsStringSync())
          as Map<String, dynamic>;

  @override
  Future<Either<Failure, RelativeTimeFormatter>> relativeTime() async =>
      Right(RelativeTimeFormatter(_read('relative_time')));

  @override
  Future<Either<Failure, Map<String, dynamic>>> countryNames() async =>
      Right(_read('country_names'));

  @override
  Future<Either<Failure, List<String>>> wordList(String language) async =>
      Right(
        (jsonDecode(File('assets/wordlists/$language.json').readAsStringSync())
                as List<dynamic>)
            .cast<String>(),
      );

  @override
  Future<Either<Failure, List<CatalogIcon>>> iconCatalog() async =>
      Right(parseIconCatalog(_read('icon_catalog')));
}

const String kWorkVaultId = 'vault-work';
const String kWeakPassword = 'abc123';
const String kReusedPassword = 'Correct-Horse-Battery-77';

/// The boards' sample vault (`S3-01-Vault-Home`): 11 items in My Vault and
/// Work, updated today, this week and earlier, three favorites.
VaultSnapshot sampleVault(DateTime now) {
  DateTime ago(int days, [int hours = 0]) =>
      now.subtract(Duration(days: days, hours: hours));
  VaultItem item(
    String id,
    String name,
    String vaultId,
    DateTime updated,
    List<Field> fields, {
    List<String> tags = const <String>[],
    String? icon,
  }) => VaultItem(
    id: id,
    vaultId: vaultId,
    name: name,
    fields: fields,
    tags: tags,
    created: ago(400),
    updated: updated.toUtc(),
    icon: icon,
  );
  Field f(String name, FieldType type, String value) =>
      Field.of(name: name, type: type, value: value);

  return VaultSnapshot(
    vaults: <Vault>[
      Vault(id: kPersonalVaultId, name: 'My Vault', created: ago(400)),
      Vault(id: kWorkVaultId, name: 'Work', created: ago(300)),
    ],
    items: <VaultItem>[
      item(
        'github',
        'GitHub',
        kWorkVaultId,
        ago(0, 1),
        <Field>[
          f('Username', FieldType.username, 'janedoe-dev'),
          f('Password', FieldType.password, 'Gh-very-long-unique-passphrase-1'),
          f('Authenticator Code', FieldType.totp, 'JBSWY3DPEHPK3PXP'),
          f('Website', FieldType.url, 'https://github.com'),
        ],
        tags: <String>['work', 'dev'],
      ),
      item('wifi', 'Home Wi-Fi', kPersonalVaultId, ago(0, 2), <Field>[
        f('Network name', FieldType.text, 'Doe-Home-5G'),
        f('Password', FieldType.password, 'Wifi-strong-passphrase-at-home-9'),
      ], icon: 'wifi'),
      item(
        'netflix',
        'Netflix',
        kPersonalVaultId,
        ago(0, 3),
        <Field>[
          f('Email', FieldType.email, 'jane.doe92@example.com'),
          f('Password', FieldType.password, kWeakPassword),
        ],
        tags: <String>['entertainment'],
      ),
      item('visa', 'Visa', kPersonalVaultId, ago(2), <Field>[
        f('Cardholder', FieldType.text, 'Jane Doe'),
        f('Card number', FieldType.credit, '4111111111111111'),
      ], icon: 'credit'),
      item(
        'slack',
        'Slack',
        kWorkVaultId,
        ago(3),
        <Field>[
          f('Username', FieldType.username, 'jane.dev'),
          f('Password', FieldType.password, 'Slack-unique-long-passphrase-42'),
        ],
        tags: <String>['work', 'dev'],
      ),
      item(
        'amazon',
        'Amazon',
        kPersonalVaultId,
        ago(4),
        <Field>[
          f('Email', FieldType.email, 'jane.doe92@example.com'),
          f('Password', FieldType.password, 'Amazon-unique-long-passphrase-8'),
        ],
        tags: <String>['shopping'],
      ),
      item(
        'instagram',
        'Instagram',
        kPersonalVaultId,
        ago(5),
        <Field>[
          f('Username', FieldType.username, 'jane.doe.photos'),
          f('Password', FieldType.password, kReusedPassword),
        ],
        tags: <String>['social'],
      ),
      item(
        'gitlab',
        'GitLab',
        kWorkVaultId,
        ago(20),
        <Field>[
          f('Username', FieldType.username, 'janedoe-dev'),
          f('Password', FieldType.password, 'Gl-very-long-unique-passphrase-2'),
        ],
        tags: <String>['work', 'dev'],
      ),
      item(
        'docker',
        'Docker Hub',
        kWorkVaultId,
        ago(30),
        <Field>[
          f('Username', FieldType.username, 'devjane'),
          f('Password', FieldType.password, 'Docker-unique-long-passphrase-3'),
        ],
        tags: <String>['work', 'dev'],
      ),
      item(
        'facebook',
        'Facebook',
        kPersonalVaultId,
        ago(40),
        <Field>[
          f('Username', FieldType.username, 'jane.doe92'),
          f('Password', FieldType.password, kReusedPassword),
        ],
        tags: <String>['social'],
      ),
      item(
        'paypal',
        'PayPal',
        kPersonalVaultId,
        ago(50),
        <Field>[
          f('Email', FieldType.email, 'jane.doe92@example.com'),
          f('Password', FieldType.password, 'PayPal-unique-long-passphrase-5'),
          f('Website', FieldType.url, 'paypal.com'),
        ],
        tags: <String>['finance'],
      ),
    ],
    favouriteIds: <String>['github', 'wifi', 'paypal'],
  );
}

/// "Today, 9:41 AM · 4 minutes ago" on the item boards.
final DateTime kItemBoardsNow = DateTime(2026, 10, 29, 9, 45);

/// The password Netflix, Instagram and Facebook share (`S4-13`).
const String kSharedPassword = 'Sunset-Lake-Shared-2019';

/// Facebook's password in a known breach.
const String kBreachedPassword = 'Tr0ub4dor&3-Breached';

/// The Security boards' vault (`S4-13`): 23 items, 16 of them holding a
/// password; Netflix and Spotify weak, Netflix, Instagram and Facebook
/// sharing one password, Facebook's other one in a breach — 4 flagged, 75%.
/// The boards' sample cannot happen under the audit's rules (items sharing
/// a password are weak or breached together), so Netflix and Facebook hold
/// two passwords.
VaultSnapshot securityBoardsVault(DateTime now) {
  int age = 0;
  VaultItem item(
    String id,
    String name,
    List<Field> fields, {
    List<String> tags = const <String>[],
    String? icon,
  }) => VaultItem(
    id: id,
    vaultId: kPersonalVaultId,
    name: name,
    fields: fields,
    tags: tags,
    icon: icon,
    created: now.subtract(const Duration(days: 500)).toUtc(),
    updated: now.subtract(Duration(days: age++)).toUtc(),
  );
  Field f(String name, FieldType type, String value) =>
      Field.of(name: name, type: type, value: value);
  VaultItem login(String id, String name, String password) =>
      item(id, name, <Field>[
        f('Username', FieldType.username, 'jane.doe'),
        f('Password', FieldType.password, password),
      ]);

  return VaultSnapshot(
    vaults: <Vault>[
      Vault(id: kPersonalVaultId, name: 'My Vault', created: now),
    ],
    items: <VaultItem>[
      item(
        'netflix',
        'Netflix',
        <Field>[
          f('Email', FieldType.email, 'jane.doe92@example.com'),
          f('Password', FieldType.password, kWeakPassword),
          f('Account Password', FieldType.password, kSharedPassword),
          f('Website', FieldType.url, 'netflix.com'),
        ],
        tags: <String>['entertainment'],
      ),
      item(
        'spotify',
        'Spotify',
        <Field>[
          f('Email', FieldType.email, 'jane.doe92@example.com'),
          f('Password', FieldType.password, 'spotify'),
        ],
        tags: <String>['entertainment'],
      ),
      item(
        'instagram',
        'Instagram',
        <Field>[
          f('Username', FieldType.username, 'jane.doe.photos'),
          f('Password', FieldType.password, kSharedPassword),
        ],
        tags: <String>['social'],
      ),
      item(
        'facebook',
        'Facebook',
        <Field>[
          f('Username', FieldType.username, 'jane.doe92'),
          f('Password', FieldType.password, kSharedPassword),
          f('Old Password', FieldType.password, kBreachedPassword),
        ],
        tags: <String>['social'],
      ),
      for (final String name in <String>[
        'GitHub',
        'GitLab',
        'Slack',
        'Docker Hub',
        'Amazon',
        'PayPal',
        'Dropbox',
        'Notion',
        'Figma',
        'Linear',
        'Home Wi-Fi',
        'Router',
      ])
        login(
          name.toLowerCase().replaceAll(' ', '-'),
          name,
          '$name-unique-long-passphrase-42',
        ),
      item('visa', 'Visa', <Field>[
        f('Card number', FieldType.credit, '4111111111111111'),
      ], icon: 'credit'),
      item('passport', 'Passport', <Field>[
        f('Passport Number', FieldType.text, 'X1234567'),
      ]),
      item('notes', 'Notes', <Field>[f('Note', FieldType.note, 'Hello')]),
      item('bank', 'Savings Account', <Field>[
        f('IBAN', FieldType.text, 'DE89370400440532013000'),
      ]),
      item('aws', 'AWS Console', <Field>[
        f('Authenticator Code', FieldType.totp, kTotpKey),
      ]),
      item('codes', 'Recovery Codes', <Field>[
        f('Codes', FieldType.note, 'aaaa-bbbb'),
      ]),
      item('license', 'License Key', <Field>[f('Key', FieldType.pin, '4821')]),
    ],
  );
}

/// The 2FA key on the item boards' GitHub and AWS Console.
const String kTotpKey = 'JBSWY3DPEHPK3PXP';

/// GitHub's password, revealed on `S3-20` and in large type on `S3-21`.
const String kGitHubPassword = 'Tq7#vR2m!xW9pL4@kZ8s';

/// The items on the item boards (`S3-19` … `S3-36`).
VaultSnapshot itemBoardsVault(DateTime now) {
  DateTime at(int month, int day, [int hour = 9, int minute = 41]) =>
      DateTime(2026, month, day, hour, minute).toUtc();
  Field f(String name, FieldType type, String value) =>
      Field.of(name: name, type: type, value: value);
  VaultItem item(
    String id,
    String name,
    List<Field> fields, {
    String vaultId = kPersonalVaultId,
    List<String> tags = const <String>[],
    DateTime? created,
    DateTime? updated,
    List<HistoryEntry> history = const <HistoryEntry>[],
    String? icon,
  }) => VaultItem(
    id: id,
    vaultId: vaultId,
    name: name,
    fields: fields,
    tags: tags,
    created: created ?? at(1, 9),
    updated: updated ?? now.subtract(const Duration(days: 2)).toUtc(),
    history: history,
    icon: icon,
  );
  final List<Field> gitHubThen = <Field>[
    f('Username', FieldType.username, 'janedoe-dev'),
    f('Password', FieldType.password, 'old-password-16c'),
    f('Website', FieldType.url, 'github.com'),
  ];

  return VaultSnapshot(
    vaults: <Vault>[
      Vault(id: kPersonalVaultId, name: 'My Vault', created: at(1, 1)),
      Vault(id: kWorkVaultId, name: 'Work', created: at(1, 1)),
    ],
    items: <VaultItem>[
      item(
        'github',
        'GitHub',
        <Field>[
          f('Username', FieldType.username, 'janedoe-dev'),
          f('Password', FieldType.password, kGitHubPassword),
          f('Website', FieldType.url, 'github.com'),
          f('Authenticator Code', FieldType.totp, kTotpKey),
        ],
        vaultId: kWorkVaultId,
        tags: <String>['work', 'dev'],
        created: at(8, 23, 18, 54),
        updated: at(10, 29),
        history: <HistoryEntry>[
          HistoryEntry(
            updated: at(10, 21, 18, 54),
            name: 'GitHub',
            fields: gitHubThen,
            tags: <String>['work', 'dev'],
          ),
          HistoryEntry(
            updated: at(8, 23, 18, 54),
            name: 'GitHub',
            fields: gitHubThen,
            tags: <String>['work'],
          ),
        ],
      ),
      item('visa', 'Visa', <Field>[
        f('Card Number', FieldType.credit, '4111111111111111'),
        f('Cardholder', FieldType.text, 'Jane Doe'),
        f('Expires On', FieldType.month, '2029-08'),
        f('CVC', FieldType.pin, '123'),
        f('PIN', FieldType.pin, '1234'),
      ], icon: 'credit'),
      item('savings', 'Savings Account', <Field>[
        f('Account Holder', FieldType.text, 'Jane Doe'),
        f('IBAN', FieldType.text, 'DE89370400440532013000'),
        f('BIC', FieldType.text, 'COBADEFFXXX'),
        f('Card PIN', FieldType.pin, '4321'),
      ], icon: 'bank'),
      item('wifi', 'Home Wi-Fi', <Field>[
        f('Network Name', FieldType.text, 'Doe-Home-5G'),
        f('Password', FieldType.password, 'Wifi-strong-passphrase-at-home-9'),
      ], icon: 'wifi'),
      item('passport', 'Passport', <Field>[
        f('Full Name', FieldType.text, 'Jane Doe'),
        f('Passport Number', FieldType.text, '561942718'),
        f('Issuing Country', FieldType.text, 'United States'),
        f('Date of Birth', FieldType.date, '1992-04-12'),
        f('Place of Birth', FieldType.text, 'Portland, Oregon'),
        f('Issued On', FieldType.date, '2021-06-03'),
        f('Expires On', FieldType.date, '2031-06-02'),
      ], icon: 'passport'),
      item('router', 'Router Setup', <Field>[
        f(
          'Formatted Note',
          FieldType.note,
          '# Guest network\n- The router is in the hallway cupboard',
        ),
      ], icon: 'note'),
      item(
        'gitlab',
        'GitLab',
        <Field>[
          f('Username', FieldType.username, 'janedoe-dev'),
          f('SSH / Private Key', FieldType.sshKey, 'line-1\nline-2\nline-3'),
          f(
            'Recovery Codes',
            FieldType.recoveryCodes,
            '7fq2-9kd1\nm4xz-p8r2\n\nq9w3-ht6v',
          ),
        ],
        vaultId: kWorkVaultId,
        tags: <String>['work', 'dev'],
      ),
      item(
        'apple',
        'Apple',
        <Field>[
          f('Email', FieldType.email, 'jane.doe92@icloud.com'),
          f('Trusted Phone', FieldType.phone, '+1 503-555-0142'),
          f('Birthday', FieldType.date, '1992-04-12'),
          f('Recovery Email', FieldType.email, ''),
        ],
        tags: <String>['personal'],
      ),
      item('aws', 'AWS Console', <Field>[
        f('Authenticator Code', FieldType.totp, kTotpKey),
      ], icon: 'totp'),
      item('bad-key', 'Old Server', <Field>[
        f('Host', FieldType.ipHost, 'srv.example.com'),
        f('Authenticator Code', FieldType.totp, 'not a key!'),
      ]),
    ],
    favouriteIds: <String>['github'],
  );
}

/// The Codes boards' vault (`S4-01` … `S4-05`): AWS Console and Cloudflare
/// in My Vault with only a setup key, GitHub in Work with its login.
/// [invalidCloudflare]: Cloudflare's key makes no code (`S4-04`).
VaultSnapshot codesBoardsVault(DateTime now, {bool invalidCloudflare = false}) {
  Field f(String name, FieldType type, String value) =>
      Field.of(name: name, type: type, value: value);
  VaultItem item(
    String id,
    String name,
    List<Field> fields, {
    String vaultId = kPersonalVaultId,
    String? icon,
  }) => VaultItem(
    id: id,
    vaultId: vaultId,
    name: name,
    fields: fields,
    icon: icon,
    created: now.subtract(const Duration(days: 90)).toUtc(),
    updated: now.subtract(const Duration(days: 2)).toUtc(),
  );
  return VaultSnapshot(
    vaults: <Vault>[
      Vault(id: kPersonalVaultId, name: 'My Vault', created: now.toUtc()),
      Vault(id: kWorkVaultId, name: 'Work', created: now.toUtc()),
    ],
    items: <VaultItem>[
      item('github', 'GitHub', <Field>[
        f('Username', FieldType.username, 'janedoe-dev'),
        f('Password', FieldType.password, kGitHubPassword),
        f('Website', FieldType.url, 'github.com'),
        f('Authenticator Code', FieldType.totp, kTotpKey),
      ], vaultId: kWorkVaultId),
      item('cloudflare', 'Cloudflare', <Field>[
        f(
          'Authenticator Code',
          FieldType.totp,
          invalidCloudflare ? 'not a key!' : 'GEZDGNBVGY3TQOJQ',
        ),
      ], icon: 'totp'),
      item('aws', 'AWS Console', <Field>[
        f('Authenticator Code', FieldType.totp, 'MFRGGZDFMZTWQ2LK'),
      ], icon: 'totp'),
      item('notes', 'Server notes', <Field>[
        f('Note', FieldType.note, 'Rotate keys in spring.'),
        f('Authenticator Code', FieldType.totp, ''),
      ]),
    ],
  );
}

/// The Scan-QR boards' vault: the Codes boards' items and a Dropbox login
/// without a 2FA code (board `S6-29`: "Dropbox already has a login, so the
/// code joins it").
VaultSnapshot scanBoardsVault(DateTime now) {
  final VaultSnapshot codes = codesBoardsVault(now);
  return codes.copyWith(
    items: <VaultItem>[
      ...codes.items,
      VaultItem(
        id: 'dropbox',
        vaultId: kPersonalVaultId,
        name: 'Dropbox',
        fields: <Field>[
          Field.of(
            name: 'Username',
            type: FieldType.username,
            value: 'jane.doe92@example.com',
          ),
          Field.of(
            name: 'Password',
            type: FieldType.password,
            value: 'Db-long-unique-passphrase-2',
          ),
          Field.of(name: 'Website', type: FieldType.url, value: 'dropbox.com'),
        ],
        created: now.subtract(const Duration(days: 90)).toUtc(),
        updated: now.subtract(const Duration(days: 2)).toUtc(),
      ),
    ],
  );
}

/// The QR code on the boards (`S6-29`): Dropbox, jane.doe92@example.com.
const String kDropboxQr =
    'otpauth://totp/Dropbox:jane.doe92%40example.com'
    '?secret=JBSWY3DPEHPK3PXP&issuer=Dropbox';

/// Everything the Vault tab reads, on the Part 5 fakes, with the sample
/// vault open (or [snapshot]).
class VaultWorld {
  VaultWorld({DateTime? now, this._snapshot})
    : now = now ?? DateTime(2026, 10, 31, 9, 41);

  final DateTime now;
  final VaultSnapshot? _snapshot;
  final FakeAuthRepository auth = FakeAuthRepository();
  final FakeStorageRepository storage = FakeStorageRepository();
  final VaultSessionService vault = VaultSessionService();
  final SwitchableNetwork network = SwitchableNetwork();
  final FakeBreachRepository breaches = FakeBreachRepository()
    ..compromised.add(kReusedPassword);
  final FakeRecentItemsRepository recent = FakeRecentItemsRepository();
  final FakeClipboard clipboard = FakeClipboard();

  /// The real service over [clipboard] and [lockSettings]; KeeperPass is
  /// open unless [appOpen] says otherwise.
  bool appOpen = true;
  late final ClipboardService clipboardService = ClipboardService(
    clipboard,
    lockSettings,
    isOpen: () => appOpen,
  );
  final FakeLinks links = FakeLinks();
  final FakeFiles files = FakeFiles();
  final MemoryLockSettings lockSettings = MemoryLockSettings();
  final FakePrivacy privacy = FakePrivacy();
  final FakeCameraPermission camera = FakeCameraPermission();
  final MemoryThemeRepository themes = MemoryThemeRepository();
  final MemoryLocaleRepository locales = MemoryLocaleRepository();
  late final ThemeCubit theme = ThemeCubit(
    GetThemePreference(themes),
    SaveThemePreference(themes),
  );
  late final LanguageCubit language = LanguageCubit(
    GetSavedLocale(locales),
    SaveLocale(locales),
  );
  final FakeVaultCipher cipher = FakeVaultCipher();

  late final SessionCubit session = buildSessionCubit(auth, storage, vault);
  late final ConnectivityCubit connectivity = ConnectivityCubit(
    network,
    offlineConfirmation: Duration.zero,
  );
  late final SyncCubit sync = SyncCubit(
    SaveVault(auth, storage, cipher, vault, now: () => now),
    ReloadVault(auth, storage, cipher, vault, now: () => now),
    CheckNewerVersion(auth, storage),
    Reconnect(auth, LockService()),
    vault,
    connectivity,
    now: () => now,
  );
  late final AuditCubit audit = AuditCubit(
    RunAudit(vault, breaches),
    session,
    vault,
    now: () => now,
  );
  late final LockCubit lock = stubLockCubit(session);
  late final BottomNavCubit bottomNav = BottomNavCubit();
  late final VaultListCubit list = VaultListCubit(
    vault,
    sync,
    audit,
    GetRecentItems(recent),
    WatchRecentItems(recent),
    RecordRecentItem(recent),
    ToggleFavourite(vault),
    MoveItems(vault),
    DeleteItems(vault, recent),
    AddVault(vault, now: () => now),
    clipboardService,
    links,
    now: () => now,
  );

  /// The item screen's cubit (not opened yet).
  ItemDetailCubit itemCubit() => ItemDetailCubit(
    vault,
    sync,
    audit,
    RecordRecentItem(recent),
    ToggleFavourite(vault),
    MoveItems(vault),
    DeleteItems(vault, recent),
    AddVault(vault, now: () => now),
    RestoreHistoryEntry(vault, now: () => now),
    DeleteHistoryEntry(vault),
    GetRelativeTimeFormatter(FileBundledData()),
    GetCountryNames(FileBundledData()),
    clipboardService,
    links,
    now: () => now,
  );

  /// New item / Edit item's cubit (not started yet).
  EditItemCubit editCubit() => EditItemCubit(
    vault,
    sync,
    audit,
    CreateItem(vault, now: () => now),
    UpdateItem(vault, now: () => now),
    GetIconCatalog(FileBundledData()),
    GetCountryNames(FileBundledData()),
  );

  /// Scan a QR code's cubit (not opened yet); its live code at [now].
  ScanCubit scanCubit() => ScanCubit(
    vault,
    sync,
    audit,
    CreateItem(vault, now: () => now),
    UpdateItem(vault, now: () => now),
    camera,
    LockService(),
    now: () => now,
  );

  /// The Codes tab's cubit; its codes are made at [now].
  CodesCubit codesCubit() => CodesCubit(
    vault,
    RecordRecentItem(recent),
    clipboardService,
    now: () => now,
  );

  /// My Vaults' cubit.
  MyVaultsCubit myVaultsCubit() => MyVaultsCubit(
    vault,
    sync,
    AddVault(vault, now: () => now),
    RenameVault(vault),
    DeleteVaults(vault),
  );

  /// Tags' cubit; changes are dated [now].
  TagsCubit tagsCubit() => TagsCubit(
    vault,
    sync,
    AddTag(vault, now: () => now),
    RenameTag(vault, now: () => now),
    DeleteTags(vault, now: () => now),
  );

  /// The Security tab's cubit; "Last checked" is told at [at] (the boards'
  /// 9:45, four minutes after the check), else at [now].
  SecurityCubit securityCubit({DateTime? at}) =>
      SecurityCubit(vault, audit, connectivity, now: () => at ?? now);

  /// The Generate sheet's cubit, on the real word lists.
  GeneratorCubit generatorCubit() =>
      GeneratorCubit(GetWordList(FileBundledData()), clipboardService);

  /// The Settings tab's cubit (not loaded yet).
  SettingsCubit settingsCubit() => SettingsCubit(
    vault,
    GetClipboardClearDelay(lockSettings),
    SaveClipboardClearDelay(lockSettings),
    GetHideInSwitcher(lockSettings),
    SaveHideInSwitcher(lockSettings),
    GetBlockScreenshots(lockSettings),
    SaveBlockScreenshots(lockSettings),
    ApplyPrivacySettings(lockSettings, privacy),
    GetMigrationTargets(auth),
    links,
    now: () => now,
  );

  /// Change secret's cubit, on the real word lists.
  ChangeSecretCubit changeSecretCubit() => ChangeSecretCubit(
    ChangeSecret(auth, storage, cipher, vault, now: () => now),
    GenerateSecret(FileBundledData()),
  );

  /// Move vault's cubit (not started yet).
  MoveVaultCubit moveVaultCubit() => MoveVaultCubit(
    ConnectMigrationTarget(auth, storage, LockService()),
    MoveVault(auth, storage, cipher, vault, now: () => now),
    GenerateSecret(FileBundledData()),
    vault,
    session,
  );

  /// Import's cubit, over [files].
  ImportCubit importCubit() =>
      ImportCubit(files, ImportItems(vault, now: () => now), vault, sync);

  /// Export's cubit, over [files].
  ExportCubit exportCubit() =>
      ExportCubit(vault, files, RecordExport(vault), sync, now: () => now);

  /// Signs in, stores the vault and unlocks it; the audit runs after.
  Future<void> open() async {
    audit.start();
    storage.files[ProviderId.google] = await cipher.encrypt(
      'secret',
      (_snapshot ?? sampleVault(now)).toVaultJson(),
    );
    await session.restore();
    await session.unlock('secret');
    // The audit also starts as the session turns ready; this one is awaited.
    await audit.runFullAudit();
  }

  /// Breach lookups fail as offline.
  void breachesOffline() => breaches.failure = const Failure.networkFailure(
    NetworkFailure.noInternetConnection(),
  );

  List<BlocProvider<dynamic>> get providers => <BlocProvider<dynamic>>[
    BlocProvider<SessionCubit>.value(value: session),
    BlocProvider<ConnectivityCubit>.value(value: connectivity),
    BlocProvider<SyncCubit>.value(value: sync),
    BlocProvider<AuditCubit>.value(value: audit),
    BlocProvider<LockCubit>.value(value: lock),
    BlocProvider<BottomNavCubit>.value(value: bottomNav),
    BlocProvider<VaultListCubit>.value(value: list),
    BlocProvider<ThemeCubit>.value(value: theme),
    BlocProvider<LanguageCubit>.value(value: language),
  ];

  Future<void> close() async {
    await theme.close();
    await language.close();
    await list.close();
    await audit.close();
    await sync.close();
    await lock.close();
    await bottomNav.close();
    await connectivity.close();
    await session.close();
  }
}
