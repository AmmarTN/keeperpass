// Icons for the design system (board: Iconography).
//
// Lucide draws the interface, Font Awesome Pro draws content. The Lucide list
// is every icon the design canvas uses; the Font Awesome names are the web's
// (web/src/app/ui/icon/icon-glyphs.ts). To add a Lucide icon, add an entry with
// its four weights; to add a glyph, copy its code point from icon-glyphs.ts.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons_weights.dart';

/// Every Lucide icon the design uses, at the four stroke weights the
/// package ships (300 = 1.5, 400 = 2.0, 500 = 2.5, 600 = 3.0).
enum AppIconName {
  archive(
    LucideIcons300.archive,
    LucideIcons400.archive,
    LucideIcons500.archive,
    LucideIcons600.archive,
  ),
  arrowDown(
    LucideIcons300.arrowDown,
    LucideIcons400.arrowDown,
    LucideIcons500.arrowDown,
    LucideIcons600.arrowDown,
  ),
  arrowDownUp(
    LucideIcons300.arrowDownUp,
    LucideIcons400.arrowDownUp,
    LucideIcons500.arrowDownUp,
    LucideIcons600.arrowDownUp,
  ),
  arrowLeft(
    LucideIcons300.arrowLeft,
    LucideIcons400.arrowLeft,
    LucideIcons500.arrowLeft,
    LucideIcons600.arrowLeft,
  ),
  arrowRight(
    LucideIcons300.arrowRight,
    LucideIcons400.arrowRight,
    LucideIcons500.arrowRight,
    LucideIcons600.arrowRight,
  ),
  arrowRightLeft(
    LucideIcons300.arrowRightLeft,
    LucideIcons400.arrowRightLeft,
    LucideIcons500.arrowRightLeft,
    LucideIcons600.arrowRightLeft,
  ),
  arrowUpDown(
    LucideIcons300.arrowUpDown,
    LucideIcons400.arrowUpDown,
    LucideIcons500.arrowUpDown,
    LucideIcons600.arrowUpDown,
  ),
  bookOpen(
    LucideIcons300.bookOpen,
    LucideIcons400.bookOpen,
    LucideIcons500.bookOpen,
    LucideIcons600.bookOpen,
  ),
  calendar(
    LucideIcons300.calendar,
    LucideIcons400.calendar,
    LucideIcons500.calendar,
    LucideIcons600.calendar,
  ),
  camera(
    LucideIcons300.camera,
    LucideIcons400.camera,
    LucideIcons500.camera,
    LucideIcons600.camera,
  ),
  cameraOff(
    LucideIcons300.cameraOff,
    LucideIcons400.cameraOff,
    LucideIcons500.cameraOff,
    LucideIcons600.cameraOff,
  ),
  check(
    LucideIcons300.check,
    LucideIcons400.check,
    LucideIcons500.check,
    LucideIcons600.check,
  ),
  chevronDown(
    LucideIcons300.chevronDown,
    LucideIcons400.chevronDown,
    LucideIcons500.chevronDown,
    LucideIcons600.chevronDown,
  ),
  chevronLeft(
    LucideIcons300.chevronLeft,
    LucideIcons400.chevronLeft,
    LucideIcons500.chevronLeft,
    LucideIcons600.chevronLeft,
  ),
  chevronRight(
    LucideIcons300.chevronRight,
    LucideIcons400.chevronRight,
    LucideIcons500.chevronRight,
    LucideIcons600.chevronRight,
  ),
  chevronUp(
    LucideIcons300.chevronUp,
    LucideIcons400.chevronUp,
    LucideIcons500.chevronUp,
    LucideIcons600.chevronUp,
  ),
  circle(
    LucideIcons300.circle,
    LucideIcons400.circle,
    LucideIcons500.circle,
    LucideIcons600.circle,
  ),
  circleAlert(
    LucideIcons300.circleAlert,
    LucideIcons400.circleAlert,
    LucideIcons500.circleAlert,
    LucideIcons600.circleAlert,
  ),
  circleCheck(
    LucideIcons300.circleCheck,
    LucideIcons400.circleCheck,
    LucideIcons500.circleCheck,
    LucideIcons600.circleCheck,
  ),
  circleQuestionMark(
    LucideIcons300.circleQuestionMark,
    LucideIcons400.circleQuestionMark,
    LucideIcons500.circleQuestionMark,
    LucideIcons600.circleQuestionMark,
  ),
  circleX(
    LucideIcons300.circleX,
    LucideIcons400.circleX,
    LucideIcons500.circleX,
    LucideIcons600.circleX,
  ),
  clipboardCheck(
    LucideIcons300.clipboardCheck,
    LucideIcons400.clipboardCheck,
    LucideIcons500.clipboardCheck,
    LucideIcons600.clipboardCheck,
  ),
  cloud(
    LucideIcons300.cloud,
    LucideIcons400.cloud,
    LucideIcons500.cloud,
    LucideIcons600.cloud,
  ),
  cloudAlert(
    LucideIcons300.cloudAlert,
    LucideIcons400.cloudAlert,
    LucideIcons500.cloudAlert,
    LucideIcons600.cloudAlert,
  ),
  cloudCheck(
    LucideIcons300.cloudCheck,
    LucideIcons400.cloudCheck,
    LucideIcons500.cloudCheck,
    LucideIcons600.cloudCheck,
  ),
  cloudDownload(
    LucideIcons300.cloudDownload,
    LucideIcons400.cloudDownload,
    LucideIcons500.cloudDownload,
    LucideIcons600.cloudDownload,
  ),
  cloudOff(
    LucideIcons300.cloudOff,
    LucideIcons400.cloudOff,
    LucideIcons500.cloudOff,
    LucideIcons600.cloudOff,
  ),
  cloudUpload(
    LucideIcons300.cloudUpload,
    LucideIcons400.cloudUpload,
    LucideIcons500.cloudUpload,
    LucideIcons600.cloudUpload,
  ),
  code(
    LucideIcons300.code,
    LucideIcons400.code,
    LucideIcons500.code,
    LucideIcons600.code,
  ),
  contrast(
    LucideIcons300.contrast,
    LucideIcons400.contrast,
    LucideIcons500.contrast,
    LucideIcons600.contrast,
  ),
  copy(
    LucideIcons300.copy,
    LucideIcons400.copy,
    LucideIcons500.copy,
    LucideIcons600.copy,
  ),
  download(
    LucideIcons300.download,
    LucideIcons400.download,
    LucideIcons500.download,
    LucideIcons600.download,
  ),
  ellipsis(
    LucideIcons300.ellipsis,
    LucideIcons400.ellipsis,
    LucideIcons500.ellipsis,
    LucideIcons600.ellipsis,
  ),
  ellipsisVertical(
    LucideIcons300.ellipsisVertical,
    LucideIcons400.ellipsisVertical,
    LucideIcons500.ellipsisVertical,
    LucideIcons600.ellipsisVertical,
  ),
  externalLink(
    LucideIcons300.externalLink,
    LucideIcons400.externalLink,
    LucideIcons500.externalLink,
    LucideIcons600.externalLink,
  ),
  eye(
    LucideIcons300.eye,
    LucideIcons400.eye,
    LucideIcons500.eye,
    LucideIcons600.eye,
  ),
  eyeOff(
    LucideIcons300.eyeOff,
    LucideIcons400.eyeOff,
    LucideIcons500.eyeOff,
    LucideIcons600.eyeOff,
  ),
  fileLock(
    LucideIcons300.fileLock,
    LucideIcons400.fileLock,
    LucideIcons500.fileLock,
    LucideIcons600.fileLock,
  ),
  fileText(
    LucideIcons300.fileText,
    LucideIcons400.fileText,
    LucideIcons500.fileText,
    LucideIcons600.fileText,
  ),
  fileUp(
    LucideIcons300.fileUp,
    LucideIcons400.fileUp,
    LucideIcons500.fileUp,
    LucideIcons600.fileUp,
  ),
  fileXCorner(
    LucideIcons300.fileXCorner,
    LucideIcons400.fileXCorner,
    LucideIcons500.fileXCorner,
    LucideIcons600.fileXCorner,
  ),
  flashlight(
    LucideIcons300.flashlight,
    LucideIcons400.flashlight,
    LucideIcons500.flashlight,
    LucideIcons600.flashlight,
  ),
  fingerprintPattern(
    LucideIcons300.fingerprintPattern,
    LucideIcons400.fingerprintPattern,
    LucideIcons500.fingerprintPattern,
    LucideIcons600.fingerprintPattern,
  ),
  folderInput(
    LucideIcons300.folderInput,
    LucideIcons400.folderInput,
    LucideIcons500.folderInput,
    LucideIcons600.folderInput,
  ),
  folderLock(
    LucideIcons300.folderLock,
    LucideIcons400.folderLock,
    LucideIcons500.folderLock,
    LucideIcons600.folderLock,
  ),
  gripVertical(
    LucideIcons300.gripVertical,
    LucideIcons400.gripVertical,
    LucideIcons500.gripVertical,
    LucideIcons600.gripVertical,
  ),
  imageOff(
    LucideIcons300.imageOff,
    LucideIcons400.imageOff,
    LucideIcons500.imageOff,
    LucideIcons600.imageOff,
  ),
  info(
    LucideIcons300.info,
    LucideIcons400.info,
    LucideIcons500.info,
    LucideIcons600.info,
  ),
  italic(
    LucideIcons300.italic,
    LucideIcons400.italic,
    LucideIcons500.italic,
    LucideIcons600.italic,
  ),
  keyRound(
    LucideIcons300.keyRound,
    LucideIcons400.keyRound,
    LucideIcons500.keyRound,
    LucideIcons600.keyRound,
  ),
  keyboard(
    LucideIcons300.keyboard,
    LucideIcons400.keyboard,
    LucideIcons500.keyboard,
    LucideIcons600.keyboard,
  ),
  languages(
    LucideIcons300.languages,
    LucideIcons400.languages,
    LucideIcons500.languages,
    LucideIcons600.languages,
  ),
  layers(
    LucideIcons300.layers,
    LucideIcons400.layers,
    LucideIcons500.layers,
    LucideIcons600.layers,
  ),
  lifeBuoy(
    LucideIcons300.lifeBuoy,
    LucideIcons400.lifeBuoy,
    LucideIcons500.lifeBuoy,
    LucideIcons600.lifeBuoy,
  ),
  lightbulb(
    LucideIcons300.lightbulb,
    LucideIcons400.lightbulb,
    LucideIcons500.lightbulb,
    LucideIcons600.lightbulb,
  ),
  link(
    LucideIcons300.link,
    LucideIcons400.link,
    LucideIcons500.link,
    LucideIcons600.link,
  ),
  listChecks(
    LucideIcons300.listChecks,
    LucideIcons400.listChecks,
    LucideIcons500.listChecks,
    LucideIcons600.listChecks,
  ),
  loaderCircle(
    LucideIcons300.loaderCircle,
    LucideIcons400.loaderCircle,
    LucideIcons500.loaderCircle,
    LucideIcons600.loaderCircle,
  ),
  lock(
    LucideIcons300.lock,
    LucideIcons400.lock,
    LucideIcons500.lock,
    LucideIcons600.lock,
  ),
  lockKeyhole(
    LucideIcons300.lockKeyhole,
    LucideIcons400.lockKeyhole,
    LucideIcons500.lockKeyhole,
    LucideIcons600.lockKeyhole,
  ),
  logOut(
    LucideIcons300.logOut,
    LucideIcons400.logOut,
    LucideIcons500.logOut,
    LucideIcons600.logOut,
  ),
  mail(
    LucideIcons300.mail,
    LucideIcons400.mail,
    LucideIcons500.mail,
    LucideIcons600.mail,
  ),
  messageCircle(
    LucideIcons300.messageCircle,
    LucideIcons400.messageCircle,
    LucideIcons500.messageCircle,
    LucideIcons600.messageCircle,
  ),
  messageSquare(
    LucideIcons300.messageSquare,
    LucideIcons400.messageSquare,
    LucideIcons500.messageSquare,
    LucideIcons600.messageSquare,
  ),
  minus(
    LucideIcons300.minus,
    LucideIcons400.minus,
    LucideIcons500.minus,
    LucideIcons600.minus,
  ),
  pencil(
    LucideIcons300.pencil,
    LucideIcons400.pencil,
    LucideIcons500.pencil,
    LucideIcons600.pencil,
  ),
  phone(
    LucideIcons300.phone,
    LucideIcons400.phone,
    LucideIcons500.phone,
    LucideIcons600.phone,
  ),
  plus(
    LucideIcons300.plus,
    LucideIcons400.plus,
    LucideIcons500.plus,
    LucideIcons600.plus,
  ),
  refreshCw(
    LucideIcons300.refreshCw,
    LucideIcons400.refreshCw,
    LucideIcons500.refreshCw,
    LucideIcons600.refreshCw,
  ),
  repeat2(
    LucideIcons300.repeat2,
    LucideIcons400.repeat2,
    LucideIcons500.repeat2,
    LucideIcons600.repeat2,
  ),
  rotateCcwClock(
    LucideIcons300.rotateCcwClock,
    LucideIcons400.rotateCcwClock,
    LucideIcons500.rotateCcwClock,
    LucideIcons600.rotateCcwClock,
  ),
  rotateCw(
    LucideIcons300.rotateCw,
    LucideIcons400.rotateCw,
    LucideIcons500.rotateCw,
    LucideIcons600.rotateCw,
  ),
  scale(
    LucideIcons300.scale,
    LucideIcons400.scale,
    LucideIcons500.scale,
    LucideIcons600.scale,
  ),
  scanFace(
    LucideIcons300.scanFace,
    LucideIcons400.scanFace,
    LucideIcons500.scanFace,
    LucideIcons600.scanFace,
  ),
  scanQrCode(
    LucideIcons300.scanQrCode,
    LucideIcons400.scanQrCode,
    LucideIcons500.scanQrCode,
    LucideIcons600.scanQrCode,
  ),
  search(
    LucideIcons300.search,
    LucideIcons400.search,
    LucideIcons500.search,
    LucideIcons600.search,
  ),
  serverOff(
    LucideIcons300.serverOff,
    LucideIcons400.serverOff,
    LucideIcons500.serverOff,
    LucideIcons600.serverOff,
  ),
  settings(
    LucideIcons300.settings,
    LucideIcons400.settings,
    LucideIcons500.settings,
    LucideIcons600.settings,
  ),
  settings2(
    LucideIcons300.settings2,
    LucideIcons400.settings2,
    LucideIcons500.settings2,
    LucideIcons600.settings2,
  ),
  share(
    LucideIcons300.share,
    LucideIcons400.share,
    LucideIcons500.share,
    LucideIcons600.share,
  ),
  shieldAlert(
    LucideIcons300.shieldAlert,
    LucideIcons400.shieldAlert,
    LucideIcons500.shieldAlert,
    LucideIcons600.shieldAlert,
  ),
  shieldCheck(
    LucideIcons300.shieldCheck,
    LucideIcons400.shieldCheck,
    LucideIcons500.shieldCheck,
    LucideIcons600.shieldCheck,
  ),
  shieldX(
    LucideIcons300.shieldX,
    LucideIcons400.shieldX,
    LucideIcons500.shieldX,
    LucideIcons600.shieldX,
  ),
  smartphone(
    LucideIcons300.smartphone,
    LucideIcons400.smartphone,
    LucideIcons500.smartphone,
    LucideIcons600.smartphone,
  ),
  sparkles(
    LucideIcons300.sparkles,
    LucideIcons400.sparkles,
    LucideIcons500.sparkles,
    LucideIcons600.sparkles,
  ),
  star(
    LucideIcons300.star,
    LucideIcons400.star,
    LucideIcons500.star,
    LucideIcons600.star,
  ),
  sunMoon(
    LucideIcons300.sunMoon,
    LucideIcons400.sunMoon,
    LucideIcons500.sunMoon,
    LucideIcons600.sunMoon,
  ),
  tag(
    LucideIcons300.tag,
    LucideIcons400.tag,
    LucideIcons500.tag,
    LucideIcons600.tag,
  ),
  tags(
    LucideIcons300.tags,
    LucideIcons400.tags,
    LucideIcons500.tags,
    LucideIcons600.tags,
  ),
  textCursorInput(
    LucideIcons300.textCursorInput,
    LucideIcons400.textCursorInput,
    LucideIcons500.textCursorInput,
    LucideIcons600.textCursorInput,
  ),
  timer(
    LucideIcons300.timer,
    LucideIcons400.timer,
    LucideIcons500.timer,
    LucideIcons600.timer,
  ),
  trash(
    LucideIcons300.trash,
    LucideIcons400.trash,
    LucideIcons500.trash,
    LucideIcons600.trash,
  ),
  triangleAlert(
    LucideIcons300.triangleAlert,
    LucideIcons400.triangleAlert,
    LucideIcons500.triangleAlert,
    LucideIcons600.triangleAlert,
  ),
  type(
    LucideIcons300.type,
    LucideIcons400.type,
    LucideIcons500.type,
    LucideIcons600.type,
  ),
  undo2(
    LucideIcons300.undo2,
    LucideIcons400.undo2,
    LucideIcons500.undo2,
    LucideIcons600.undo2,
  ),
  userRound(
    LucideIcons300.userRound,
    LucideIcons400.userRound,
    LucideIcons500.userRound,
    LucideIcons600.userRound,
  ),
  wandSparkles(
    LucideIcons300.wandSparkles,
    LucideIcons400.wandSparkles,
    LucideIcons500.wandSparkles,
    LucideIcons600.wandSparkles,
  ),
  wifiOff(
    LucideIcons300.wifiOff,
    LucideIcons400.wifiOff,
    LucideIcons500.wifiOff,
    LucideIcons600.wifiOff,
  ),
  x(LucideIcons300.x, LucideIcons400.x, LucideIcons500.x, LucideIcons600.x);

