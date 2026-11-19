import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/routes/router.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_spinner.dart';

/// Launch (board `U2-Launch`): the white mark on black, the same picture as
/// the system launch screen, until the remembered sign-in is read. A
/// remembered sign-in goes straight to Unlock (D10); otherwise Welcome. No
/// spinner unless start-up takes longer than about a second.
@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _slow;
  bool _showSpinner = false;
  bool _left = false;

  @override
  void initState() {
    super.initState();
    _slow = Timer(const Duration(seconds: 1), () {
      if (mounted) setState(() => _showSpinner = true);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final SessionState session = context.read<SessionCubit>().state;
      if (session.restored) _leave(session);
    });
  }

  @override
  void dispose() {
    _slow?.cancel();
    super.dispose();
  }

  void _leave(SessionState session) {
    if (_left || !mounted) return;
    _left = true;
    context.router.replaceAll(<PageRouteInfo>[
      if (session.phase == SessionPhase.awaitingSecret)
        UnlockRoute(fromLaunch: true)
      else
        WelcomeRoute(fromLaunch: true),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listenWhen: (SessionState a, SessionState b) => !a.restored && b.restored,
      listener: (_, SessionState session) => _leave(session),
      child: ColoredBox(
        color: AppFixedColors.markBackground,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/icons/svg/keeperpass_mark.svg',
              width: 120,
              semanticsLabel: 'KeeperPass',
            ),
            if (_showSpinner)
              Positioned(
                bottom: 96.h,
                child: const AppSpinner(
                  size: 20,
                  color: AppFixedColors.markForeground,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
