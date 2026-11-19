import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:keeperpass/core/utils/crypto/totp.dart';

/// A 2FA field's current code (web `Totp`): rebuilt on each second boundary
/// with the code and the seconds left; [code] is null when the setup key is
/// not valid (web "Invalid code"). Wrap what it builds in a
/// `RepaintBoundary` — it repaints every second.
class AppLiveTotp extends StatefulWidget {
  const AppLiveTotp({
    required this.secret,
    required this.builder,
    this.period = kDefaultTotpPeriodSeconds,
    this.now = DateTime.now,
    super.key,
  });

  final String secret;
  final int period;
  final Widget Function(BuildContext context, String? code, int secondsLeft)
  builder;

  /// The clock (tests).
  final DateTime Function() now;

  @override
  State<AppLiveTotp> createState() => _AppLiveTotpState();
}

class _AppLiveTotpState extends State<AppLiveTotp> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _schedule();
  }

  /// Wakes on the next second boundary, so the ring and the code change
  /// together with the clock.
  void _schedule() {
    final int ms = widget.now().millisecondsSinceEpoch;
    _timer = Timer(Duration(milliseconds: 1000 - ms % 1000), () {
      if (!mounted) return;
      setState(() {});
      _schedule();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int ms = widget.now().millisecondsSinceEpoch;
    String? code;
    try {
      code = generateTotp(
        widget.secret,
        period: widget.period,
        timestampMs: ms,
      );
    } catch (_) {
      code = null;
    }
    return widget.builder(
      context,
      code,
      totpSecondsLeft(ms, period: widget.period),
    );
  }
}

/// "482 913": the first three digits, a space, the rest (web `Totp`).
String splitTotpCode(String code) =>
    code.length <= 3 ? code : '${code.substring(0, 3)} ${code.substring(3)}';
