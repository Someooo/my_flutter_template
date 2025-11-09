// Declares application route paths for each feature module.

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_template/features/home/presentation/screens/home_scrren.dart';

class AppRoutes {
  static const String home = '/home';
  static const String initial = home;

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(name: home, page: () => const HomeScreen()),
  ];
}
