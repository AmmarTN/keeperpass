import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

/// Runs before every test file: fonts come from assets/fonts only, as in the
/// app, so no test ever reaches the network.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  GoogleFonts.config.allowRuntimeFetching = false;
  await testMain();
}
