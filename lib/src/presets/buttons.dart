import 'package:flutter/material.dart';
import 'package:platform_ui/src/core/platform_preset.dart';

class ButtonsPresetCollection {
  final ButtonStyle elevated;
  final ButtonStyle outlined;
  final ButtonStyle text;
  final ButtonStyle filled;
  final ButtonStyle icon;
  final ButtonThemeData base;

  ButtonsPresetCollection({
    required this.elevated,
    required this.outlined,
    required this.text,
    required this.filled,
    required this.icon,
    required this.base,
  });
}

class ButtonsPreset extends PlatformPreset<ButtonsPresetCollection> {
  ButtonsPreset(super.colorScheme);

  @override
  adwaita() {
    // TODO: implement adwaita
    throw UnimplementedError();
  }

  @override
  aqua() {
    // TODO: implement aqua
    throw UnimplementedError();
  }

  @override
  cupertino() {
    // TODO: implement cupertino
    throw UnimplementedError();
  }

  @override
  fluent() {
    final filledButtonStyle = ElevatedButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      textStyle: const TextStyle(fontWeight: FontWeight.normal),
      padding: const EdgeInsets.all(14),
      shape: RoundedRectangleBorder(
        borderRadius: constants.fluent.defaultBorderRadius,
        side: const BorderSide(color: Colors.black, width: .2),
      ),
    ).copyWith(
      elevation: const MaterialStatePropertyAll(0),
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.transparent;
          }
          return colorScheme.surfaceTint.withOpacity(0.2);
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return colorScheme.surfaceVariant;
          }
          return colorScheme.primary;
        },
      ),
    );

    final elevatedButtonStyle = ElevatedButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      textStyle: const TextStyle(fontWeight: FontWeight.normal),
      padding: const EdgeInsets.all(14),
      foregroundColor: colorScheme.onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: constants.fluent.defaultBorderRadius,
        side: defaultBorderSide,
      ),
    ).copyWith(
      elevation: const MaterialStatePropertyAll(0),
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.transparent;
          }
          return colorScheme.surfaceTint.withOpacity(0.1);
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled) ||
              states.contains(MaterialState.pressed)) {
            return colorScheme.background;
          }
          return colorScheme.primaryContainer;
        },
      ),
    );

    final iconButtonStyle = IconButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      elevation: 0,
      minimumSize: const Size(30, 20),
      maximumSize: const Size(40, 30),
      shape: RoundedRectangleBorder(
        borderRadius: constants.fluent.defaultBorderRadius,
      ),
    );

    final textButtonTheme = TextButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      textStyle: const TextStyle(fontWeight: FontWeight.normal),
      padding: const EdgeInsets.all(14),
      foregroundColor: colorScheme.onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: constants.fluent.defaultBorderRadius,
      ),
    );

    final baseButtonStyle = ButtonThemeData(
      colorScheme: colorScheme,
      shape: RoundedRectangleBorder(
        borderRadius: constants.fluent.defaultBorderRadius,
      ),
    );

    return ButtonsPresetCollection(
      elevated: elevatedButtonStyle,
      outlined: elevatedButtonStyle.copyWith(
        side: MaterialStatePropertyAll(
          defaultBorderSide,
        ),
      ),
      text: textButtonTheme,
      filled: filledButtonStyle,
      icon: iconButtonStyle,
      base: baseButtonStyle,
    );
  }

  @override
  material() {
    // TODO: implement material
    throw UnimplementedError();
  }
}
