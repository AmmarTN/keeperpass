import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';

/// What the picker chooses.
enum AppDatePickerMode { date, month }

/// The date and month picker (decision 2026-10-30: one shared wheel picker in
/// our sheet on both platforms — Android has no system month picker). The
/// wheels apply as they turn; closing the sheet returns the last value.
Future<DateTime> showAppDatePicker(
  BuildContext context, {
  required String title,
  required DateTime initial,
  AppDatePickerMode mode = AppDatePickerMode.date,
  DateTime? minimum,
  DateTime? maximum,
}) async {
  DateTime selected = initial;
  await showAppSheet<void>(
    context,
    builder: (BuildContext sheetContext) {
      final AppColors colors = sheetContext.colors;
      return AppSheet(
        title: title,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            primaryColor: colors.accentStrong,
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: AppTextStyles(
                sheetContext,
              ).body().resized(21, line: 26).copyWith(color: colors.foreground),
            ),
          ),
          child: SizedBox(
            height: 216.h,
            child: CupertinoDatePicker(
              mode: mode == AppDatePickerMode.month
                  ? CupertinoDatePickerMode.monthYear
                  : CupertinoDatePickerMode.date,
              initialDateTime: initial,
              minimumDate: minimum,
              maximumDate: maximum,
              onDateTimeChanged: (DateTime value) => selected = value,
            ),
          ),
        ),
      );
    },
  );
  return selected;
}
