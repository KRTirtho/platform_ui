import 'package:flutter/material.dart';

final _windowsLightScheme = ColorScheme(
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
  surfaceVariant: Colors.grey[100]!,
  onSurfaceVariant: Colors.black,
  inverseSurface: Colors.grey[900]!,
  onInverseSurface: Colors.white,
  tertiary: Colors.white,
  onTertiary: Colors.black,
  tertiaryContainer: Colors.grey[200]!,
  onTertiaryContainer: Colors.black,
  outline: Colors.grey[600],
  outlineVariant: Colors.grey[300]!,
  scrim: Colors.grey.withOpacity(0.5),
  shadow: Colors.black,
  surfaceTint: Colors.grey,
);

final _windowsDarkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.blue[200]!,
  onPrimary: Colors.black,
  primaryContainer: Colors.grey[800]!,
  onPrimaryContainer: Colors.white,
  inversePrimary: Colors.blue[800],
  background: Colors.grey[800]!,
  onBackground: Colors.white,
  error: Colors.red[200]!,
  onError: Colors.black,
  errorContainer: Colors.red[800],
  onErrorContainer: Colors.white,
  secondary: Colors.grey[900]!,
  onSecondary: Colors.white,
  secondaryContainer: Colors.grey[800]!,
  onSecondaryContainer: Colors.white,
  surface: Colors.grey[850]!,
  onSurface: Colors.white,
  surfaceVariant: Colors.grey[900]!,
  onSurfaceVariant: Colors.white,
  inverseSurface: Colors.grey[100]!,
  onInverseSurface: Colors.black,
  tertiary: Colors.grey[900]!,
  onTertiary: Colors.white,
  tertiaryContainer: Colors.grey[800]!,
  onTertiaryContainer: Colors.white,
  outline: Colors.grey[700],
  outlineVariant: Colors.grey[800]!,
  scrim: Colors.grey.withOpacity(0.5),
  shadow: Colors.black,
  surfaceTint: Colors.grey,
);

class PlatformThemeData {
  PlatformThemeData._();

