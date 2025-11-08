import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

abstract class AppWidgetBorder {
  AppWidgetBorder._();

  static InputBorder enabledBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: AppLightColors.primaryColor),
    borderRadius: BorderRadius.circular(AppBorderRadius.sm8),
  );

  static InputBorder disabledBorder = OutlineInputBorder(
    borderSide:  BorderSide(
      color: AppLightColors.secondaryGreyColor,
    ),
    borderRadius: BorderRadius.circular(AppBorderRadius.sm8),
  );
  static InputBorder focusedBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppLightColors.whiteColor,
    ),
    borderRadius: BorderRadius.circular(AppBorderRadius.xxl30),
  );
  static InputBorder focusedUnderlineBorder = const UnderlineInputBorder();
  static InputBorder noneBorder = InputBorder.none;
  static InputBorder errorBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppLightColors.redColor,
    ),
    borderRadius: BorderRadius.circular(AppBorderRadius.sm8),
  );
  static InputBorder border = OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppLightColors.primaryColor,
    ),
    borderRadius: BorderRadius.circular(AppBorderRadius.sm8),
  );
}

abstract class AppBorderRadius {
  AppBorderRadius._();

  static const double sm8 = 8.0;
  static const double md12 = 12.0;
  static const double md15 = 15.0;
  static const double l20 = 20.0;
  static const double xl25 = 25.0;
  static const double xxl30 = 30.0;
}
