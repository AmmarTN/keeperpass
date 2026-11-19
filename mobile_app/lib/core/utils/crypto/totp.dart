import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// Time-based one-time passwords (RFC 6238, HMAC-SHA1) — the web's
/// `core/otp/totp.ts`.

const String _base32Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

const int kDefaultTotpPeriodSeconds = 30;
const int kDefaultTotpDigits = 6;

/// A setup key with a character outside base32.
class InvalidTotpSecretException implements Exception {
  const InvalidTotpSecretException(this.character);

  final String character;

  @override
  String toString() => '"$character" is not a valid base32 character.';
}

/// Decodes a base32 secret, ignoring padding, whitespace and letter case.
/// Trailing bits that do not complete a byte are dropped.
Uint8List base32ToBytes(String secret) {
  final String normalized = secret
      .replaceAll(RegExp(r'[\s=]'), '')
      .toUpperCase();
  final Uint8List bytes = Uint8List((normalized.runes.length * 5) ~/ 8);

  int buffer = 0;
  int bufferedBits = 0;
  int written = 0;

  for (final int rune in normalized.runes) {
    final String character = String.fromCharCode(rune);
    final int index = _base32Alphabet.indexOf(character);
    if (index == -1 || character.length != 1) {
      throw InvalidTotpSecretException(character);
    }

    // The web works in 32-bit integers; only the low bits are ever read.
    buffer = ((buffer << 5) | index) & 0xFFFFFFFF;
    bufferedBits += 5;

    if (bufferedBits >= 8) {
      bufferedBits -= 8;
      bytes[written++] = (buffer >> bufferedBits) & 0xff;
    }
  }

  return bytes;
}

/// The counter the moment [timestampMs] falls into.
int totpCounter(int timestampMs, {int period = kDefaultTotpPeriodSeconds}) =>
    (timestampMs / 1000 / period).floor();

/// How far through the current period [timestampMs] is, from 0 to 1.
double totpProgress(
  int timestampMs, {
  int period = kDefaultTotpPeriodSeconds,
}) => ((timestampMs / 1000) % period) / period;

/// Seconds left in the current period (what the 2FA ring shows).
int totpSecondsLeft(
  int timestampMs, {
  int period = kDefaultTotpPeriodSeconds,
}) => period - ((timestampMs / 1000) % period).floor();

/// The code for [secret] at [timestampMs] (now by default).
String generateTotp(
  String secret, {
  int period = kDefaultTotpPeriodSeconds,
  int digits = kDefaultTotpDigits,
  int? timestampMs,
}) {
  final Uint8List key = base32ToBytes(secret);
  final int counter = totpCounter(
    timestampMs ?? DateTime.now().millisecondsSinceEpoch,
    period: period,
  );
  final ByteData message = ByteData(8)..setUint64(0, counter);
  final List<int> mac = Hmac(
    sha1,
    key,
  ).convert(message.buffer.asUint8List()).bytes;

  // Dynamic truncation: the low nibble of the last byte picks a 4-byte
  // window, its top bit cleared to keep the result positive.
  final int offset = mac[mac.length - 1] & 0x0f;
  final int code =
      ((mac[offset] & 0x7f) << 24) |
      (mac[offset + 1] << 16) |
      (mac[offset + 2] << 8) |
      mac[offset + 3];

  int modulus = 1;
  for (int i = 0; i < digits; i++) {
    modulus *= 10;
  }
  return (code % modulus).toString().padLeft(digits, '0');
}
