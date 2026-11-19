import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keeperpass/core/app.dart';
import 'package:keeperpass/core/debug/logger.dart';
import 'package:keeperpass/core/usecases/settings/apply_privacy_settings.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/keeperpass_app.dart';

Future<void> bootstrap(AppConfig config) async {
  // The bundled card network logos are Apache-2.0: their licence ships with
  // them and joins the app's licences.
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(<String>[
      'svg-credit-card-payment-icons',
    ], await rootBundle.loadString('assets/card_networks/LICENSE'));
  });
  await configureDependencies(config);
  // The app-switcher cover and screenshot blocking, as saved (Part 14).
  unawaited(getIt<ApplyPrivacySettings>()(const NoParams()));

  runApp(const KeeperPassAppProvided());
}

Future<void> reportBootstrapFailure(Object error, StackTrace stackTrace) async {
  logger.e('Uncaught application error', error: error, stackTrace: stackTrace);
}
