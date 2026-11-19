abstract final class Validators {
  static final RegExp _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  static bool isEmail(String value) => _emailPattern.hasMatch(value.trim());

  static bool isStrongEnoughPassword(String value) => value.length >= 8;
}
