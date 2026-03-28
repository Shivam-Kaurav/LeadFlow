import 'package:flutter/material.dart';
import 'package:leadflow/core/theme/app_colors.dart';
import 'package:leadflow/core/theme/app_text_styles.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    //colors
    scaffoldBackgroundColor: AppColors.scaffoldBacground,
    primaryColor: AppColors.primary,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.scaffoldBacground,
    ),

    //app bar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.scaffoldBacground,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    //buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    //Text
    textTheme: const TextTheme(
      titleLarge: AppTextStyles.heading,
      titleMedium: AppTextStyles.subHeading,
      bodyMedium: AppTextStyles.body,
      bodySmall: AppTextStyles.caption,
    ),

    //card
    cardTheme: CardThemeData(
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      elevation: 2,
    ),

    //Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputField,
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),

    //icons
    iconTheme: const IconThemeData(color: Colors.white),
    //divider
    dividerColor: AppColors.border,
  );
}
