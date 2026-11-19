import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/constants/ui_constants.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_theme_data.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';

/// Pumps [child] at the design size inside the app's theme, a scaffold and
/// the toast host. Components with endless animations (spinners) pass
/// `settle: false`.
Future<void> pumpComponent(
  WidgetTester tester,
  Widget child, {
  Brightness brightness = Brightness.light,
  TargetPlatform platform = TargetPlatform.iOS,
  bool settle = true,
  bool scroll = true,
  bool reduceMotion = false,
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
        builder: (BuildContext context, Widget? route) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(disableAnimations: reduceMotion),
          child: AppToastHost(child: route!),
        ),
        home: Scaffold(
          body: scroll
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: child,
                )
              : Padding(padding: const EdgeInsets.all(16), child: child),
        ),
      ),
    ),
  );
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump(const Duration(milliseconds: 300));
  }
}

/// Runs [body] once in Light and once in Dark.
Future<void> inBothThemes(
  Future<void> Function(Brightness brightness) body,
) async {
  for (final Brightness brightness in Brightness.values) {
    await body(brightness);
  }
}

/// Finds the [AppIcon]s showing [icon].
Finder findAppIcon(AppIconName icon) =>
    find.byWidgetPredicate((Widget w) => w is AppIcon && w.icon == icon);

/// The fill of the first decorated box (Container or DecoratedBox) under
/// [of].
Color? fillUnder(WidgetTester tester, Finder of) {
  for (final Element e
      in find
          .descendant(
            of: of,
            matching: find.byWidgetPredicate(
              (Widget w) => w is Container || w is DecoratedBox,
            ),
          )
          .evaluate()) {
    final Decoration? d = switch (e.widget) {
      Container(:final Decoration? decoration) => decoration,
      DecoratedBox(:final Decoration decoration) => decoration,
      _ => null,
    };
    final Color? color = switch (d) {
      ShapeDecoration(:final Color? color) => color,
      BoxDecoration(:final Color? color) => color,
      _ => null,
    };
    if (color != null) return color;
  }
  return null;
}
