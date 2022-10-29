import 'package:flutter/cupertino.dart';

class PlatformProperty<T> {
  final T android;
  final T ios;
  final T macos;
  final T linux;
  final T windows;

  const PlatformProperty({
    required this.android,
    required this.ios,
    required this.macos,
    required this.linux,
    required this.windows,
  });

  T resolve(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.linux:
        return linux;
      case TargetPlatform.windows:
        return windows;
      default:
        return android;
    }
  }

  factory PlatformProperty.all(T value) {
    return PlatformProperty(
      android: value,
      ios: value,
      macos: value,
      linux: value,
      windows: value,
    );
  }

  factory PlatformProperty.byPlatformGroup({
    required T mobile,
    required T desktop,
  }) {
    return PlatformProperty(
      android: mobile,
      ios: mobile,
      macos: desktop,
      linux: desktop,
      windows: desktop,
    );
  }

  factory PlatformProperty.multiPlatformGroup(
      Map<T, Set<TargetPlatform>> groups) {
    assert(groups.isNotEmpty);

    final platforms = TargetPlatform.values..remove(TargetPlatform.fuchsia);
    assert(groups.values.expand<TargetPlatform>((element) => element).length ==
        platforms.length);

    return PlatformProperty(
      android: groups.keys
          .firstWhere((key) => groups[key]!.contains(TargetPlatform.android)),
      ios: groups.keys
          .firstWhere((key) => groups[key]!.contains(TargetPlatform.iOS)),
      macos: groups.keys
          .firstWhere((key) => groups[key]!.contains(TargetPlatform.macOS)),
      linux: groups.keys
          .firstWhere((key) => groups[key]!.contains(TargetPlatform.linux)),
      windows: groups.keys
          .firstWhere((key) => groups[key]!.contains(TargetPlatform.windows)),
    );
  }
}
