import 'package:get/get.dart';

import '../app_router.dart';
import '../features/catalog/presentation/screens/catalog_screen.dart';

class AppRoutes {
  /// Route name for the splash screen.
  static const String initial = '/';

  /// Route name for the catalog browsing screen.
  static const String catalog = '/catalog';

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: initial,
      page: () => const SplashPage(),
    ),
    GetPage<dynamic>(
      name: catalog,
      page: () => const CatalogScreen(),
    ),
  ];
}