  const AppIconName(this.w300, this.w400, this.w500, this.w600);

  final IconData w300;
  final IconData w400;
  final IconData w500;
  final IconData w600;

  /// The glyph for a design stroke width. The package has no 1.75 or 2.25,
  /// so strokes round down to the next lighter weight (decision 2026-10-30):
  /// 1.5–1.75 → 1.5, 2–2.4 → 2.0, 2.5–2.75 → 2.5, 3 → 3.0.
  IconData forStroke(double stroke) {
    if (stroke < 2) return w300;
    if (stroke < 2.5) return w400;
    if (stroke < 3) return w500;
    return w600;
  }
}

/// Lucide sizes and their design strokes (Iconography: "Stroke follows size").
abstract final class AppIconSizes {
  /// Pills, badges and status lines.
  static const double xs = 14;

  /// Pills, badges and status lines.
  static const double sm = 16;

  /// Row and field actions.
  static const double md = 20;

  /// Top bar actions and tabs.
  static const double lg = 24;

  /// 14 → 2.25, 16 → 2, 20 and 24 → 1.75.
  static double strokeFor(double size) {
    if (size <= xs) return 2.25;
    if (size <= sm) return 2;
    return 1.75;
  }
}

/// A Lucide interface icon at its design size and stroke.
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    this.size = AppIconSizes.lg,
    this.stroke,
    this.color,
    this.semanticLabel,
    super.key,
  });

  final AppIconName icon;

  /// Size in design points (scaled with ScreenUtil).
  final double size;

  /// Design stroke width; defaults to the size rule ([AppIconSizes.strokeFor]).
  final double? stroke;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon.forStroke(stroke ?? AppIconSizes.strokeFor(size)),
      size: size.r,
      color: color,
      semanticLabel: semanticLabel,
    );
  }
}

