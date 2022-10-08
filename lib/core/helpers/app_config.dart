import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    Key? key,
    @required Widget? child,
  }) : super(key: key, child: child!);

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
