import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_grant.freezed.dart';

/// An access token and the moment it stops being usable (web `TokenGrant`).
@freezed
abstract class TokenGrant with _$TokenGrant {
  const TokenGrant._();

  const factory TokenGrant({
    required String accessToken,

    /// Already shortened by a safety margin. Null when the provider does not
    /// say (Google's SDK): the token is then used until a call is refused.
    DateTime? expiresAt,

    /// Only providers that renew without UI hand one back (Dropbox).
    String? refreshToken,
  }) = _TokenGrant;

  /// At (or past) [expiresAt]; never for a token without an expiry.
  bool isExpiredAt(DateTime now) {
    final DateTime? expiry = expiresAt;
    return expiry != null && !now.isBefore(expiry);
  }
}