/// Font Awesome weights (board: Iconography). Light by default — every item
/// tile, icons picked from the catalogue included (plan O9; the web draws
/// those in Solid). Solid only for filled states such as a favourite.
enum FaWeight {
  light(FontWeight.w300),
  solid(FontWeight.w900);

  const FaWeight(this.fontWeight);

  final FontWeight fontWeight;
}

/// A Font Awesome glyph drawn as text in the bundled font (never runtime
/// IconData, which would break Flutter's icon tree-shaking in release builds
/// — plan, porting trap 7). Takes any code point, so a user-picked icon from
/// the catalogue renders too.
class FaGlyph extends StatelessWidget {
  const FaGlyph(
    this.codePoint, {
    this.size = AppIconSizes.lg,
    this.weight = FaWeight.light,
    this.color,
    this.semanticLabel,
    super.key,
  });

  /// From a stored hex code point such as `f02b` (a vault item's `iconGlyph`).
  FaGlyph.hex(
    String hex, {
    double size = AppIconSizes.lg,
    FaWeight weight = FaWeight.light,
    Color? color,
    String? semanticLabel,
    Key? key,
  }) : this(
         int.parse(hex, radix: 16),
         size: size,
         weight: weight,
         color: color,
         semanticLabel: semanticLabel,
         key: key,
       );

