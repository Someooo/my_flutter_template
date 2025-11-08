import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_template/core/controllers/auth_controller.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String loginRoute = '/auth/login';

  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage(
      name: splashRoute,
      page: () => const SplashPage(),
      binding: BindingsBuilder(() {
        Get.find<AuthController>().initialize();
      }),
    ),
    GetPage(
      name: loginRoute,
      page: () => const LoginPlaceholderPage(),
    ),
  ];
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class LoginPlaceholderPage extends StatelessWidget {
  const LoginPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.find<AuthController>().login('fake-token'),
          child: const Text('Perform login'),
        ),
      ),
    );
  }
}
