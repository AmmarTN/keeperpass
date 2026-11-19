import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/cubit/connectivity/connectivity_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_spacing.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

class ConnectivityBanner extends StatefulWidget {
  const ConnectivityBanner({required this.child, super.key});

  final Widget child;

  @override
  State<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends State<ConnectivityBanner> {
  static const Duration _offlineDuration = Duration(seconds: 3);
  static const Duration _onlineDuration = Duration(seconds: 2);

  Timer? _timer;
  bool _isActuallyOffline = false;
  bool _isVisible = false;
  bool _showsOfflineMessage = true;

  @override
  void initState() {
    super.initState();
    _isActuallyOffline =
        context.read<ConnectivityCubit>().state is ConnectivityDisconnected;
    if (_isActuallyOffline) {
      _show(isOffline: true, duration: _offlineDuration);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onConnectivityChanged(ConnectivityState state) {
    if (state is ConnectivityDisconnected && !_isActuallyOffline) {
      _isActuallyOffline = true;
      _show(isOffline: true, duration: _offlineDuration);
    } else if (state is ConnectivityConnected && _isActuallyOffline) {
      _isActuallyOffline = false;
      _show(isOffline: false, duration: _onlineDuration);
    }
  }

  void _show({required bool isOffline, required Duration duration}) {
    _timer?.cancel();
    setState(() {
      _isVisible = true;
      _showsOfflineMessage = isOffline;
    });
    _timer = Timer(duration, () {
      if (mounted) setState(() => _isVisible = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool reduceMotion = MediaQuery.disableAnimationsOf(context);
    final double stripHeight = 34.h;
    final double targetHeight = _isVisible ? stripHeight : 0;

    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listenWhen: (ConnectivityState previous, ConnectivityState current) =>
          previous != current,
      listener: (_, ConnectivityState state) => _onConnectivityChanged(state),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(end: targetHeight),
        duration: reduceMotion ? Duration.zero : AppMotion.enter,
        curve: AppMotion.easeOut,
        builder: (BuildContext context, double height, _) {
          return Stack(
            children: <Widget>[
              Positioned.fill(
                child: MediaQuery(
                  data: mediaQuery.copyWith(
                    padding: mediaQuery.padding.copyWith(
                      top: mediaQuery.padding.top + height,
                    ),
                  ),
                  child: widget.child,
                ),
              ),
              if (height > 0.5)
                PositionedDirectional(
                  top: mediaQuery.padding.top,
                  start: 0,
                  end: 0,
                  height: height,
                  child: ClipRect(
                    child: Align(
                      alignment: AlignmentDirectional.topCenter,
                      heightFactor: height / stripHeight,
                      child: SizedBox(height: stripHeight, child: _buildBar()),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBar() {
    final Color accent = _showsOfflineMessage
        ? context.colors.mutedForeground
        : context.colors.accentStrong;

    // Above the routes, outside any Material (see `AppToastHost`).
    return Material(
      color: context.colors.sidebar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Part 14 replaces this strip with the design's connection states.
          AppIcon(
            _showsOfflineMessage ? AppIconName.wifiOff : AppIconName.cloudCheck,
            size: AppIconSizes.sm,
            color: accent,
          ),
          SizedBox(width: AppSpacing.xs.w),
          Text(
            _showsOfflineMessage
                ? t.connectivity.offline
                : t.connectivity.online,
            style: AppTextStyles(context).badge().copyWith(color: accent),
          ),
        ],
      ),
    );
  }
}
