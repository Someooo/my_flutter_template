// Centralized dependency registration using GetX bindings.

import 'package:get/get.dart';
import 'package:my_template/core/controllers/theme_controller.dart';
import 'package:my_template/core/controllers/language_controller.dart';
import 'package:my_template/core/services/api_service.dart';
import 'package:my_template/core/services/storage_service.dart';
import 'package:my_template/features/catalog/data/datasources/catalog_local_data_source.dart';
import 'package:my_template/features/catalog/data/repositories/catalog_repository_impl.dart';
import 'package:my_template/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:my_template/features/catalog/presentation/controllers/catalog_controller.dart';

Future<void> configureDependencies() async {
  Get.put<ApiService>(ApiService());
  Get.put<StorageService>(StorageService());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());

  // Catalog feature
  Get.put<CatalogLocalDataSource>(CatalogLocalDataSourceImpl());
  Get.put<CatalogRepository>(
    CatalogRepositoryImpl(dataSource: Get.find<CatalogLocalDataSource>()),
  );
  Get.put<CatalogController>(
    CatalogController(repository: Get.find<CatalogRepository>()),
  );
}
