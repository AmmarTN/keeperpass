import 'dart:math' as math;

/// Master password strength (web `core/validation/password-strength.ts`):
/// graded on how much search space the password represents, scored 0–4.

/// Below this score the app refuses a master password.
const int kMinMasterPasswordScore = 2;

/// A score (0–4) and the entropy it came from.
typedef PasswordStrength = ({int score, double entropy});

final List<({RegExp pattern, int size})> _pools =
    <({RegExp pattern, int size})>[
      (pattern: RegExp('[a-z]'), size: 26),
      (pattern: RegExp('[A-Z]'), size: 26),
      (pattern: RegExp('[0-9]'), size: 10),
      (pattern: RegExp('[^a-zA-Z0-9]'), size: 33),
    ];

const List<({double bits, int score})> _thresholds =
    <({double bits, int score})>[
      (bits: 80, score: 4),
      (bits: 60, score: 3),
      (bits: 40, score: 2),
      (bits: 28, score: 1),
    ];

/// Passwords tried in the first second, whatever their entropy.
const Set<String> _trivial = <String>{
  '123456',
  '12345678',
  '123456789',
  '1234567890',
  'password',
  'password1',
  'password123',
  'qwerty',
  'qwerty123',
  'abc123',
  'letmein',
  'welcome',
  'monkey',
  'dragon',
  'iloveyou',
  'admin',
  'administrator',
  'login',
  'passw0rd',
  'p@ssw0rd',
  'master',
  'sunshine',
  'princess',
  'football',
  'baseball',
  'trustno1',
  'superman',
  'starwars',
  'whatever',
  'changeme',
  'secret',
};

/// `String.prototype.codePointAt(index)` — index in UTF-16 code units.
int _codePointAt(String s, int index) {
  final int unit = s.codeUnitAt(index);
  if (unit >= 0xD800 && unit <= 0xDBFF && index + 1 < s.length) {
    final int next = s.codeUnitAt(index + 1);
    if (next >= 0xDC00 && next <= 0xDFFF) {
      return 0x10000 + ((unit - 0xD800) << 10) + (next - 0xDC00);
    }
  }
  return unit;
}

/// Runs of one character and ascending or descending sequences add length
/// without adding search space. Walks UTF-16 code units, as the web does.
double _effectiveLength(String password) {
  double length = 0;
  int? runDirection;
  for (int i = 0; i < password.length; i++) {
    if (i == 0) {
      length += 1;
      continue;
    }
    final int delta = _codePointAt(password, i) - _codePointAt(password, i - 1);
    final bool isRun = delta == 0 || delta == 1 || delta == -1;
    if (isRun && delta == runDirection) {
      length += 0.25;
    } else if (isRun) {
      runDirection = delta;
      length += 0.5;
    } else {
      runDirection = null;
      length += 1;
    }
  }
  return length;
}

int _poolSize(String password) => _pools.fold(
  0,
  (int total, ({RegExp pattern, int size}) pool) =>
      pool.pattern.hasMatch(password) ? total + pool.size : total,
);

PasswordStrength estimatePasswordStrength(String password) {
  if (password.isEmpty || _trivial.contains(password.toLowerCase())) {
    return (score: 0, entropy: 0.0);
  }
  final int pool = _poolSize(password);
  final double entropy = pool > 1
      ? _effectiveLength(password) * (math.log(pool) / math.ln2)
      : 0;
  for (final ({double bits, int score}) threshold in _thresholds) {
    if (entropy >= threshold.bits) {
      return (score: threshold.score, entropy: entropy);
    }
  }
  return (score: 0, entropy: entropy);
}

bool isAcceptableMasterPassword(String password) =>
    estimatePasswordStrength(password).score >= kMinMasterPasswordScore;
