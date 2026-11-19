import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/copied_toast.dart';
import 'package:keeperpass/presentation/features/sync/widgets/vault_changed_sheet.dart';

/// What the app says on its own, whatever the screen (board `Sync-states`,
/// `Lock-privacy`): "Your Vault Changed" when an edit is refused for a
/// newer version, and "Clipboard cleared" when KeeperPass clears a copy
/// while open. Sits under the toast host, above the routes;
/// [navigatorContext] opens the sheet over the current screen.
class SystemPrompts extends StatefulWidget {
  const SystemPrompts({
    required this.clipboard,
    required this.navigatorContext,
    required this.child,
    super.key,
  });

  final ClipboardService clipboard;
  final BuildContext? Function() navigatorContext;
  final Widget child;

  @override
  State<SystemPrompts> createState() => _SystemPromptsState();
}

class _SystemPromptsState extends State<SystemPrompts> {
  StreamSubscription<void>? _cleared;
  bool _sheetOpen = false;

  @override
  void initState() {
    super.initState();
    _cleared = widget.clipboard.cleared.listen((_) {
      if (mounted) AppToastHost.of(context).show(clipboardClearedToast());
    });
  }

  @override
  void dispose() {
    unawaited(_cleared?.cancel());
    super.dispose();
  }

  Future<void> _askToLoad() async {
    final BuildContext? navigator = widget.navigatorContext();
    if (_sheetOpen || navigator == null || !navigator.mounted) return;
    _sheetOpen = true;
    await showVaultChangedSheet(navigator);
    _sheetOpen = false;
  }

  @override
  Widget build(BuildContext context) => BlocListener<SyncCubit, SyncState>(
    listenWhen: (SyncState a, SyncState b) =>
        b.conflictPrompts > a.conflictPrompts,
    listener: (_, _) => unawaited(_askToLoad()),
    child: widget.child,
  );
}
