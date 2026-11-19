import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeperpass/core/app.dart';
import 'package:keeperpass/core/bootstrap.dart';
import 'package:keeperpass/core/debug/app_bloc_observer.dart';
import 'package:keeperpass/presentation/common/widgets/configuration_error_app.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = AppBlocObserver();
    // Fonts come from assets/fonts only; the app never contacts Google Fonts.
    GoogleFonts.config.allowRuntimeFetching = false;

    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    // Load env vars for the environment being built; flavors are not used.
    // Release builds (the stores) are production; debug and profile builds
    // are development and show its corner ribbon (your answer, 2026-11-03).
    await dotenv.load(
      fileName: kReleaseMode
          ? 'assets/env/production.env'
          : 'assets/env/development.env',
    );

    final AppConfig config = AppConfig.fromEnv(dotenv.env);
    final List<String> configurationErrors = config.validationErrors;

    if (configurationErrors.isNotEmpty) {
      runApp(ConfigurationErrorApp(errors: configurationErrors));
      return;
    }

    await bootstrap(config);
  }, reportBootstrapFailure);
}
