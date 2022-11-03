import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';

class PlatformSwitch extends StatelessWidget with PlatformMixin<Widget> {
  final bool value;

  final ValueChanged<bool>? onChanged;

  final Color? activeThumbColor;

  final Color? activeTrackColor;

  final Color? inactiveThumbColor;

  final Color? inactiveTrackColor;

  final MouseCursor mouseCursor;

  final FocusNode? focusNode;

  final bool autofocus;

  const PlatformSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeThumbColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.mouseCursor = SystemMouseCursors.click,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    return Switch.adaptive(
      value: value,
      onChanged: onChanged,
      activeColor: activeThumbColor,
      activeTrackColor: activeTrackColor,
      inactiveThumbColor: inactiveThumbColor,
      inactiveTrackColor: inactiveTrackColor,
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }

  @override
  Widget ios(BuildContext context) {
    return Focus(
      autofocus: autofocus,
      focusNode: focusNode,
      child: MouseRegion(
        cursor: mouseCursor,
        child: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeColor: activeTrackColor,
          thumbColor: value ? activeThumbColor : inactiveThumbColor,
          trackColor: inactiveTrackColor,
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
    return Focus(
      autofocus: autofocus,
      focusNode: focusNode,
      child: MouseRegion(
        cursor: mouseCursor,
        child: MacosSwitch(
          value: value,
          onChanged: onChanged,
          activeColor: activeThumbColor,
          trackColor: inactiveTrackColor,
        ),
      ),
    );
  }

  @override
  Widget windows(BuildContext context) {
    final toggleTheme = ToggleSwitchTheme.of(context);

    return MouseRegion(
      cursor: mouseCursor,
      child: ToggleSwitch(
        checked: value,
        onChanged: onChanged,
        autofocus: autofocus,
        focusNode: focusNode,
        style: ToggleSwitchTheme.of(context).merge(ToggleSwitchThemeData(
          checkedDecoration: activeTrackColor != null
              ? ButtonState.resolveWith((states) {
                  return (toggleTheme.checkedDecoration?.resolve(states)
                          as BoxDecoration)
                      .copyWith(color: activeTrackColor);
                })
              : null,
          checkedThumbDecoration: activeThumbColor != null
              ? ButtonState.resolveWith((states) {
                  return (toggleTheme.checkedThumbDecoration?.resolve(states)
                          as BoxDecoration)
                      .copyWith(color: activeThumbColor);
                })
              : null,
          uncheckedDecoration: inactiveTrackColor != null
              ? ButtonState.resolveWith((states) {
                  return (toggleTheme.uncheckedDecoration?.resolve(states)
                          as BoxDecoration)
                      .copyWith(color: inactiveTrackColor);
                })
              : null,
          uncheckedThumbDecoration: inactiveThumbColor != null
              ? ButtonState.resolveWith((states) {
                  return (toggleTheme.uncheckedThumbDecoration?.resolve(states)
                          as BoxDecoration)
                      .copyWith(color: inactiveThumbColor);
                })
              : null,
        )),
      ),
    );
  }
}
