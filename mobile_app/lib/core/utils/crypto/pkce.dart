import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// PKCE (RFC 7636) helpers for Dropbox's Authorization Code flow — the web's
/// `core/providers/dropbox/pkce.ts`.

String _base64Url(List<int> bytes) =>
    base64Url.encode(bytes).replaceAll(RegExp(r'=+$'), '');

/// Cryptographically random and URL-safe: 64 bytes give an 86-character
/// verifier (the spec allows 43–128).
String randomUrlSafe(int byteLength, {Random? random}) {
  final Random source = random ?? Random.secure();
  return _base64Url(List<int>.generate(byteLength, (_) => source.nextInt(256)));
}

/// `BASE64URL(SHA256(verifier))` — the `S256` challenge.
String codeChallengeS256(String verifier) =>
    _base64Url(sha256.convert(utf8.encode(verifier)).bytes);
