/// Problems the security audit can flag on an item (web `AuditType`). The
/// strings are the web's (they appear in its URLs).
enum AuditType {
  weakPassword('weak_password'),
  reusedPassword('reused_password'),
  compromisedPassword('compromised_password');

  const AuditType(this.value);

  final String value;

  static AuditType? tryParse(String? value) {
    for (final AuditType type in values) {
      if (type.value == value) return type;
    }
    return null;
  }
}
