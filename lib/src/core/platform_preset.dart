import 'package:flutter/material.dart';
import 'package:platform_ui/src/core/constants.dart';

abstract class PlatformPreset<T> {
  final ColorScheme colorScheme;
  final PlatformConstants constants;
  PlatformPreset(this.colorScheme)
      : defaultBorderSide = BorderSide(
          color: colorScheme.outline,
          width: .7,
        ),
        borderSideVariant = BorderSide(
          color: colorScheme.outlineVariant,
          width: .7,
        ),
        constants = PlatformConstants(colorScheme);

  final BorderSide defaultBorderSide;
  final BorderSide borderSideVariant;

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
