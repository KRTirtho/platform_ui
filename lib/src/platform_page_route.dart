import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

// ignore: non_constant_identifier_names
PageRoute<T> PlatformPageRoute<T>({
  required WidgetBuilder builder,
  bool fullscreenDialog = false,
  RouteSettings? settings,
}) {
  switch (platform) {
    case TargetPlatform.macOS:
    case TargetPlatform.iOS:
      return CupertinoPageRoute<T>(
        builder: builder,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );
    case TargetPlatform.windows:
      return FluentPageRoute<T>(
        builder: builder,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );
    case TargetPlatform.android:
    case TargetPlatform.linux:
    default:
      return MaterialPageRoute<T>(
        builder: builder,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );
  }
}
