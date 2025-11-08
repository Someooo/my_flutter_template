// Centralized dependency registration using GetX bindings.

import 'package:get/get.dart';
import 'package:my_template/core/controllers/theme_controller.dart';
import 'package:my_template/core/controllers/language_controller.dart';
import 'package:my_template/core/services/api_service.dart';
import 'package:my_template/core/services/storage_service.dart';

Future<void> configureDependencies() async {
  Get.put<ApiService>(ApiService());
  Get.put<StorageService>(StorageService());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
}
