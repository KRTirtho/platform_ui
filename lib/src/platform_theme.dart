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
      outline: Colors.grey,
      outlineVariant: Colors.grey[300]!,
      scrim: Colors.grey.withOpacity(0.5),
      shadow: Colors.black,
      surfaceTint: Colors.blue[900],
    );

    final defaultBorderSide =
        BorderSide(color: colorScheme.outlineVariant, width: .7);
    const defaultBorderRadius = BorderRadius.all(Radius.circular(4));
    const extendedBorderRadius = BorderRadius.all(Radius.circular(8));

    final filledButtonStyle = ElevatedButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      textStyle: const TextStyle(fontWeight: FontWeight.normal),
      padding: const EdgeInsets.all(14),
      shape: const RoundedRectangleBorder(
        borderRadius: defaultBorderRadius,
        side: BorderSide(color: Colors.black, width: .2),
      ),
    ).copyWith(
      elevation: const MaterialStatePropertyAll(0),
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
        borderRadius: defaultBorderRadius,
        side: defaultBorderSide,
      ),
    ).copyWith(
      elevation: const MaterialStatePropertyAll(0),
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
      shape: const RoundedRectangleBorder(
        borderRadius: defaultBorderRadius,
      ),
    );

    final textButtonTheme = TextButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      textStyle: const TextStyle(fontWeight: FontWeight.normal),
      padding: const EdgeInsets.all(14),
      foregroundColor: colorScheme.onSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: defaultBorderRadius,
      ),
    );

    final checkboxTheme = CheckboxThemeData(
      splashRadius: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: defaultBorderRadius,
      ),
      side: BorderSide(color: colorScheme.outline),
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          for (final state in states) {
            switch (state) {
              case MaterialState.disabled:
                return colorScheme.surfaceVariant;
              case MaterialState.pressed:
              case MaterialState.hovered:
                return colorScheme.surfaceTint;
              default:
                return colorScheme.primary;
            }
          }

          return colorScheme.primary;
        },
      ),
    );
    final baseButtonTheme = ButtonThemeData(
      colorScheme: colorScheme,
      shape: const RoundedRectangleBorder(
        borderRadius: defaultBorderRadius,
      ),
    );

    final menuButtonThemeData = MenuButtonThemeData(
      style: MenuItemButton.styleFrom(
        minimumSize: const Size.fromHeight(32),
        shape: const RoundedRectangleBorder(
          borderRadius: defaultBorderRadius,
        ),
      ).copyWith(
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (states) {
            if (states.contains(MaterialState.hovered)) {
              return RoundedRectangleBorder(
                borderRadius: defaultBorderRadius,
                side: defaultBorderSide,
              );
            }
            return const RoundedRectangleBorder(
              borderRadius: defaultBorderRadius,
            );
          },
        ),
      ),
    );
    final dropdownInputBorder = OutlineInputBorder(
      borderSide: defaultBorderSide,
      borderRadius: defaultBorderRadius,
    );
    final dropdownMenuThemeData = DropdownMenuThemeData(
      textStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      menuStyle: MenuStyle(
        backgroundColor: MaterialStatePropertyAll(colorScheme.surfaceVariant),
        elevation: const MaterialStatePropertyAll(4),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: extendedBorderRadius,
            side: BorderSide(color: colorScheme.outline, width: .7),
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const MaterialStatePropertyAll(EdgeInsets.all(6)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        constraints: const BoxConstraints(maxHeight: 32),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        filled: true,
        fillColor: colorScheme.surface,
        border: dropdownInputBorder,
        enabledBorder: dropdownInputBorder,
        focusedBorder: dropdownInputBorder,
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
          side: MaterialStatePropertyAll(
            defaultBorderSide,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(style: textButtonTheme),
      buttonTheme: baseButtonTheme,
      checkboxTheme: checkboxTheme,
      popupMenuTheme: const PopupMenuThemeData(
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(
          borderRadius: extendedBorderRadius,
        ),
      ),
      menuTheme: const MenuThemeData(
        style: MenuStyle(
          alignment: Alignment.topLeft,
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: extendedBorderRadius,
            ),
          ),
        ),
      ),
      menuButtonTheme: menuButtonThemeData,
      dropdownMenuTheme: dropdownMenuThemeData,
    );
  }
}
