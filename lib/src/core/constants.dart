import 'package:flutter/material.dart';

class Constants {
  final BorderRadius defaultBorderRadius;
  final BorderRadius extendedBorderRadius;
  final double defaultBorderSideWidth;
  final BorderSide defaultBorderSide;
  final BorderSide borderSideVariant;

  Constants._({
    required this.defaultBorderRadius,
    required this.extendedBorderRadius,
    required this.defaultBorderSideWidth,
    required this.defaultBorderSide,
    required this.borderSideVariant,
  });
}

class PlatformConstants {
  final ColorScheme colorScheme;

  final Constants material;
  final Constants cupertino;
  final Constants adwaita;
  final Constants aqua;
  final Constants fluent;

  PlatformConstants(this.colorScheme)
      : fluent = Constants._(
          defaultBorderRadius: const BorderRadius.all(Radius.circular(4)),
          extendedBorderRadius: const BorderRadius.all(Radius.circular(8)),
          defaultBorderSideWidth: .7,
          defaultBorderSide: BorderSide(
            color: colorScheme.outline,
            width: .7,
          ),
          borderSideVariant: BorderSide(
            color: colorScheme.outlineVariant,
            width: .7,
          ),
        ),
        adwaita = Constants._(
          defaultBorderRadius: const BorderRadius.all(Radius.circular(4)),
          extendedBorderRadius: const BorderRadius.all(Radius.circular(8)),
          defaultBorderSideWidth: .7,
          defaultBorderSide: BorderSide(
            color: colorScheme.outline,
            width: .7,
          ),
          borderSideVariant: BorderSide(
            color: colorScheme.outlineVariant,
            width: .7,
          ),
        ),
        aqua = Constants._(
          defaultBorderRadius: const BorderRadius.all(Radius.circular(4)),
          extendedBorderRadius: const BorderRadius.all(Radius.circular(8)),
          defaultBorderSideWidth: .7,
          defaultBorderSide: BorderSide(
            color: colorScheme.outline,
            width: .7,
          ),
          borderSideVariant: BorderSide(
            color: colorScheme.outlineVariant,
            width: .7,
          ),
        ),
        material = Constants._(
          defaultBorderRadius: const BorderRadius.all(Radius.circular(4)),
          extendedBorderRadius: const BorderRadius.all(Radius.circular(8)),
          defaultBorderSideWidth: .7,
          defaultBorderSide: BorderSide(
            color: colorScheme.outline,
            width: .7,
          ),
          borderSideVariant: BorderSide(
            color: colorScheme.outlineVariant,
            width: .7,
          ),
        ),
        cupertino = Constants._(
          defaultBorderRadius: const BorderRadius.all(Radius.circular(4)),
          extendedBorderRadius: const BorderRadius.all(Radius.circular(8)),
          defaultBorderSideWidth: .7,
          defaultBorderSide: BorderSide(
            color: colorScheme.outline,
            width: .7,
          ),
          borderSideVariant: BorderSide(
            color: colorScheme.outlineVariant,
            width: .7,
          ),
        );

  Constants getByTargetPlatform(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return material;
      case TargetPlatform.iOS:
        return cupertino;
      case TargetPlatform.fuchsia:
        return material;
      case TargetPlatform.linux:
        return adwaita;
      case TargetPlatform.macOS:
        return aqua;
      case TargetPlatform.windows:
        return fluent;
    }
  }
}
