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

  static PlatformProperty all<T>(T value) {
    return PlatformProperty<T>(
      android: value,
      ios: value,
      windows: value,
      macos: value,
      linux: value,
    );
  }

  static PlatformProperty resolve<T>(
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
