import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/infrastructure/injections/external_library_injectable_module.dart';

class _Module extends ExternalLibraryInjectableModule {}

void main() {
  test('every request has a limit, so nothing waits forever (audit, '
      '2026-11-04)', () {
    final BaseOptions options = _Module().dio.options;
    expect(options.connectTimeout, const Duration(seconds: 15));
    expect(options.sendTimeout, const Duration(seconds: 30));
    expect(options.receiveTimeout, const Duration(seconds: 30));
  });
}