  static ThemeData windows({Brightness brightness = Brightness.light}) {
    final colorScheme = brightness == Brightness.light
        ? _windowsLightScheme
        : _windowsDarkScheme;

    final defaultBorderSide =
        BorderSide(color: colorScheme.outlineVariant, width: .7);
    final extendedBorderSide =
        BorderSide(color: colorScheme.outline, width: .7);
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
        borderRadius: defaultBorderRadius,
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
                return Color.lerp(
                      colorScheme.primary,
                      colorScheme.surface,
                      0.15,
                    ) ??
                    colorScheme.primary;
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
        textStyle: const TextStyle(fontWeight: FontWeight.normal),
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

    final menuStyle = MenuStyle(
      backgroundColor: MaterialStatePropertyAll(colorScheme.surface),
      elevation: const MaterialStatePropertyAll(4),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: extendedBorderRadius,
          side: extendedBorderSide,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const MaterialStatePropertyAll(EdgeInsets.all(6)),
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
      menuStyle: menuStyle,
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
    final popupMenuThemeData = PopupMenuThemeData(
      position: PopupMenuPosition.under,
      elevation: 4,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: extendedBorderRadius,
        side: extendedBorderSide,
      ),
      labelTextStyle: MaterialStateProperty.all(
        TextStyle(
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurface,
        ),
      ),
    );
    final switchThemeData = SwitchThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashRadius: 0,
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return colorScheme.surfaceVariant;
          }
          if (states.contains(MaterialState.selected)) {
            return colorScheme.background;
          }
          return colorScheme.outline;
        },
      ),
    );
    final radioThemeData = RadioThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashRadius: 0,
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return colorScheme.surfaceVariant;
          }
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        },
      ),
    );
    final inputDecorationTheme = InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: colorScheme.surface,
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary, width: 4),
        borderRadius: defaultBorderRadius,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: defaultBorderSide,
        borderRadius: defaultBorderRadius,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: defaultBorderSide.copyWith(color: colorScheme.error),
        borderRadius: defaultBorderRadius,
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error, width: 4),
        borderRadius: defaultBorderRadius,
      ),
      hintStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      labelStyle: const TextStyle(color: Colors.transparent),
    );
    final tabBarTheme = TabBarTheme(
      splashFactory: NoSplash.splashFactory,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontWeight: FontWeight.normal),
      labelColor: colorScheme.onSurface,
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      dividerColor: Colors.transparent,
      indicator: UnderlineTabIndicator(
        borderRadius: defaultBorderRadius,
        insets: const EdgeInsets.symmetric(horizontal: 8),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
    );
    final navigationBarThemeData = NavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      height: 50,
      indicatorColor: Colors.transparent,
      indicatorShape: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary, width: 2.5),
      ),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: const MaterialStatePropertyAll(
        TextStyle(fontWeight: FontWeight.normal),
      ),
    );
    final navigationRailThemeData = NavigationRailThemeData(
      backgroundColor: colorScheme.surfaceVariant,
      elevation: 0,
      indicatorColor: Colors.transparent,
      indicatorShape: Border(
        left: BorderSide(color: colorScheme.primary, width: 2.5),
      ),
      selectedLabelTextStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface,
      ),
      unselectedLabelTextStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface,
      ),
      selectedIconTheme: IconThemeData(color: colorScheme.onSurface),
      unselectedIconTheme: IconThemeData(color: colorScheme.onSurface),
    );
    final chipThemeData = ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide(color: colorScheme.primary, width: 1.2),
      elevation: 0,
      pressElevation: 0,
      deleteIconColor: colorScheme.primary,
      checkmarkColor: colorScheme.primary,
      labelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface,
      ),
    );
    final scrollbarThemeData = ScrollbarThemeData(
      radius: const Radius.circular(8),
      thickness: MaterialStateProperty.resolveWith<double>(
        (states) {
          if (states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed) ||
              states.contains(MaterialState.dragged)) {
            return 6;
          }
          return 4;
        },
      ),
      thumbVisibility: const MaterialStatePropertyAll(true),
      thumbColor: MaterialStatePropertyAll(colorScheme.outline),
      mainAxisMargin: 10,
      trackVisibility: MaterialStateProperty.resolveWith<bool>(
        (states) =>
            states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.pressed) ||
            states.contains(MaterialState.dragged),
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed) ||
              states.contains(MaterialState.dragged)) {
            return colorScheme.surfaceVariant;
          }
          return colorScheme.surface;
        },
      ),
    );
    final sliderThemeData = SliderThemeData(
      trackHeight: 4,
      secondaryActiveTrackColor: colorScheme.secondary,
      thumbColor: colorScheme.primary,
      valueIndicatorShape: const RectangularSliderValueIndicatorShape(),
      valueIndicatorColor: colorScheme.surfaceVariant,
      valueIndicatorTextStyle: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.normal,
      ),
      showValueIndicator: ShowValueIndicator.always,
      overlayColor: Colors.transparent,
      trackShape: const RoundedRectSliderTrackShape(),
      inactiveTrackColor: colorScheme.outline,
      activeTrackColor: colorScheme.primary,
      thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 9,
        elevation: 0,
        pressedElevation: 0,
      ),
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      canvasColor: colorScheme.surfaceVariant,
      cardColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      applyElevationOverlayColor: false,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      iconTheme: IconThemeData(color: colorScheme.onSurface, size: 18),
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
      popupMenuTheme: popupMenuThemeData,
      menuTheme: MenuThemeData(style: menuStyle),
      menuButtonTheme: menuButtonThemeData,
      dropdownMenuTheme: dropdownMenuThemeData,
      switchTheme: switchThemeData,
      radioTheme: radioThemeData,
      inputDecorationTheme: inputDecorationTheme,
      tabBarTheme: tabBarTheme,
      navigationBarTheme: navigationBarThemeData,
      navigationRailTheme: navigationRailThemeData,
      chipTheme: chipThemeData,
      scrollbarTheme: scrollbarThemeData,
      sliderTheme: sliderThemeData,
    );
  }
}
