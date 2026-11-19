import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/utils/validators/validators.dart';

void main() {
  group('Validators', () {
    test('recognizes a valid email', () {
      expect(Validators.isEmail('person@example.com'), isTrue);
    });

    test('rejects malformed email input', () {
      expect(Validators.isEmail('person@'), isFalse);
    });

    test('requires at least eight password characters', () {
      expect(Validators.isStrongEnoughPassword('1234567'), isFalse);
      expect(Validators.isStrongEnoughPassword('12345678'), isTrue);
    });
  });
}
