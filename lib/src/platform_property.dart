import 'package:flutter/services.dart';

class PlatformProperty<T> {
  final T android;
  final T ios;
  final T windows;
  final T macos;
  final T linux;
  const PlatformProperty({
    required this.android,
    required this.ios,
    required this.linux,
    required this.windows,
    required this.macos,
  });

  T resolve(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.linux:
        return linux;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      default:
        return android;
    }
  }

  static PlatformProperty all<T>(T value) {
    return PlatformProperty<T>(
      android: value,
      ios: value,
      windows: value,
      macos: value,
      linux: value,
    );
  }

  static PlatformProperty resolveWith<T>(
      T Function(TargetPlatform platform) resolver) {
    return PlatformProperty<T>(
      android: resolver(TargetPlatform.android),
      ios: resolver(TargetPlatform.iOS),
      windows: resolver(TargetPlatform.windows),
      macos: resolver(TargetPlatform.macOS),
      linux: resolver(TargetPlatform.linux),
    );
  }
}

class PlatformPropertyAll<T> extends PlatformProperty<T> {
  PlatformPropertyAll(T value)
      : super(
          android: value,
          ios: value,
          windows: value,
          macos: value,
          linux: value,
        );
}