  static const String fontFamily = 'FontAwesome';

  final int codePoint;

  /// Size in design points (scaled with ScreenUtil).
  final double size;
  final FaWeight weight;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Widget glyph = Text(
      String.fromCharCode(codePoint),
      textScaler: TextScaler.noScaling,
      textAlign: TextAlign.center,
      style: TextStyle(
        inherit: false,
        fontFamily: fontFamily,
        fontWeight: weight.fontWeight,
        fontSize: size.r,
        height: 1,
        color: color ?? IconTheme.of(context).color,
      ),
    );

    if (semanticLabel == null) return ExcludeSemantics(child: glyph);
    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(child: glyph),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('codePoint', codePoint.toRadixString(16)));
  }
}

/// The web app's Font Awesome glyph names (icon-glyphs.ts), as code points.
abstract final class FaGlyphs {
  /// fa-plus
  static const int add = 0x002b;

  /// fa-xmark
  static const int cancel = 0xf00d;

  /// fa-ellipsis
  static const int more = 0xf141;

  /// fa-magnifying-glass
  static const int search = 0xf002;

  /// fa-gear
  static const int settings = 0xf013;

  /// fa-headset
  static const int support = 0xf590;

  /// fa-file-contract
  static const int policies = 0xf56c;

  /// fa-chevron-down
  static const int chevronDown = 0xf078;

