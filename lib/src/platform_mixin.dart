import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

TargetPlatform? platform;

mixin PlatformMixin<T> {
  T android();
  T ios();
  T macos();
  T windows();
  T linux();

  T getPlatformType(BuildContext context) {
    if (kIsWeb) return android();
    switch (platform ?? defaultTargetPlatform) {
      case TargetPlatform.android:
        return android();
      case TargetPlatform.iOS:
        return ios();
      case TargetPlatform.macOS:
        return macos();
      case TargetPlatform.windows:
        return windows();
      case TargetPlatform.linux:
        return linux();
      default:
        return android();
    }
  }
}
