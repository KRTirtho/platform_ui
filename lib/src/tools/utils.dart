import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class Utils {
  static ButtonState<T>? resolveMaterialPropertyAsAllButtonState<T>(
    Set<MaterialState> states, [
    MaterialStateProperty<T>? property,
  ]) {
    return property != null ? ButtonState.all(property.resolve(states)) : null;
  }

  static const allMaterialStates = {
    MaterialState.focused,
    MaterialState.disabled,
    MaterialState.error,
    MaterialState.hovered,
    MaterialState.pressed,
    MaterialState.selected,
  };

  static const allButtonStates = {
    ButtonStates.focused,
    ButtonStates.disabled,
    ButtonStates.hovering,
    ButtonStates.none,
    ButtonStates.pressing,
  };

  static T brightnessSpecific<T>(
    BuildContext context, {
    T? light,
    T? dark,
  }) {
    assert(light != null || dark != null);

    return Theme.of(context).brightness == Brightness.light
        ? light ?? dark!
        : dark ?? light!;
  }
}
