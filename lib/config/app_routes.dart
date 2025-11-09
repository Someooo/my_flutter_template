// Declares application route paths for each feature module.

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String initial = '/';

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(name: initial, page: () => const SizedBox.shrink()),
   
  ];
}
