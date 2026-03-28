import 'package:flutter/material.dart';
import 'package:leadflow/core/theme/app_colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.primaryText,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.primaryText,
  );
}
