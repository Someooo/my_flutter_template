// Main entry point for the application. Initializes core dependencies and runs the app shell.

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_template/app.dart';
import 'package:my_template/di.dart';

Future<void> main() async {
  // Preserve the native splash screen during initialization
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize dependencies (DI, services, controllers, etc.)
  await configureDependencies();

  // Remove the native splash screen now that the app is ready
  FlutterNativeSplash.remove();

  // Launch the app
  runApp(const AppEntrypoint());
}
