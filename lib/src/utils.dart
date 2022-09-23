import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class Utils {
  static ButtonState<T>? resolveMaterialPropertyAsAllButtonState<T>(
    Set<MaterialState> states, [
    MaterialStateProperty<T>? property,
  ]) {
    return property != null ? ButtonState.all(property.resolve(states)) : null;
  }
}
