import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/app_info.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/constants/app_links.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/utils/param_spans.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_backdrop.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_explainers.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_settings_row.dart';
import 'package:keeperpass/presentation/features/settings/cubit/settings_cubit.dart';

/// A large-title page under Settings (boards `S5-38`, `S5-40`).
class _HelpScaffold extends StatelessWidget {
  const _HelpScaffold({
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.colors.background,
    body: AppLargeTitleScrollView(
      title: title,
      subtitle: subtitle,
      leading: AppLinkButton.back(
        label: t.settings.title,
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            16.w,
            0,
            16.w,
            MediaQuery.paddingOf(context).bottom + 24.h,
          ),
          sliver: SliverList.list(children: children),
        ),
      ],
    ),
  );
}

/// A term and what it means (`.pr`), with an optional tile.
class _TermRow extends StatelessWidget {
  const _TermRow({required this.term, required this.text, this.icon});

  final String term;
  final String text;
  final AppIconName? icon;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return MergeSemantics(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.w,
          children: <Widget>[
            if (icon != null)
              AppIconTile(AppTileIcon(icon!), size: AppTileSize.settings),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    term,
                    style: styles
                        .bodyStrong()
                        .resized(16, line: 22, weight: FontWeight.w700)
                        .copyWith(color: colors.foreground),
                  ),
                  Text(
                    text,
                    style: styles
                        .formLabel()
                        .resized(14, line: 20, weight: FontWeight.w400)
                        .copyWith(color: colors.mutedForeground),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// How KeeperPass works, for this account's storage (board `S5-38`): where
/// the data lives, what protects it, signing in, and the terms.
class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({required this.onTechnicalDetails, super.key});

  final VoidCallback onTechnicalDetails;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final ProviderId provider =
        context.read<SessionCubit>().state.account?.provider ??
        ProviderId.google;

    Widget step(String title, String note) => Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: '$title\n',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          TextSpan(
            text: note,
            style: TextStyle(color: colors.mutedForeground),
          ),
        ],
      ),
    );

    return _HelpScaffold(
      title: t.help.howTitle,
      subtitle: t.help.howSubtitle,
      children: <Widget>[
        AppSectionLabel(t.help.whereLives, icon: AppIconName.cloud),
        _StorageDiagram(provider: provider),
        AppSectionLabel(t.help.protects, icon: AppIconName.shieldCheck),
        AppInsetGroup(
          children: <Widget>[
            _TermRow(
              icon: AppIconName.keyRound,
              term: t.help.secretTerm,
              text: t.help.secretNote,
            ),
            _TermRow(
              icon: AppIconName.timer,
              term: t.help.kdfTerm,
              text: t.help.kdfNote,
            ),
            _TermRow(
              icon: AppIconName.lockKeyhole,
              term: t.help.encryptionTerm,
              text: t.help.encryptionNote,
            ),
            _TermRow(
              icon: AppIconName.cloud,
              term: t.help.accessTerm,
              text: t.help.accessNote,
            ),
            AppSettingsRow(
              leading: const AppIconTile(
                AppTileIcon(AppIconName.code),
                size: AppTileSize.settings,
              ),
              title: t.howItWorks.technicalDetails,
              accentTitle: true,
              chevron: true,
              onTap: onTechnicalDetails,
            ),
          ],
        ),
        AppSectionLabel(t.help.signingIn, icon: AppIconName.keyRound),
        AppNumberedList(
          items: <Widget>[
            step(t.help.step1, t.help.step1Note),
            step(t.help.step2, t.help.step2Note),
          ],
          footer: t.help.bothNeeded,
        ),
        AppSectionLabel(t.help.terms, icon: AppIconName.bookOpen),
        AppInsetGroup(
          children: <Widget>[
            _TermRow(term: t.help.secretWord, text: t.help.secretDef),
            _TermRow(term: t.help.vaultWord, text: t.help.vaultDef),
            _TermRow(term: t.help.tagWord, text: t.help.tagDef),
            _TermRow(term: t.help.reportWord, text: t.help.reportDef),
          ],
        ),
      ],
    );
  }
}

/// "Your vault is encrypted on this phone and stored as one file in your
/// Google Drive": two nodes and the file on a dashed lane between them.
class _StorageDiagram extends StatelessWidget {
  const _StorageDiagram({required this.provider});

