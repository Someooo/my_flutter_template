// Defines the root widget configuring theme, localization, and routing for the app shell.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_template/config/app_routes.dart';
import 'package:my_template/config/app_theme.dart';
import 'package:my_template/core/localization/app_localization.dart';
import 'package:my_template/core/controllers/theme_controller.dart';
import 'package:my_template/core/controllers/language_controller.dart';

class AppEntrypoint extends StatelessWidget {
  const AppEntrypoint({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'My Template App',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initial,
          getPages: AppRoutes.pages,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: Get.find<ThemeController>().themeMode,
          translations: AppLocalization(),
          locale: Get.find<LanguageController>().locale,
          fallbackLocale: LanguageController.fallbackLocale,
        );
      },
    );
  }
}