  /// fa-chevron-left
  static const int chevronLeft = 0xf053;

  /// fa-chevron-right
  static const int chevronRight = 0xf054;

  /// fa-circle-arrow-left
  static const int circleArrowLeft = 0xf0a8;

  /// fa-circle-arrow-right
  static const int circleArrowRight = 0xf0a9;

  /// fa-arrow-up
  static const int arrowUp = 0xf062;

  /// fa-arrow-down
  static const int arrowDown = 0xf063;

  /// fa-arrow-left
  static const int arrowLeft = 0xf060;

  /// fa-arrow-right
  static const int arrowRight = 0xf061;

  /// fa-arrow-up-short-wide
  static const int sortAsc = 0xf885;

  /// fa-arrow-down-short-wide
  static const int sortDesc = 0xf884;

  /// fa-triangle-exclamation
  static const int alert = 0xf071;

  /// fa-circle-check
  static const int success = 0xf058;

  /// fa-check
  static const int check = 0xf00c;

  /// fa-ban
  static const int forbidden = 0xf05e;

  /// fa-circle-info
  static const int infoCircle = 0xf05a;

  /// fa-square-check
  static const int checkboxChecked = 0xf14a;

  /// fa-square
  static const int checkboxUnchecked = 0xf0c8;

  /// fa-check-double
  static const int selectAll = 0xf560;

