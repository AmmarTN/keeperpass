import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/items/item_templates.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/cards/app_code_card.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_live_totp.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_trust_line.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/copied_toast.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_search_field.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/text/highlighted_text.dart';
import 'package:keeperpass/presentation/features/codes/cubit/codes_cubit.dart';
import 'package:keeperpass/presentation/features/edit_item/pages/edit_item_page.dart';
import 'package:keeperpass/presentation/features/scan_qr/cubit/scan_cubit.dart';
import 'package:keeperpass/presentation/features/scan_qr/pages/scan_page.dart';
import 'package:keeperpass/presentation/features/vault_list/pages/vault_list_page.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';

/// The Codes tab (boards `Codes`, `S4-01` … `S4-06`).
class CodesPage extends StatelessWidget {
  const CodesPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<CodesCubit>(
    create: (_) => getIt<CodesCubit>(),
    child: const CodesScreen(),
  );
}

/// [CodesPage] under a given cubit (tests provide their own).
class CodesScreen extends StatefulWidget {
  const CodesScreen({super.key});

  @override
  State<CodesScreen> createState() => _CodesScreenState();
}

class _CodesScreenState extends State<CodesScreen> {
  final TextEditingController _query = TextEditingController();
  final ScrollController _scroll = ScrollController();

  /// The cards on screen, to bring a new code into view.
  final Map<String, GlobalKey> _cards = <String, GlobalKey>{};

  @override
  void initState() {
    super.initState();
    _query.text = context.read<CodesCubit>().state.search;
  }

  @override
  void dispose() {
    _query.dispose();
    _scroll.dispose();
    super.dispose();
  }

  /// "Scan QR code" (board `Scan-QR`): a saved code lands on its card with
  /// "Code added to …" (board `S6-32`; no "New" mark — your answer, Part
  /// 15); a typed key for a new item opens the new-item screen with it.
  Future<void> _scan() async {
    final ScanOutcome? outcome = await scanCodeIntoVault(context);
    if (!mounted) return;
    switch (outcome) {
      case CodeAdded(:final String itemId, :final String name):
        await _landOn(itemId, name);
      case NewItemKey(:final String key):
        _createAuthenticator(setupKey: key);
      case FieldKey() || null:
        break;
    }
  }

  /// The card of [itemId] in view, the search cleared if it hides it, and
  /// the toast.
  Future<void> _landOn(String itemId, String name) async {
    final CodesCubit cubit = context.read<CodesCubit>();
    AppToastHost.of(context).show(
      AppToastData(
        icon: AppIconName.circleCheck,
        title: t.scan.codeAdded(name: name),
        detail: t.scan.tapToCopy,
      ),
    );
    if (cubit.state.searching) {
      _query.clear();
      cubit.setSearch('');
    }
    // The list follows the vault a moment later; then the card is drawn.
    await Future<void>.delayed(Duration.zero);
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;
    final int index = cubit.state.shown.indexWhere(
      (CodeEntry e) => e.itemId == itemId,
    );
    if (index < 0 || !_scroll.hasClients) return;
    if (_cards[itemId]?.currentContext == null) {
      // Further down than the list has built: near it first.
      final ScrollPosition position = _scroll.position;
      position.jumpTo(
        position.maxScrollExtent * index / cubit.state.shown.length,
      );
      await WidgetsBinding.instance.endOfFrame;
    }
    if (!mounted) return;
    final bool reduceMotion = AppMotion.reduceMotion(context);
    final BuildContext? card = _cards[itemId]?.currentContext;
    if (card == null || !card.mounted) return;
    await Scrollable.ensureVisible(
      card,
      alignment: 0.5,
      duration: reduceMotion ? Duration.zero : AppMotion.base,
      curve: AppMotion.easeOut,
    );
  }

