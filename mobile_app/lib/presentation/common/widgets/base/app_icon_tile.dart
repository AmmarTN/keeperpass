import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

/// Tile sizes from the component stylesheet: dimension, corner radius, and
/// the size of the glyph, Lucide icon (with its stroke) or letter inside.
enum AppTileSize {
  /// `.stt` — settings rows, provider tile.
  settings(30, 9, glyph: 15, icon: 17, stroke: 2, letter: 14),

  /// `.ehd .ftile` — a field in edit mode.
  editField(30, 9, glyph: 13, icon: 15, stroke: 2, letter: 13),

  /// `.ftile` — field rows.
  field(32, 9, glyph: 14, icon: 16, stroke: 2, letter: 14),

  /// `.tile.sm` — finding and health card headers, stat tiles.
  small(32, 9, glyph: 15, icon: 17, stroke: 2, letter: 14),

  /// `.ti` — toasts.
  toast(34, 10, glyph: 16, icon: 18, stroke: 2, letter: 15),

  /// `.tile` — vault rows.
  card(36, 10, glyph: 16, icon: 18, stroke: 2, letter: 16),

  /// `.fav` / `.gt` — item rows, favourites, code cards.
  item(40, 12, glyph: 17, icon: 20, stroke: 2, letter: 18),

  /// `.vf-t` — the vault file card.
  file(40, 12, glyph: 17, icon: 20, stroke: 1.75, letter: 18),

  /// `.dtile` — dialogs.
  dialog(44, 12, glyph: 19, icon: 22, stroke: 1.75, letter: 20),

  /// `.tile` at 48 — Settings › Storage's diagram.
  diagram(48, 14, glyph: 20, icon: 24, stroke: 1.75, letter: 22),

  /// `.dtile` at 52 — a full-screen confirmation's header (Archive).
  header(52, 14, glyph: 22, icon: 24, stroke: 1.75, letter: 24),

  /// `.etile` — empty states (with an 8 pt halo).
  empty(64, 18, glyph: 24, icon: 28, stroke: 1.75, letter: 26),

  /// `.etile` at 80 — the scan primer (with the same halo).
  primer(80, 22, glyph: 32, icon: 38, stroke: 1.5, letter: 32),

  /// `.fav` / `.gt` at 72 — item detail header.
  large(72, 18, glyph: 30, icon: 32, stroke: 1.75, letter: 30);

  const AppTileSize(
    this.dimension,
    this.radius, {
    required this.glyph,
    required this.icon,
    required this.stroke,
    required this.letter,
  });

  final double dimension;
  final double radius;
  final double glyph;
  final double icon;
  final double stroke;
  final double letter;
}

/// Tile colours.
enum AppTileTone {
  /// Accent tint, accent-strong content (`.gt`, `.stt`, `.tile`, `.ti`).
  accent,

  /// Lighter accent tint (`.ftile`: field rows).
  soft,

  /// Red tint (`.bad`): flagged, destructive.
  destructive,

  /// Neutral fill, foreground content (`.stt.neu`).
  neutral,

  /// Neutral fill, muted content (`.tile.off`, old vault file).
  muted,

  /// White with a 6 % ring (`.fav`, `.stt.wht`): favicons, letters, logos.
  white,
}

/// What a tile shows.
sealed class AppTileContent {
  const AppTileContent();
}

/// A Lucide interface icon.
final class AppTileIcon extends AppTileContent {
  const AppTileIcon(this.icon);
  final AppIconName icon;
}

/// A Font Awesome glyph (item, field and catalogue icons — Light by default).
final class AppTileGlyph extends AppTileContent {
  const AppTileGlyph(this.codePoint, {this.weight = FaWeight.light});
  final int codePoint;
  final FaWeight weight;
}

/// The first letter of an item without a favicon.
final class AppTileLetter extends AppTileContent {
  const AppTileLetter(this.letter);
  final String letter;
}

/// Anything else (a provider logo, an image).
final class AppTileChild extends AppTileContent {
  const AppTileChild(this.child);
  final Widget child;
}

/// Every square icon tile on the boards: item letters and glyphs, settings,
/// field, card, dialog, empty-state, toast and file tiles.
class AppIconTile extends StatelessWidget {
  const AppIconTile(
    this.content, {
    this.size = AppTileSize.item,
    this.tone = AppTileTone.accent,
    super.key,
  });

  final AppTileContent content;
  final AppTileSize size;
  final AppTileTone tone;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final (Color background, Color foreground) = switch (tone) {
      AppTileTone.accent => (colors.primary15, colors.accentStrong),
      AppTileTone.soft => (colors.primary10, colors.accentStrong),
      AppTileTone.destructive => (
        colors.destructiveTint,
        colors.destructiveStrong,
      ),
      AppTileTone.neutral => (colors.secondary, colors.foreground),
      AppTileTone.muted => (colors.secondary, colors.mutedForeground),
      AppTileTone.white => (
        AppFixedColors.tileWhite,
        AppFixedColors.tileLetter,
      ),
    };

    final Widget inner = switch (content) {
      AppTileIcon(:final AppIconName icon) => AppIcon(
        icon,
        size: size.icon,
        stroke: size.stroke,
        color: foreground,
      ),
      AppTileGlyph(:final int codePoint, :final FaWeight weight) => FaGlyph(
        codePoint,
        size: size.glyph,
        weight: weight,
        color: foreground,
      ),
      AppTileLetter(:final String letter) => Text(
        letter,
        textScaler: TextScaler.noScaling,
        // `.fav`: 18 pt ExtraBold at item size, fixed with the tile.
        style: AppTextStyles(context).title().copyWith(
          fontSize: size.letter.r,
          height: 1,
          letterSpacing: 0,
          color: foreground,
        ),
      ),
      AppTileChild(:final Widget child) => child,
    };

    final bool lifted = size == AppTileSize.large;
    return Container(
      width: size.dimension.r,
      height: size.dimension.r,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        // A CSS shadow never shows through its own box; Flutter paints it
        // under the whole shape, so a lifted tile's tint is made opaque.
        color: lifted
            ? Color.alphaBlend(background, colors.background)
            : background,
        // `.fav` / `.stt.wht`: an inset 6 % ring on white tiles.
        shape: AppRadius.shape(
          context,
          size.radius,
          side: tone == AppTileTone.white
              ? BorderSide(color: AppFixedColors.tileRing, width: 1.r)
              : BorderSide.none,
        ),
        // `.etile`: the 8 pt accent halo around an empty-state tile; the
        // item header's tile is lifted (`var(--lift)`).
        shadows: switch (size) {
          AppTileSize.empty || AppTileSize.primer => <BoxShadow>[
            BoxShadow(color: colors.primary10, spreadRadius: 8.r),
          ],
          _ when lifted => context.shadows.lift,
          _ => null,
        },
      ),
      child: inner,
    );
  }
}