  /// fa-vault
  static const int vault = 0xe2c5;

  /// fa-layer-group
  static const int vaults = 0xf5fd;

  /// fa-tag
  static const int tag = 0xf02b;

  /// fa-tags
  static const int tags = 0xf02c;

  /// fa-star
  static const int favourite = 0xf005;

  /// fa-pen-field
  static const int field = 0xe211;

  /// fa-file
  static const int file = 0xf15b;

  /// fa-rectangle-history
  static const int history = 0xe4a2;

  /// fa-copy
  static const int copy = 0xf0c5;

  /// fa-pen-to-square
  static const int edit = 0xf044;

  /// fa-trash
  static const int delete = 0xf1f8;

  /// fa-up-down-left-right
  static const int move = 0xf0b2;

  /// fa-wand-magic-sparkles
  static const int generate = 0xe2ca;

  /// fa-rotate
  static const int refresh = 0xf2f1;

  /// fa-file-export
  static const int export = 0xf56e;

  /// fa-file-import
  static const int import = 0xf56f;

  /// fa-cloud
  static const int cloud = 0xf0c2;

  /// fa-lock-keyhole
  static const int lock = 0xf30d;

  /// fa-unlock-keyhole
  static const int unlock = 0xf13e;

  /// fa-right-to-bracket
  static const int login = 0xf2f6;

  /// fa-right-from-bracket
  static const int disconnect = 0xf2f5;

  /// fa-user
  static const int user = 0xf007;

  /// fa-shield-exclamation
  static const int weak = 0xe247;

  /// fa-recycle
  static const int reused = 0xf1b8;

  /// fa-user-secret
  static const int compromised = 0xf21b;

  /// fa-shield-check
  static const int auditClean = 0xf2f7;

  /// fa-key
  static const int password = 0xf084;

  /// fa-eye
  static const int show = 0xf06e;

  /// fa-eye-slash
  static const int hide = 0xf070;

  /// fa-at
  static const int email = 0x0040;

  /// fa-envelope
  static const int mail = 0xf0e0;

  /// fa-earth-americas
  static const int web = 0xf57d;

