import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_template/config/app_routes.dart';
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

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _startSplashDelay();
  }

  void _startSplashDelay() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.catalog);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Assignment for Codenzia',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(221, 228, 18, 203),
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
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
