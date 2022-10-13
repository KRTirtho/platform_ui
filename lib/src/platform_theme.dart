import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/src/platform_button.dart';

class PlatformThemeData {
  final PlatformButtonThemeData? buttonTheme;
  PlatformThemeData({this.buttonTheme});
}

class PlatformTheme extends InheritedWidget {
  final PlatformThemeData theme;

  const PlatformTheme({
    required Widget child,
    required this.theme,
    Key? key,
  }) : super(child: child, key: key);

  static PlatformThemeData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PlatformTheme>()?.theme;
  }

  @override
  bool updateShouldNotify(PlatformTheme oldWidget) {
    return oldWidget.theme != theme || oldWidget.child != child;
  }
}