  /// Straight to a new Authenticator item in your own vault (your answer,
  /// Part 10: the Codes tab has no vault in view), with a typed
  /// [setupKey] already in (Part 15).
  void _createAuthenticator({String? setupKey}) {
    final List<Vault> vaults = context.read<CodesCubit>().vaults;
    if (vaults.isEmpty) return;
    final Vault vault = vaults.firstWhere(
      (Vault v) => v.id == kPersonalVaultId,
      orElse: () => vaults.first,
    );
    unawaited(
      openNewItemFrom(
        context,
        vaultId: vault.id,
        template: kItemTemplates.firstWhere(
          (ItemTemplate t) => t.id == 'authenticator',
        ),
        backLabel: t.tabs.codes,
        setupKey: setupKey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final CodesCubit cubit = context.read<CodesCubit>();
    final CodesState state = context.watch<CodesCubit>().state;
    final List<CodeEntry> shown = state.shown;
    final List<String> words = searchWords(state.search);
    final double bottom = MediaQuery.paddingOf(context).bottom;

    final Widget trust = AppTrustLine(t.codes.trust);

    return Scaffold(
      backgroundColor: colors.background,
      resizeToAvoidBottomInset: false,
      body: AppLargeTitleScrollView(
        controller: _scroll,
        title: t.tabs.codes,
        subtitle: t.codes.subtitle,
        actions: <Widget>[
          AppIconButton(
            icon: AppIconName.scanQrCode,
            semanticLabel: t.editItem.scanQr,
            onPressed: () => unawaited(_scan()),
          ),
        ],
        slivers: <Widget>[
          if (state.entries.isEmpty)
            // The empty layout keeps its own 32 pt sides (`.empty2`).
            SliverPadding(
              padding: EdgeInsets.only(bottom: bottom + 24.h),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    VaultEmptyLayout(
                      topMargin: 84,
                      icon: const AppTileGlyph(FaGlyphs.totp),
                      title: t.codes.emptyTitle,
                      message: t.codes.emptyBody,
                      actions: <Widget>[
                        AppButton(
                          label: t.editItem.scanQr,
                          icon: AppIconName.scanQrCode,
                          onPressed: () => unawaited(_scan()),
                        ),
                        AppButton(
                          label: t.codes.createAuthenticator,
                          glyph: FaGlyphs.totp,
                          variant: AppButtonVariant.secondary,
                          onPressed: () => _createAuthenticator(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: trust,
                    ),
                  ],
                ),
              ),
            )
          else ...<Widget>[
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AppSearchField(
                      controller: _query,
                      placeholder: t.codes.searchPlaceholder(
                        n: state.entries.length,
                      ),
                      onChanged: cubit.setSearch,
                    ),
                    if (state.searching)
                      Padding(
                        padding: EdgeInsets.fromLTRB(4.w, 14.h, 4.w, 0),
                        child: Text(
                          t.codes.codeCount(n: shown.length),
                          style: styles
                              .secondary()
                              .resized(13, line: 18)
                              .copyWith(color: colors.mutedForeground),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                16.w,
                state.searching ? 8.h : 16.h,
                16.w,
                0,
              ),
              sliver: SliverList.separated(
                itemCount: shown.length,
                separatorBuilder: (_, _) => SizedBox(height: 12.h),
                itemBuilder: (BuildContext context, int index) => _CodeCard(
                  key: _cards.putIfAbsent(shown[index].itemId, GlobalKey.new),
                  entry: shown[index],
                  highlight: words,
                ),
              ),
            ),
            // The search shows only what matched (board `S4-05`).
            if (!state.searching)
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverToBoxAdapter(child: trust),
              ),
            SliverToBoxAdapter(child: SizedBox(height: bottom + 24.h)),
          ],
        ],
      ),
    );
  }
}

/// One item's card: its live code, copied with a tap; an invalid setup key
/// says so, with "Fix it in Edit" opening Edit on that field.
class _CodeCard extends StatelessWidget {
  const _CodeCard({required this.entry, required this.highlight, super.key});

  final CodeEntry entry;
  final List<String> highlight;

  Future<void> _copy(BuildContext context, String name) async {
    final AppToastHostState toasts = AppToastHost.of(context);
    final Copied? copied = await context.read<CodesCubit>().copy(entry.itemId);
    if (copied == null) return;
    toasts.show(
      copiedToast(
        title: t.codes.copied,
        from: t.vaultList.copiedFrom(item: name),
        clearsIn: copied.clearsIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CodesCubit cubit = context.read<CodesCubit>();
    final String name = rowName(entry.row);
    final Widget tile = VaultItemTile(entry.row);
    final String subtitle = rowSubtitle(entry.row);

    return RepaintBoundary(
      child: AppLiveTotp(
        secret: entry.field.value,
        now: cubit.now,
        builder: (BuildContext context, String? code, int secondsLeft) =>
            code == null
            ? AppCodeCard.invalid(
                tile: tile,
                name: name,
                subtitle: subtitle,
                highlight: highlight,
                onFix: () => openEditItem(
                  context,
                  entry.itemId,
                  focusField: entry.row.item.fields.indexOf(entry.field),
                ),
              )
            : AppCodeCard(
                tile: tile,
                name: name,
                subtitle: subtitle,
                highlight: highlight,
                code: splitTotpCode(code),
                secondsLeft: secondsLeft,
                copyLabel: t.vaultList.copyCodeFor(name: name),
                onCopy: () => unawaited(_copy(context, name)),
              ),
      ),
    );
  }
}