  /// fa-phone
  static const int phone = 0xf095;

  /// fa-credit-card
  static const int credit = 0xf09d;

  /// fa-calendar-days
  static const int date = 0xf073;

  /// fa-calendar
  static const int month = 0xf133;

  /// fa-clock
  static const int time = 0xf017;

  /// fa-clock-rotate-left
  static const int totp = 0xf1da;

  /// fa-memo-pad
  static const int note = 0xe1da;

  /// fa-text
  static const int text = 0xf893;

  /// fa-note-sticky
  static const int custom = 0xf249;

  /// fa-laptop
  static const int computer = 0xf109;

  /// fa-building-columns
  static const int bank = 0xf19c;

  /// fa-wifi
  static const int wifi = 0xf1eb;

  /// fa-passport
  static const int passport = 0xf5ab;

  /// fa-h1
  static const int heading1 = 0xf313;

  /// fa-h2
  static const int heading2 = 0xf314;

  /// fa-h3
  static const int heading3 = 0xf315;

  /// fa-list-ul
  static const int listUl = 0xf0ca;

  /// fa-list-ol
  static const int listOl = 0xf0cb;

  /// fa-list-check
  static const int listCheck = 0xf0ae;

  /// fa-sun-bright
  static const int themeLight = 0xe28f;

  /// fa-moon-stars
  static const int themeDark = 0xf755;

  /// fa-circle-half-stroke
  static const int themeAuto = 0xf042;

  /// Every glyph above by the web's icon name (`ICON_GLYPHS`), for names
  /// stored in the vault (an item's `icon`).
  static const Map<String, int> byName = <String, int>{
    'add': 0x002b,
    'cancel': 0xf00d,
    'more': 0xf141,
    'search': 0xf002,
    'settings': 0xf013,
    'support': 0xf590,
    'policies': 0xf56c,
    'chevron-down': 0xf078,
    'chevron-left': 0xf053,
    'chevron-right': 0xf054,
    'circle-arrow-left': 0xf0a8,
    'circle-arrow-right': 0xf0a9,
    'arrow-up': 0xf062,
    'arrow-down': 0xf063,
    'arrow-left': 0xf060,
    'arrow-right': 0xf061,
    'sort-asc': 0xf885,
    'sort-desc': 0xf884,
    'alert': 0xf071,
    'success': 0xf058,
    'check': 0xf00c,
    'forbidden': 0xf05e,
    'info-circle': 0xf05a,
    'checkbox-checked': 0xf14a,
    'checkbox-unchecked': 0xf0c8,
    'select-all': 0xf560,
    'vault': 0xe2c5,
    'vaults': 0xf5fd,
    'tag': 0xf02b,
    'tags': 0xf02c,
    'favourite': 0xf005,
    'field': 0xe211,
    'file': 0xf15b,
    'history': 0xe4a2,
    'copy': 0xf0c5,
    'edit': 0xf044,
    'delete': 0xf1f8,
    'move': 0xf0b2,
    'generate': 0xe2ca,
    'refresh': 0xf2f1,
    'export': 0xf56e,
    'import': 0xf56f,
    'cloud': 0xf0c2,
    'lock': 0xf30d,
    'unlock': 0xf13e,
    'login': 0xf2f6,
    'disconnect': 0xf2f5,
    'user': 0xf007,
    'weak': 0xe247,
    'reused': 0xf1b8,
    'compromised': 0xf21b,
    'audit-clean': 0xf2f7,
    'password': 0xf084,
    'show': 0xf06e,
    'hide': 0xf070,
    'email': 0x0040,
    'mail': 0xf0e0,
    'web': 0xf57d,
    'phone': 0xf095,
    'credit': 0xf09d,
    'date': 0xf073,
    'month': 0xf133,
    'time': 0xf017,
    'totp': 0xf1da,
    'note': 0xe1da,
    'text': 0xf893,
    'custom': 0xf249,
    'computer': 0xf109,
    'bank': 0xf19c,
    'wifi': 0xf1eb,
    'passport': 0xf5ab,
    'heading-1': 0xf313,
    'heading-2': 0xf314,
    'heading-3': 0xf315,
    'list-ul': 0xf0ca,
    'list-ol': 0xf0cb,
    'list-check': 0xf0ae,
    'theme-light': 0xe28f,
    'theme-dark': 0xf755,
    'theme-auto': 0xf042,
  };
}
