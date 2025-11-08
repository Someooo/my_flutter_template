// Placeholder controller responsible for handling theme-related state.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  void setThemeMode(ThemeMode mode) => _themeMode.value = mode;
}