  final ProviderId provider;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);

    Widget node(Widget tile, String name, String note) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 14.w,
      children: <Widget>[
        tile,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: styles.rowTitle().copyWith(
                  fontWeight: FontWeight.w800,
                  color: colors.foreground,
                ),
              ),
              Text(
                note,
                style: styles
                    .formLabel()
                    .resized(14, line: 20, weight: FontWeight.w400)
                    .copyWith(color: colors.mutedForeground),
              ),
            ],
          ),
        ),
      ],
    );

    return AppSurface(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Semantics(
            image: true,
            label: t.help.diagram(storage: provider.storageName),
            child: ExcludeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  node(
                    const AppIconTile(
                      AppTileIcon(AppIconName.smartphone),
                      size: AppTileSize.dialog,
                    ),
                    t.storage.thisPhone,
                    t.help.thisPhoneNote,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(21.r, 4.h, 0, 4.h),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 46.h),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 12.w,
                          children: <Widget>[
                            SizedBox(
                              width: 2.r,
                              child: CustomPaint(
                                painter: _VerticalDashPainter(colors.primary60),
                              ),
                            ),
                            Center(
                              child: _FilePill(label: t.help.fileEncrypted),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  node(
                    AppIconTile(
                      AppTileChild(
                        Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            AppIcon(
                              AppIconName.cloud,
                              size: 22,
                              stroke: 1.75,
                              color: colors.accentStrong,
                            ),
                            Positioned(
                              right: -8.r,
                              bottom: -6.r,
                              child: Container(
                                width: 16.r,
                                height: 16.r,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppFixedColors.tileWhite,
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: colors.primary15,
                                      spreadRadius: 1.5.r,
                                    ),
                                  ],
                                ),
                                child: AppProviderLogo(provider.logo, size: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      size: AppTileSize.dialog,
                    ),
                    t.help.yourStorage(storage: provider.storageName),
                    t.help.storageNote,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 14.h),
            padding: EdgeInsets.only(top: 12.h),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colors.border)),
            ),
            child: Text(
              t.help.noServer,
              style: styles.secondary().copyWith(color: colors.mutedForeground),
            ),
          ),
        ],
      ),
    );
  }
}

