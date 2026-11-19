/// Every sign-in + storage backend (web `PROVIDER_IDS`). The strings are the
/// web's; they are also what the phone remembers.
enum ProviderId {
  google('google', 'Google', 'Google Drive'),
  dropbox('dropbox', 'Dropbox', 'Dropbox');

  const ProviderId(this.value, this.displayName, this.storageName);

  final String value;

  /// "Google" (web `AuthProvider.displayName`; a proper noun, never
  /// translated).
  final String displayName;

  /// Where the vault lives, as people know it (web `storageName`).
  final String storageName;

  static ProviderId? tryParse(String? value) {
    for (final ProviderId id in values) {
      if (id.value == value) return id;
    }
    return null;
  }
}
