import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as FluentUI;

class PlatformDropDownMenuItem<T> {
  final Widget child;
  final T value;

  /// Doesn't work in `windows`
  final bool enabled;

  /// Doesn't work in `windows`
  final AlignmentGeometry alignment;
  void Function()? onTap;

  PlatformDropDownMenuItem({
    required this.child,
    required this.value,
    this.alignment = AlignmentDirectional.centerStart,
    this.enabled = true,
    this.onTap,
  });

  DropdownMenuItem<T> android() {
    return DropdownMenuItem<T>(
      enabled: enabled,
      value: value,
      alignment: alignment,
      onTap: onTap,
      child: child,
    );
  }

  MacosPopupMenuItem ios() {
    return macos();
  }

  DropdownMenuItem linux() {
    return android();
  }

  MacosPopupMenuItem<T> macos() {
    return MacosPopupMenuItem<T>(
      enabled: enabled,
      value: value,
      alignment: alignment,
      onTap: onTap,
      child: child,
    );
  }

  FluentUI.ComboBoxItem<T> windows() {
    return FluentUI.ComboBoxItem<T>(
      value: value,
      onTap: onTap,
      child: child,
    );
  }
}

class PlatformDropDownMenu<T> extends StatelessWidget
    with PlatformMixin<Widget> {
  final List<PlatformDropDownMenuItem<T>> items;
  final T? value;
  final Widget? hint;
  final Widget? disabledHint;
  final ValueChanged<T?>? onChanged;
  final VoidCallback? onTap;
  final DropdownButtonBuilder? selectedItemBuilder;
  final TextStyle? style;
  final double? itemHeight;
  final Color? focusColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final Color? dropdownColor;
  final double? menuMaxHeight;
  final AlignmentGeometry alignment;
  final int elevation;

  const PlatformDropDownMenu({
    required this.items,
    this.selectedItemBuilder,
    this.value,
    this.hint,
    this.disabledHint,
    required this.onChanged,
    this.onTap,
    this.style,
    this.itemHeight = kMinInteractiveDimension,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.menuMaxHeight,
    this.elevation = 8,
    this.alignment = AlignmentDirectional.centerStart,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    return DropdownButton<T>(
      items: items.map((item) => item.android()).toList(),
      value: value,
      hint: hint,
      onChanged: onChanged,
      onTap: onTap,
      selectedItemBuilder: selectedItemBuilder,
      style: style,
      itemHeight: itemHeight,
      focusColor: focusColor,
      focusNode: focusNode,
      autofocus: autofocus,
      dropdownColor: dropdownColor,
      menuMaxHeight: menuMaxHeight,
      alignment: alignment,
      elevation: elevation,
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
    return MacosPopupButton<T>(
      items: items.map((item) => item.macos()).toList(),
      value: value,
      hint: hint,
      disabledHint: disabledHint,
      onChanged: onChanged,
      onTap: onTap,
      selectedItemBuilder: selectedItemBuilder,
      style: style,
      itemHeight: itemHeight,
      focusNode: focusNode,
      autofocus: autofocus,
      popupColor: dropdownColor,
      menuMaxHeight: menuMaxHeight,
      alignment: alignment,
    );
  }

  @override
  Widget windows(BuildContext context) {
    return FluentUI.ComboBox<T>(
      items: items.map((item) => item.windows()).toList(),
      focusNode: focusNode,
      autofocus: autofocus,
      popupColor: dropdownColor,
      disabledPlaceholder: disabledHint,
      focusColor: focusColor,
      onChanged: onChanged,
      onTap: onTap,
      placeholder: hint,
      selectedItemBuilder: selectedItemBuilder,
      elevation: elevation,
      style: style,
      value: value,
    );
  }
}
