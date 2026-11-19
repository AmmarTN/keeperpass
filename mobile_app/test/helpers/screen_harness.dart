import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeperpass/presentation/common/constants/ui_constants.dart';
import 'package:keeperpass/presentation/common/theme/app_theme_data.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';

/// Pumps a whole screen on an iPhone-sized display (the design's 393 × 852,
/// with its 59 pt status bar and 34 pt home indicator), in the app's theme,
/// under the toast host and the given cubits.
Future<void> pumpScreen(
  WidgetTester tester,
  Widget screen, {
  required List<BlocProvider<dynamic>> providers,
  Brightness brightness = Brightness.light,
  bool settle = false,
  double pixelRatio = 1,
  TargetPlatform platform = TargetPlatform.iOS,
}) async {
  tester.view.physicalSize = UiConstants.designSize * pixelRatio;
  tester.view.devicePixelRatio = pixelRatio;
  tester.view.padding = FakeViewPadding(
    top: 59 * pixelRatio,
    bottom: 34 * pixelRatio,
  );
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MultiBlocProvider(
      providers: providers,
      child: ScreenUtilInit(
        designSize: UiConstants.designSize,
        minTextAdapt: true,
        builder: (BuildContext context, Widget? _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemeData.getAppThemeData(
            brightness: brightness,
            context: context,
          ).copyWith(platform: platform),
          builder: (BuildContext context, Widget? route) =>
              AppToastHost(child: route!),
          home: screen,
        ),
      ),
    ),
  );
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump(const Duration(milliseconds: 400));
  }
}

/// Loads the app's real fonts (the Font Manifest's families and the bundled
/// Nunito / Space Mono), so rendered screens can be looked at.
Future<void> loadAppFonts(WidgetTester tester) async {
  await tester.runAsync(() async {
    final Object? manifest = jsonDecode(
      await rootBundle.loadString('FontManifest.json'),
    );
    for (final Object? entry in manifest! as List<Object?>) {
      final Map<String, Object?> family = entry! as Map<String, Object?>;
      final FontLoader loader = FontLoader(family['family']! as String);
      for (final Object? font in family['fonts']! as List<Object?>) {
        loader.addFont(
          rootBundle.load((font! as Map<String, Object?>)['asset']! as String),
        );
      }
      await loader.load();
    }
    await GoogleFonts.pendingFonts(<TextStyle>[
      GoogleFonts.nunito(fontWeight: FontWeight.w400),
      GoogleFonts.nunito(fontWeight: FontWeight.w600),
      GoogleFonts.nunito(fontWeight: FontWeight.w700),
      GoogleFonts.nunito(fontWeight: FontWeight.w800),
      GoogleFonts.spaceMono(fontWeight: FontWeight.w400),
      GoogleFonts.spaceMono(fontWeight: FontWeight.w700),
    ]);
  });
}
