import 'package:flutter/material.dart';
import 'package:platform_ui/src/presets/buttons.dart';
import 'package:platform_ui/src/presets/inputs.dart';
import 'package:platform_ui/src/presets/menus.dart';
import 'package:platform_ui/src/presets/miscellaneous.dart';
import 'package:platform_ui/src/presets/navigation.dart';
import 'package:platform_ui/src/presets/tabs.dart';

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
  outline: Colors.grey[300]!,
  outlineVariant: Colors.grey[600],
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
  outline: Colors.grey[800]!,
  outlineVariant: Colors.grey[700],
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

    final buttons = ButtonsPreset(colorScheme).fluent();
    final menus = MenusPreset(colorScheme).fluent();
    final inputs = InputsPreset(colorScheme).fluent();
    final navigation = NavigationPreset(colorScheme).fluent();
    final tabs = TabsPreset(colorScheme).fluent();
    final miscellaneous = MiscellaneousPreset(colorScheme).fluent();

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
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttons.elevated),
      filledButtonTheme: FilledButtonThemeData(style: buttons.filled),
      iconButtonTheme: IconButtonThemeData(style: buttons.icon),
      outlinedButtonTheme: OutlinedButtonThemeData(style: buttons.outlined),
      textButtonTheme: TextButtonThemeData(style: buttons.text),
      buttonTheme: buttons.base,
      checkboxTheme: inputs.checkbox,
      popupMenuTheme: menus.popup,
      menuTheme: MenuThemeData(style: menus.menu),
      menuButtonTheme: menus.menuButton,
      dropdownMenuTheme: menus.dropdown,
      switchTheme: inputs.toggleSwitch,
      radioTheme: inputs.radio,
      inputDecorationTheme: inputs.input,
      tabBarTheme: tabs,
      navigationBarTheme: navigation.navigationBar,
      navigationRailTheme: navigation.navigationRail,
      sliderTheme: inputs.slider,
      chipTheme: miscellaneous.chip,
      scrollbarTheme: miscellaneous.scrollbar,
      tooltipTheme: miscellaneous.tooltip,
    );
  }
}
