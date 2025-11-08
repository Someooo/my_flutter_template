// Provides light and dark theme configurations for the application.

import 'package:flutter/material.dart';
import 'package:my_template/config/app_colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(primaryColor: AppColors.primary);

  static ThemeData get dark => ThemeData(primaryColor: AppColors.secondary);
}
