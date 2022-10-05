import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

TargetPlatform? platform;

mixin PlatformMixin<T> {
  T android(BuildContext context);
  T ios(BuildContext context);
  T macos(BuildContext context);
  T windows(BuildContext context);
  T linux(BuildContext context);

  T getPlatformType(BuildContext context) {
    if (kIsWeb) return android(context);
    switch (platform ?? defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return ios(context);
      case TargetPlatform.macOS:
        return macos(context);
      case TargetPlatform.windows:
        return windows(context);
      case TargetPlatform.linux:
        return linux(context);
      case TargetPlatform.android:
      default:
        return android(context);
    }
  }
}
