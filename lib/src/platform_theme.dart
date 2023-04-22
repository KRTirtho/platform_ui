import 'package:flutter/material.dart';

class PlatformThemeData {
  PlatformThemeData._();

  static ThemeData windows() {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Colors.blue[800]!,
      onPrimary: Colors.white,
      primaryContainer: Colors.white,
      onPrimaryContainer: Colors.black,
      inversePrimary: Colors.blue[200],
      background: Colors.grey[100]!,
      onBackground: Colors.black,
      error: Colors.red[800]!,
      onError: Colors.white,
      errorContainer: Colors.red[200],
      onErrorContainer: Colors.white,
      secondary: Colors.white,
      onSecondary: Colors.black,
      secondaryContainer: Colors.grey[200]!,
      onSecondaryContainer: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      surfaceVariant: Colors.grey[200]!,
      onSurfaceVariant: Colors.black,
      inverseSurface: Colors.grey[900]!,
      onInverseSurface: Colors.white,
      tertiary: Colors.white,
      onTertiary: Colors.black,
      tertiaryContainer: Colors.grey[200]!,
      onTertiaryContainer: Colors.black,
      outline: Colors.black,
      outlineVariant: Colors.grey[800]!,
      scrim: Colors.grey.withOpacity(0.5),
      shadow: Colors.black,
      surfaceTint: Colors.blue[900],
    );

    final filledButtonStyle = ElevatedButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      textStyle: const TextStyle(fontWeight: FontWeight.normal),
      padding: const EdgeInsets.all(14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ).copyWith(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return colorScheme.surfaceVariant;
          }
          if (states.contains(MaterialState.pressed)) {
            return colorScheme.surfaceTint;
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
        borderRadius: BorderRadius.circular(4),
      ),
    ).copyWith(
      elevation: const MaterialStatePropertyAll(1),
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
      iconSize: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );

    final textButtonTheme = TextButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      textStyle: const TextStyle(fontWeight: FontWeight.normal),
      padding: const EdgeInsets.all(14),
      foregroundColor: colorScheme.onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
      filledButtonTheme: FilledButtonThemeData(style: filledButtonStyle),
      iconButtonTheme: IconButtonThemeData(style: iconButtonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: elevatedButtonStyle.copyWith(
          side: const MaterialStatePropertyAll(BorderSide.none),
        ),
      ),
      textButtonTheme: TextButtonThemeData(style: textButtonTheme),
    );
  }
}
