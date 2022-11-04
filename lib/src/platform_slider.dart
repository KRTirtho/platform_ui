import 'package:flutter/cupertino.dart';
import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

class PlatformSlider extends StatelessWidget with PlatformMixin<Widget> {
  final double value;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;

  /// works only in windows, linux and android
  final String? label;
  final Color? activeColor;

  /// works only in windows, linux and android
  final Color? inactiveColor;
  final Color? thumbColor;
  final MouseCursor mouseCursor;
  final FocusNode? focusNode;
  final bool autofocus;

  const PlatformSlider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.mouseCursor = SystemMouseCursors.grabbing,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    return Slider(
      value: value,
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      min: min,
      max: max,
      divisions: divisions,
      label: label,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      thumbColor: thumbColor,
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }

  @override
  Widget ios(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Focus(
        autofocus: autofocus,
        focusNode: focusNode,
        child: MouseRegion(
          cursor: mouseCursor,
          child: CupertinoSlider(
            value: value,
            onChanged: onChanged,
            onChangeStart: onChangeStart,
            onChangeEnd: onChangeEnd,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: activeColor,
            thumbColor: thumbColor ?? CupertinoColors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget linux(BuildContext context) {
    return android(context);
  }

  @override
  Widget macos(BuildContext context) {
    return ios(context);
  }

  @override
  Widget windows(BuildContext context) {
    return FluentUI.Slider(
      value: value,
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      min: min,
      max: max,
      divisions: divisions,
      label: label,
      style: FluentUI.SliderThemeData(
        thumbColor:
            thumbColor != null ? FluentUI.ButtonState.all(thumbColor) : null,
        activeColor:
            activeColor != null ? FluentUI.ButtonState.all(activeColor) : null,
        inactiveColor: inactiveColor != null
            ? FluentUI.ButtonState.all(inactiveColor)
            : null,
        margin: const EdgeInsets.all(8),
      ),
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }
}
