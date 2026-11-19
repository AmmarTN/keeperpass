import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/utils/crypto/otpauth.dart';

/// The plan's Part 15 rules for reading a 2FA QR code.
void main() {
  OtpauthCode code(String raw) {
    final OtpauthReading reading = readOtpauth(raw);
    expect(reading, isA<OtpauthCode>(), reason: raw);
    return reading as OtpauthCode;
  }

  OtpauthProblem refused(String raw) {
    final OtpauthReading reading = readOtpauth(raw);
    expect(reading, isA<OtpauthRefused>(), reason: raw);
    return (reading as OtpauthRefused).problem;
  }

  group('rule 1: the kind of link', () {
    test('otpauth://totp/ in any capitals', () {
      code('otpauth://totp/Dropbox:jane?secret=JBSWY3DPEHPK3PXP');
      code('OTPAUTH://TOTP/Dropbox:jane?secret=JBSWY3DPEHPK3PXP');
      code('  otpauth://totp/Dropbox?secret=JBSWY3DPEHPK3PXP  ');
    });

    test('counter codes and exports are not supported yet', () {
      expect(
        refused('otpauth://hotp/Acme:jane?secret=JBSWY3DPEHPK3PXP&counter=0'),
        OtpauthProblem.unsupported,
      );
      expect(
        refused('otpauth-migration://offline?data=CjEKCkhlbGxvId6tvu8'),
        OtpauthProblem.unsupported,
      );
    });

    test('anything else is not a 2FA QR code', () {
      for (final String raw in <String>[
        'https://www.dropbox.com/',
        'Hello',
        '',
        'otpauth://steam/Acme?secret=JBSWY3DPEHPK3PXP',
        'otpauth:totp/Acme?secret=JBSWY3DPEHPK3PXP',
        'WIFI:S:Home;T:WPA;P:secret;;',
      ]) {
        expect(refused(raw), OtpauthProblem.notACode, reason: raw);
      }
    });
  });

  group('rule 2: site and account', () {
    test('"Site:account", the issuer parameter winning', () {
      final OtpauthCode found = code(
        'otpauth://totp/Dropbox:jane.doe92%40example.com'
        '?secret=JBSWY3DPEHPK3PXP&issuer=Dropbox',
      );
      expect(found.issuer, 'Dropbox');
      expect(found.account, 'jane.doe92@example.com');

      expect(
        code(
          'otpauth://totp/Old%20Name:jane?secret=JBSWY3DPEHPK3PXP'
          '&issuer=New+Name',
        ).issuer,
        'New Name',
      );
    });

    test('the label\'s site without the parameter; spaces after ":" go', () {
      final OtpauthCode found = code(
        'otpauth://totp/ACME%20Co:%20%20john@example.com'
        '?secret=JBSWY3DPEHPK3PXP',
      );
      expect(found.issuer, 'ACME Co');
      expect(found.account, 'john@example.com');
    });

    test('an encoded colon splits too; only the first one does', () {
      final OtpauthCode found = code(
        'otpauth://totp/Example%3Aalice%3Awork?secret=JBSWY3DPEHPK3PXP',
      );
      expect(found.issuer, 'Example');
      expect(found.account, 'alice:work');
    });

    test('no colon: the account alone; no label: neither', () {
      OtpauthCode found = code(
        'otpauth://totp/jane@example.com?secret=JBSWY3DPEHPK3PXP',
      );
      expect(found.issuer, isNull);
      expect(found.account, 'jane@example.com');

      found = code('otpauth://totp/?secret=JBSWY3DPEHPK3PXP');
      expect(found.issuer, isNull);
      expect(found.account, isNull);

      found = code(
        'otpauth://totp/:jane?secret=JBSWY3DPEHPK3PXP&issuer=%20%20',
      );
      expect(found.issuer, isNull);
      expect(found.account, 'jane');
    });

    test('names are one trimmed line without unsafe characters', () {
      final OtpauthCode found = code(
        'otpauth://totp/x?secret=JBSWY3DPEHPK3PXP'
        '&issuer=%20Drop%0Abox%E2%80%8B%E2%80%AE%20',
      );
      expect(found.issuer, 'Drop box');
    });

    test('a long site name is cut to the item name limit', () {
      final OtpauthCode found = code(
        'otpauth://totp/x?secret=JBSWY3DPEHPK3PXP&issuer=${'a' * 600}',
      );
      expect(found.issuer, 'a' * 500);
    });

    test('text that is not percent-encoded is taken as it is', () {
      final OtpauthCode found = code(
        'otpauth://totp/ACME Co:john@example.com?secret=JBSWY3DPEHPK3PXP',
      );
      expect(found.issuer, 'ACME Co');
      expect(
        code('otpauth://totp/100%:x?secret=JBSWY3DPEHPK3PXP').issuer,
        '100%',
      );
    });
  });

  group('rule 3: the secret', () {
    test('kept as written; spaces, padding and capitals do not matter', () {
      expect(
        code('otpauth://totp/A?secret=jbsw%20y3dp%20ehpk%203pxp').secret,
        'jbsw y3dp ehpk 3pxp',
      );
      expect(
        code('otpauth://totp/A?secret=JBSWY3DPEHPK3PXP%3D%3D%3D').secret,
        'JBSWY3DPEHPK3PXP===',
      );
    });

    test('missing, empty or not base32 is an invalid key', () {
      for (final String raw in <String>[
        'otpauth://totp/A',
        'otpauth://totp/A?secret=',
        'otpauth://totp/A?secret=%20%3D%3D',
        'otpauth://totp/A?secret=JBSWY3DPEHPK3PX1',
        'otpauth://totp/A?secret=JBSW-Y3DP',
        'otpauth://totp/A?secret=${'A' * 10001}',
      ]) {
        expect(refused(raw), OtpauthProblem.invalidKey, reason: raw);
      }
    });
  });

  group('rule 4: settings the web can make', () {
    test('6 digits, 30 seconds, SHA1 — or nothing said', () {
      code(
        'otpauth://totp/A?secret=JBSWY3DPEHPK3PXP'
        '&digits=6&period=30&algorithm=sha1',
      );
      code(
        'otpauth://totp/A?secret=JBSWY3DPEHPK3PXP&digits=&period=&algorithm=',
      );
      code('otpauth://totp/A?secret=JBSWY3DPEHPK3PXP&image=https%3A%2F%2Fx');
    });

    test('anything else is refused, whatever the key', () {
      for (final String raw in <String>[
        'otpauth://totp/A?secret=JBSWY3DPEHPK3PXP&digits=8',
        'otpauth://totp/A?secret=JBSWY3DPEHPK3PXP&period=60',
        'otpauth://totp/A?secret=JBSWY3DPEHPK3PXP&algorithm=SHA256',
        'otpauth://totp/A?secret=JBSWY3DPEHPK3PXP&algorithm=SHA512',
        'otpauth://totp/A?secret=JBSWY3DPEHPK3PXP&digits=six',
        'otpauth://totp/A?secret=!!!&digits=8',
      ]) {
        expect(refused(raw), OtpauthProblem.unsupported, reason: raw);
      }
    });

    test('parameter names in any capitals; the first one wins', () {
      expect(
        code(
          'otpauth://totp/A?SECRET=JBSWY3DPEHPK3PXP&Issuer=First&issuer=Second',
        ).issuer,
        'First',
      );
    });
  });
}
