import 'package:flutter/material.dart';
import 'package:platform_ui/src/core/constants.dart';

abstract class PlatformPreset<T> {
  final ColorScheme colorScheme;
  final PlatformConstants constants;
  PlatformPreset(this.colorScheme) : constants = PlatformConstants(colorScheme);

  T fluent();
  T adwaita();
  T aqua();
  T material();
  T cupertino();

  T getByTargetPlatform(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return material();
      case TargetPlatform.iOS:
        return cupertino();
      case TargetPlatform.fuchsia:
        return material();
      case TargetPlatform.linux:
        return adwaita();
      case TargetPlatform.macOS:
        return aqua();
      case TargetPlatform.windows:
        return fluent();
    }
  }
}
