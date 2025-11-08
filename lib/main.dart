// Main entry point for the application. Initializes core dependencies and runs the app shell.

import 'package:flutter/material.dart';
import 'package:my_template/app.dart';
import 'package:my_template/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(const AppEntrypoint());
}
