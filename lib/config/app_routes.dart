// Declares application route paths for each feature module.

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String initial = '/';
  static const String profile = '/profile';
  static const String family = '/family';
  static const String prescriptions = '/prescriptions';
  static const String medicalNetwork = '/medical-network';
  static const String insurance = '/insurance';
  static const String authLogin = '/auth/login';
  static const String authSignup = '/auth/signup';
  static const String notifications = '/notifications';

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(name: initial, page: () => const SizedBox.shrink()),
    GetPage(name: profile, page: () => const SizedBox.shrink()),
    GetPage(name: family, page: () => const SizedBox.shrink()),
    GetPage(name: prescriptions, page: () => const SizedBox.shrink()),
    GetPage(name: medicalNetwork, page: () => const SizedBox.shrink()),
    GetPage(name: insurance, page: () => const SizedBox.shrink()),
    GetPage(name: authLogin, page: () => const SizedBox.shrink()),
    GetPage(name: authSignup, page: () => const SizedBox.shrink()),
    GetPage(name: notifications, page: () => const SizedBox.shrink()),
  ];
}
