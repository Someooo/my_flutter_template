import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light => _lightTheme;
  static ThemeData get dark => _darkTheme;

  static ThemeData get _lightTheme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppLightColors.appBackgroundColor,
        primaryColor: AppLightColors.primaryColor,
        colorScheme: ColorScheme.light(
          brightness: Brightness.light,
          primary: AppLightColors.primaryColor,
          secondary: AppLightColors.secondaryColor,
          surface: AppLightColors.appBackgroundColor,
          primaryContainer: AppLightColors.grayColor,
          secondaryContainer: AppLightColors.lightGrayColor,
          error: AppLightColors.redColor,
          tertiary: AppLightColors.greenColor,
          inverseSurface: const Color(0xffFBF1FF),
          shadow: const Color(0x0FFF4F4F),
          onInverseSurface: AppLightColors.blackColor,
          onPrimary: AppLightColors.textColor,
          onSecondary: AppLightColors.textLightColor,
          onPrimaryContainer: AppLightColors.cardHeaderColor,
          onSecondaryContainer: AppLightColors.cardBackgroundColor,
          onTertiaryContainer: AppLightColors.cardWhiteColor,
          tertiaryContainer: AppLightColors.scaffoldBackground,
          inversePrimary: AppLightColors.settingCardBackground,
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppLightColors.textColor),
          foregroundColor: AppLightColors.textColor,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        iconTheme: const IconThemeData(color: AppLightColors.primaryColor),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
        shadowColor: AppLightColors.grayColor,
        textTheme: TextTheme(
          titleMedium: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 9,
            fontWeight: FontWeight.w400,
            color: AppLightColors.grayTextColor,
            height: 1.4.h,
            letterSpacing: 0,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: AppLightColors.grayTextColor,
            height: 1.4.h,
            letterSpacing: 0,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppLightColors.grayTextColor,
            height: 1.4.h,
            letterSpacing: 0,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppLightColors.grayTextColor,
            height: 1.4.h,
            letterSpacing: 0,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppLightColors.grayTextColor,
            height: 1.4.h,
            letterSpacing: 0,
          ),
          displaySmall: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppLightColors.grayTextColor,
            height: 0.h,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppLightColors.textColor,
            height: 0.h,
          ),
          displayLarge: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppLightColors.textColor,
            height: 1.4.h,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppLightColors.textColor,
            height: 1.4.h,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppLightColors.textColor,
            height: 1.4.h,
          ),
          headlineLarge: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppLightColors.textColor,
            height: 1.4.h,
          ),
        ),
      );

  static ThemeData get _darkTheme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppDarkColors.backgroundColor,
        primaryColor: AppDarkColors.primaryColor,
        colorScheme: ColorScheme.dark(
          brightness: Brightness.dark,
          primary: AppDarkColors.primaryColor,
          secondary: AppDarkColors.secondaryColor,
          surface: AppDarkColors.backgroundColor,
          primaryContainer: AppDarkColors.grayColor,
          secondaryContainer: AppDarkColors.lightGrayColor,
          shadow: AppDarkColors.darkGrayColor,
          error: AppDarkColors.redColor,
          tertiary: AppDarkColors.greenColor,
          onPrimary: AppDarkColors.textColor,
          onSecondary: AppDarkColors.textLightColor,
          onInverseSurface: AppDarkColors.whiteColor,
          onPrimaryContainer: AppDarkColors.cardHeaderColor,
          onSecondaryContainer: AppDarkColors.cardBackgroundColor,
          onTertiaryContainer: AppDarkColors.cardWhiteColor,
          tertiaryContainer: AppDarkColors.backgroundColor,
          inversePrimary: AppDarkColors.settingCardBackground,
        ),
        iconTheme: const IconThemeData(color: AppDarkColors.primaryColor),
        shadowColor: AppDarkColors.grayColor,
        textTheme: TextTheme(
          displaySmall: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppDarkColors.darkGrayColor,
            height: 1.4.h,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppDarkColors.grayColor,
            height: 1.4.h,
          ),
          displayLarge: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppDarkColors.textColor,
            height: 1.4.h,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppLightColors.grayColor,
            height: 1.4.h,
          ),
          headlineLarge: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppLightColors.grayColor,
            height: 1.4.h,
          ),
        ),
      );
}
