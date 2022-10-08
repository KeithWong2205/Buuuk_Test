import 'package:buuk_test/core/helpers/app_config.dart';
import 'package:buuk_test/core/helpers/app_utils.dart';
import 'package:buuk_test/my_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppUtils.init();
  runApp(
    AppConfig(
      child: const MyApp(),
    ),
  );
}
