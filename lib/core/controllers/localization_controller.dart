import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  static const Locale fallbackLocale = Locale('en', 'US');
  static final List<Locale> supportedLocales = <Locale>[
    const Locale('en', 'US'),
    const Locale('ar', 'SA'),
  ];

  final Rx<Locale> _locale = fallbackLocale.obs;

  Locale get locale => _locale.value;

  void changeLocale(Locale locale) {
    if (!supportedLocales.contains(locale)) {
      return;
    }
    _locale.value = locale;
    Get.updateLocale(locale);
  }
}
