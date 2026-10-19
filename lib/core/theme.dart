import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primarySeed),
      useMaterial3: true,
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}