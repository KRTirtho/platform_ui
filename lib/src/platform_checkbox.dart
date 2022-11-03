import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:platform_ui/src/specific/macos_checkbox.dart';

class PlatformCheckbox extends StatelessWidget with PlatformMixin<Widget> {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final MouseCursor? mouseCursor;
  final FocusNode? focusNode;
  final bool autofocus;

  const PlatformCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    return Checkbox(
      value: value,
      tristate: true,
      onChanged: onChanged,
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }

  @override
  Widget ios(BuildContext context) {
    return macos(context);
  }

  @override
  Widget linux(BuildContext context) {
    return android(context);
  }

  @override
  Widget macos(BuildContext context) {
    return Focus(
      autofocus: autofocus,
      focusNode: focusNode,
      child: MouseRegion(
        cursor: mouseCursor ?? MouseCursor.defer,
        child: MacosCheckbox(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget windows(BuildContext context) {
    return MouseRegion(
      cursor: mouseCursor ?? MouseCursor.defer,
      child: FluentUI.Checkbox(
        checked: value,
        onChanged: onChanged,
        focusNode: focusNode,
        autofocus: autofocus,
      ),
    );
  }
}
