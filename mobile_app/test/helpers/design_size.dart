import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/constants/ui_constants.dart';
import 'package:keeperpass/presentation/common/theme/app_theme_data.dart';

/// Pumps [child] on a screen exactly the design size (393 x 852) so ScreenUtil
/// scales by 1 and design points can be compared as they are.
Future<void> pumpAtDesignSize(
  WidgetTester tester,
  Widget child, {
  Brightness brightness = Brightness.light,
  TargetPlatform platform = TargetPlatform.iOS,
  bool settle = true,
}) async {
  tester.view.physicalSize = UiConstants.designSize;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: UiConstants.designSize,
      minTextAdapt: true,
      builder: (BuildContext context, Widget? _) => MaterialApp(
        theme: AppThemeData.getAppThemeData(
          brightness: brightness,
          context: context,
        ).copyWith(platform: platform),
        home: child,
      ),
    ),
  );
  // MaterialApp animates theme changes; settle so a re-pumped theme is final
  // (pages with endless animations, such as spinners, pump a fixed time).
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump(const Duration(milliseconds: 500));
  }
}

/// Pumps an empty screen at the design size and returns a context inside the
/// app's theme.
Future<BuildContext> designContext(
  WidgetTester tester, {
  Brightness brightness = Brightness.light,
  TargetPlatform platform = TargetPlatform.iOS,
}) async {
  late BuildContext captured;
  await pumpAtDesignSize(
    tester,
    Builder(
      builder: (BuildContext context) {
        captured = context;
        return const SizedBox.shrink();
      },
    ),
    brightness: brightness,
    platform: platform,
  );
  return captured;
}
