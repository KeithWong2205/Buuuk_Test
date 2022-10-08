import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  final Map<String, String>? configUrl;

  AppConfig({
    Key? key,
    @required Widget? child,
    @required this.configUrl,
  }) : super(key: key, child: child!);

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
