// Placeholder controller for managing localization settings.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  static const Locale fallbackLocale = Locale('en');

  Locale get locale => fallbackLocale;
}
