import 'package:flutter/material.dart';

import 'zzz_colors.dart';
import 'zzz_shapes.dart';

/// Motion tokens from DESIGN.md.
const Duration zzzDuration = Duration(milliseconds: 200);
const Curve zzzCurve = Curves.easeOutCubic;

/// Builds the single dark theme. Views read styles from here, never inline.
abstract final class ZzzTheme {
  static ThemeData get dark {
    const textTheme = TextTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        color: ZzzColors.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.italic,
        color: ZzzColors.textPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: ZzzColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ZzzColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ZzzColors.textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ZzzColors.textMuted,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ZzzColors.background,
      colorScheme: const ColorScheme.dark(
        primary: ZzzColors.accent,
        onPrimary: ZzzColors.onAccent,
        secondary: ZzzColors.info,
        onSecondary: ZzzColors.background,
        error: ZzzColors.danger,
        onError: ZzzColors.background,
        surface: ZzzColors.surface,
        onSurface: ZzzColors.textPrimary,
        outline: ZzzColors.outline,
        outlineVariant: ZzzColors.outline,
      ),
      textTheme: textTheme,
      iconTheme: const IconThemeData(color: ZzzColors.textPrimary),
      dividerTheme: const DividerThemeData(
        color: ZzzColors.outline,
        thickness: ZzzSizes.border,
        space: ZzzSpacing.lg,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ZzzColors.background,
        surfaceTintColor: Colors.transparent,
        foregroundColor: ZzzColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall,
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        hintStyle: textTheme.bodySmall,
        errorStyle: const TextStyle(fontSize: 12, color: ZzzColors.danger),
        border: InputBorder.none,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ZzzColors.accent,
        linearTrackColor: ZzzColors.surfaceRaised,
        linearMinHeight: ZzzSpacing.sm,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ZzzColors.accent,
        foregroundColor: ZzzColors.onAccent,
        elevation: 0,
        shape: zzzShape,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ZzzColors.surfaceRaised,
        contentTextStyle: textTheme.bodyMedium,
        behavior: SnackBarBehavior.floating,
        shape: zzzShape,
      ),
    );
  }
}
