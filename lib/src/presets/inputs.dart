import 'package:platform_ui/platform_ui.dart';
import 'package:platform_ui/src/core/platform_preset.dart';

class InputPresetCollection {
  final InputDecorationTheme input;
  final CheckboxThemeData checkbox;
  final RadioThemeData radio;
  final SliderThemeData slider;
  final SwitchThemeData toggleSwitch;

  InputPresetCollection({
    required this.input,
    required this.checkbox,
    required this.radio,
    required this.slider,
    required this.toggleSwitch,
  });
}

class InputsPreset extends PlatformPreset<InputPresetCollection> {
  InputsPreset(super.colorScheme);

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
    final inputDecorationTheme = InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: colorScheme.surface,
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary, width: 4),
        borderRadius: constants.fluent.defaultBorderRadius,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: constants.fluent.defaultBorderSide,
        borderRadius: constants.fluent.defaultBorderRadius,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: constants.fluent.defaultBorderSide
            .copyWith(color: colorScheme.error),
        borderRadius: constants.fluent.defaultBorderRadius,
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error, width: 4),
        borderRadius: constants.fluent.defaultBorderRadius,
      ),
      hintStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      labelStyle: const TextStyle(color: Colors.transparent),
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
    final checkboxTheme = CheckboxThemeData(
      splashRadius: 0,
      shape: RoundedRectangleBorder(
        borderRadius: constants.fluent.defaultBorderRadius,
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

    return InputPresetCollection(
      input: inputDecorationTheme,
      checkbox: checkboxTheme,
      radio: radioThemeData,
      slider: sliderThemeData,
      toggleSwitch: switchThemeData,
    );
  }

  @override
  material() {
    // TODO: implement material
    throw UnimplementedError();
  }
}
