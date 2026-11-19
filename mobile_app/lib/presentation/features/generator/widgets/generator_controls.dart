import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_checks.dart';
import 'package:keeperpass/presentation/features/generator/cubit/generator_cubit.dart';

/// The four character sets (`.ctiles`), two by two as on the web: the
/// Generator tab and the Generate sheet.
class GeneratorCharsets extends StatelessWidget {
  const GeneratorCharsets({
    required this.state,
    required this.cubit,
    super.key,
  });

  final GeneratorState state;
  final GeneratorCubit cubit;

  @override
  Widget build(BuildContext context) => Column(
    spacing: 8.h,
    children: <Widget>[
      Row(
        spacing: 8.w,
        children: <Widget>[
          Expanded(
            child: AppCheckTile(
              label: 'a–z',
              semanticLabel: t.generator.lowercase,
              checked: state.lowercase,
              onChanged: cubit.setLowercase,
            ),
          ),
          Expanded(
            child: AppCheckTile(
              label: 'A–Z',
              semanticLabel: t.generator.uppercase,
              checked: state.uppercase,
              onChanged: cubit.setUppercase,
            ),
          ),
        ],
      ),
      Row(
        spacing: 8.w,
        children: <Widget>[
          Expanded(
            child: AppCheckTile(
              label: '0–9',
              semanticLabel: t.generator.digits,
              checked: state.digits,
              onChanged: cubit.setDigits,
            ),
          ),
          Expanded(
            child: AppCheckTile(
              label: '?()/%…',
              semanticLabel: t.generator.symbols,
              checked: state.symbols,
              onChanged: cubit.setSymbols,
            ),
          ),
        ],
      ),
    ],
  );
}