/// The file on its way (`.fpill`).
class _FilePill extends StatelessWidget {
  const _FilePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Container(
      height: 26.r,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: ShapeDecoration(
        color: colors.card,
        shape: StadiumBorder(
          side: BorderSide(color: colors.hairline, width: 1.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6.w,
        children: <Widget>[
          AppIcon(
            AppIconName.lock,
            size: 12,
            stroke: 2.5,
            color: colors.accentStrong,
          ),
          Text(
            label,
            style: AppTextStyles(context)
                .fileName()
                .resized(11, line: 14, weight: FontWeight.w700)
                .copyWith(color: colors.foreground),
          ),
        ],
      ),
    );
  }
}

/// `.dlink .ln`: 6 pt dashes down.
class _VerticalDashPainter extends CustomPainter {
  _VerticalDashPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final double dash = 6.r;
    for (double y = 0; y < size.height; y += dash * 2) {
      canvas.drawRect(
        Rect.fromLTWH(0, y, size.width, (size.height - y).clamp(0, dash)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_VerticalDashPainter old) => old.color != color;
}

/// Questions (board `S5-40`): one answer open at a time, the first to
/// start with; then "Still stuck?" with the support address.
class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int? _open = 0;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final TextStyle strong = TextStyle(
      color: colors.foreground,
      fontWeight: FontWeight.w700,
    );
    final TextStyle mono = styles
        .fileName()
        .resized(13, line: 22)
        .copyWith(color: colors.mutedForeground);

    final List<(String, List<Widget>)> entries = <(String, List<Widget>)>[
      (
        t.faq.forgetQ,
        <Widget>[
          Text(t.faq.forgetA1),
          Text.rich(
            TextSpan(
              children: spansWithParams(
                (List<String> m) => t.faq.forgetA2(forgot: m[0], file: m[1]),
                <InlineSpan>[
                  TextSpan(text: t.faq.forgetA2Link, style: strong),
                  TextSpan(text: 'vault.backup-….json.enc', style: mono),
                ],
              ),
            ),
          ),
          Text(t.faq.forgetA3),
        ],
      ),
      (t.faq.seeQ, <Widget>[Text(t.faq.seeA)]),
      (t.faq.syncQ, <Widget>[Text(t.faq.syncA)]),
      (t.faq.providerQ, <Widget>[Text(t.faq.providerA)]),
      (t.faq.importQ, <Widget>[Text(t.faq.importA)]),
      (
        t.faq.changeSecretQ,
        <Widget>[
          Text.rich(
            TextSpan(
              children: spansWithParams(
                (List<String> m) => t.faq.changeSecretA(action: m[0]),
                <InlineSpan>[
                  TextSpan(text: t.settings.changeSecret, style: strong),
                ],
              ),
            ),
          ),
        ],
      ),
      (t.faq.costQ, <Widget>[Text(t.faq.costA)]),
    ];

    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < entries.length; i++) {
      final bool open = _open == i;
      rows.add(
        AppPressable(
          expanded: open,
          onTap: () => setState(() => _open = open ? null : i),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 56.h),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 12.w, 8.h),
              child: Row(
                spacing: 12.w,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      entries[i].$1,
                      style: styles.rowTitle().copyWith(
                        color: colors.foreground,
                      ),
                    ),
                  ),
                  AppIcon(
                    open ? AppIconName.chevronUp : AppIconName.chevronDown,
                    size: 18,
                    stroke: 2,
                    color: colors.mutedForeground,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (open) {
        rows.add(
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: DefaultTextStyle.merge(
              style: styles.body().copyWith(color: colors.mutedForeground),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 10.h,
                children: entries[i].$2,
              ),
            ),
          ),
        );
      }
    }

    return _HelpScaffold(
      title: t.faq.title,
      subtitle: t.faq.subtitle,
      children: <Widget>[
        SizedBox(height: 16.h),
        AppSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < rows.length; i++) ...<Widget>[
                // A hairline above each question but the first (`.faq +
                // .faq`, `.faqa + .faq`); an answer joins its question.
                if (i > 0 && rows[i] is AppPressable)
                  Divider(height: 1, thickness: 1, color: colors.border),
                rows[i],
              ],
            ],
          ),
        ),
        SizedBox(height: 16.h),
        AppSurface(
          padding: EdgeInsets.all(18.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6.h,
            children: <Widget>[
              Row(
                spacing: 8.w,
                children: <Widget>[
                  AppIcon(
                    AppIconName.lifeBuoy,
                    size: 18,
                    stroke: 2,
                    color: colors.accentStrong,
                  ),
                  Text(
                    t.faq.stillStuck,
                    style: styles
                        .navTitle()
                        .resized(17, line: 24)
                        .copyWith(color: colors.foreground),
                  ),
                ],
              ),
              Text(
                t.faq.contactBody,
                style: styles.secondary().copyWith(
                  color: colors.mutedForeground,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: AppButton(
                  label: AppLinks.contactEmail,
                  icon: AppIconName.mail,
                  variant: AppButtonVariant.secondary,
                  size: AppButtonSize.medium,
                  expand: false,
                  onPressed: () => unawaited(
                    context.read<SettingsCubit>().openLink(AppLinks.contact),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// About (board `S5-41`): the icon, wordmark, version and promise, and the
/// links.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final SettingsCubit cubit = context.read<SettingsCubit>();

    Widget link(AppIconName icon, String title, Uri uri) => AppSettingsRow(
      leading: AppIconTile(AppTileIcon(icon), size: AppTileSize.settings),
      title: title,
      externalLink: true,
      onTap: () => unawaited(cubit.openLink(uri)),
    );

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: <Widget>[
          const Positioned.fill(
            child: AppBackdrop(
              glowLeft: -23.5,
              glowTop: -33,
              glowSize: 440,
              glowHeight: 400,
            ),
          ),
          Column(
            children: <Widget>[
              SafeArea(
                bottom: false,
                child: AppCompactBar(
                  title: '',
                  leading: AppLinkButton.back(
                    label: t.settings.title,
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    16.w,
                    6.h,
                    16.w,
                    MediaQuery.paddingOf(context).bottom + 24.h,
                  ),
                  children: <Widget>[
                    Column(
                      spacing: 14.h,
                      children: <Widget>[
                        const AppAppIcon(size: 88),
                        AppWordmark(height: 30, color: colors.foreground),
                        Text(
                          t.about.version(
                            version: AppInfo.version,
                            build: AppInfo.build,
                          ),
                          style: styles.secondary().copyWith(
                            color: colors.mutedForeground,
                          ),
                        ),
                        Text(
                          t.about.tagline,
                          textAlign: TextAlign.center,
                          style: styles
                              .bodyStrong()
                              .resized(17, line: 24, weight: FontWeight.w700)
                              .copyWith(color: colors.foreground),
                        ),
                        AppPill(
                          label: t.about.license,
                          tone: AppPillTone.accent,
                          height: 28,
                          horizontalPadding: 12,
                        ),
                      ],
                    ),
                    SizedBox(height: 26.h),
                    AppInsetGroup(
                      dividerInset: AppDividerInset.settings,
                      children: <Widget>[
                        link(
                          AppIconName.code,
                          t.technicalDetails.viewSource,
                          AppLinks.sourceCode,
                        ),
                        link(AppIconName.scale, t.about.terms, AppLinks.terms),
                        link(
                          AppIconName.shieldCheck,
                          t.about.privacy,
                          AppLinks.privacy,
                        ),
                        link(
                          AppIconName.mail,
                          AppLinks.contactEmail,
                          AppLinks.contact,
                        ),
                      ],
                    ),
                    AppFootnote(t.about.promise),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
