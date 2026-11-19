import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/extensions/failures.dart';

void main() {
  test('maps failures to their localized messages', () {
    expect(
      const Failure.cacheReadFailure().getMessage(),
      t.errors.failures.cacheReadFailure,
    );
    expect(
      const Failure.networkFailure(
        NetworkFailure.noInternetConnection(),
      ).getMessage(),
      t.errors.failures.connectionError,
    );
    expect(
      const Failure.networkFailure(NetworkFailure.sendTimeout()).getMessage(),
      t.errors.failures.requestTimeout,
    );
  });

  test('a platform failure keeps its own message', () {
    expect(
      const Failure.platformFailure(message: 'Exact reason').getMessage(),
      'Exact reason',
    );
  });
}
