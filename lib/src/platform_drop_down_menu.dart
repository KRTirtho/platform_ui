import 'package:flutter/cupertino.dart';
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
    this.alignment = Alignment.center,
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

  Widget ios() {
    return child;
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

class PlatformDropDownMenu<T> extends StatefulWidget {
  final List<PlatformDropDownMenuItem<T>> items;
  final T? value;
  final Widget? hint;
  final Widget? disabledHint;
  final ValueChanged<T?>? onChanged;
  final VoidCallback? onTap;
  final DropdownButtonBuilder? selectedItemBuilder;
  final TextStyle? style;
  final double itemHeight;
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
    this.itemHeight = 35,
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
  State<PlatformDropDownMenu<T>> createState() =>
      _PlatformDropDownMenuState<T>();
}

class _PlatformDropDownMenuState<T> extends State<PlatformDropDownMenu<T>>
    with PlatformMixin<Widget> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    index = widget.value != null
        ? widget.items
            .map((item) => item.value)
            .toList()
            .indexOf(widget.value as T)
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    return DropdownButton<T>(
      items: widget.items.map((item) => item.android()).toList(),
      value: widget.value,
      hint: widget.hint,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      selectedItemBuilder: widget.selectedItemBuilder,
      style: widget.style,
      itemHeight: widget.itemHeight,
      focusColor: widget.focusColor,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      dropdownColor: widget.dropdownColor,
      menuMaxHeight: widget.menuMaxHeight,
      alignment: widget.alignment,
      elevation: widget.elevation,
    );
  }

  @override
  Widget ios(BuildContext context) {
    final height = widget.itemHeight * widget.items.length * 2;

    return CupertinoButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.items[index].ios(),
          const SizedBox(width: 8),
          const Icon(CupertinoIcons.chevron_down_circle),
        ],
      ),
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            var screenHeight = MediaQuery.of(context).size.height / 2;
            return SizedBox(
              height: height > screenHeight ? screenHeight : height,
              child: CupertinoPicker(
                itemExtent: widget.itemHeight,
                backgroundColor:
                    CupertinoTheme.of(context).scaffoldBackgroundColor,
                onSelectedItemChanged: (index) {
                  widget.onChanged!(widget.items[index].value);
                  setState(() {
                    this.index = index;
                  });
                },
                children: widget.items.map((item) => item.ios()).toList(),
              ),
            );
          },
          barrierDismissible: true,
        );
      },
    );
  }

  @override
  Widget linux(BuildContext context) {
    return android(context);
  }

  @override
  Widget macos(BuildContext context) {
    return MacosPopupButton<T>(
      items: widget.items.map((item) => item.macos()).toList(),
      value: widget.value,
      hint: widget.hint,
      disabledHint: widget.disabledHint,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      selectedItemBuilder: widget.selectedItemBuilder,
      style: widget.style,
      itemHeight: widget.itemHeight,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      popupColor: widget.dropdownColor,
      menuMaxHeight: widget.menuMaxHeight,
      alignment: widget.alignment,
    );
  }

  @override
  Widget windows(BuildContext context) {
    return FluentUI.ComboBox<T>(
      items: widget.items.map((item) => item.windows()).toList(),
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      popupColor: widget.dropdownColor,
      disabledPlaceholder: widget.disabledHint,
      focusColor: widget.focusColor,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      placeholder: widget.hint,
      selectedItemBuilder: widget.selectedItemBuilder,
      elevation: widget.elevation,
      style: widget.style,
      value: widget.value,
    );
  }
}
