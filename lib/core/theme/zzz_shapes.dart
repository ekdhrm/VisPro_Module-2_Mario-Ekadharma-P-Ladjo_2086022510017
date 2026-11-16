import 'package:flutter/material.dart';

/// Spacing tokens from DESIGN.md. Use these instead of raw pixel values.
abstract final class ZzzSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

/// Fixed sizes that are not part of the spacing scale.
abstract final class ZzzSizes {
  static const double minTapTarget = 48;
  static const double icon = 24;
  static const double iconLarge = 48;
  static const double thumbnailWidth = 72;
  static const double thumbnailHeight = 96;
  static const double cardExtent = 152;
  static const double heroHeight = 240;
  static const double stripeGap = 16;
  static const double border = 1;
  static const double borderStrong = 2;
}

/// Chamfered corners used by every panel, button, and input.
const double zzzRadius = 12;

/// The one shape used across the app. Pass [side] to highlight a focused item.
const BeveledRectangleBorder zzzShape = BeveledRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(zzzRadius),
    bottomRight: Radius.circular(zzzRadius),
  ),
);

/// Tags are allowed a small tilt so they read as stickers.
const double zzzTagAngle = -0.15;
