import 'package:fluent_ui/fluent_ui.dart' hide ThemeData, Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart' hide MacosPulldownButton;
import 'package:platform_ui/platform_ui.dart';
import 'package:platform_ui/src/specific/macos_popup_menu_button.dart';
import 'package:collection/collection.dart';

class PlatformPopupMenuItem<T> {
  final Widget child;
  final T value;
  final bool enabled;
  void Function()? onTap;

  PlatformPopupMenuItem({
    required this.child,
    required this.value,
    this.onTap,
    this.enabled = true,
  });

  PopupMenuItem<T> android(
    BuildContext context,
  ) {
    return PopupMenuItem<T>(
      onTap: onTap,
      value: value,
      enabled: enabled,
      child: child,
    );
  }

  PopupMenuItem<T> ios(BuildContext context, {void Function(T)? onSelected}) {
    return PopupMenuItem<T>(
      value: value,
      onTap: onTap,
      enabled: enabled,
      height: 45,
      textStyle: PlatformTheme.of(context).textTheme?.body,
      child: child,
    );
  }

  MacosPulldownMenuItem macos(BuildContext context,
      {void Function(T)? onSelected}) {
    return MacosPulldownMenuItem(
      enabled: enabled,
      onTap: () {
        onSelected?.call(value);
        onTap?.call();
      },
      title: child,
    );
  }

  PopupMenuItem<T> linux(
    BuildContext context,
  ) {
    return android(context);
  }

  MenuFlyoutItem windows(BuildContext context, {void Function(T)? onSelected}) {
    return MenuFlyoutItem(
      onPressed: enabled
          ? () {
              onSelected?.call(value);
              onTap?.call();
            }
          : null,
      text: child,
    );
  }
}

class PlatformPopupMenuButton<T> extends StatelessWidget
    with PlatformMixin<Widget> {
  final List<PlatformPopupMenuItem<T>> items;
  final T? initialValue;
  final PopupMenuItemSelected<T>? onSelected;
  final PopupMenuCanceled? onCanceled;
  final String? tooltip;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Offset offset;
  final bool enabled;
  final ShapeBorder? shape;
  final BoxConstraints? constraints;
  final Color? color;
  final bool closeAfterClick;

  const PlatformPopupMenuButton({
    Key? key,
    required this.items,
    required this.child,
    this.initialValue,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.padding = const EdgeInsets.all(8),
    this.offset = Offset.zero,
    this.enabled = true,
    this.color,
    this.shape,
    this.constraints,
    this.closeAfterClick = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  void _bubbledOnSelected(BuildContext context, T value) {
    onSelected?.call(value);
    if (closeAfterClick) {}
  }

  @override
  Widget android(BuildContext context) {
    return PopupMenuButton<T>(
      itemBuilder: (context) {
        return items.map((e) => e.android(context)).toList();
      },
      initialValue: initialValue,
      onSelected: (v) {
        _bubbledOnSelected(context, v);
      },
      onCanceled: onCanceled,
      tooltip: tooltip,
      padding: padding,
      offset: offset,
      enabled: enabled,
      shape: shape,
      color: color,
      constraints: constraints,
      child: child,
    );
  }

  @override
  Widget ios(BuildContext context) {
    return Theme(
      data: (Theme.of(context)).copyWith(
        splashFactory: NoSplash.splashFactory,
        dividerColor: CupertinoColors.separator,
        hoverColor: Colors.transparent,
      ),
      child: Material(
        textStyle: PlatformTheme.of(context).textTheme!.body!,
        child: PopupMenuButton<T>(
          itemBuilder: (context) {
            return items.expandIndexed<PopupMenuEntry<T>>((i, e) {
              return [
                e.ios(context),
                if (i != items.length - 1) const PopupMenuDivider(height: .5),
              ];
            }).toList();
          },
          initialValue: initialValue,
          onSelected: onSelected,
          elevation: 0.5,
          onCanceled: onCanceled,
          tooltip: tooltip,
          padding: padding,
          position: PopupMenuPosition.under,
          offset: offset,
          enabled: enabled,
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
          color: color ?? CupertinoTheme.of(context).barBackgroundColor,
          constraints: constraints,
          child: child,
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
    return MacosPulldownButtonTheme(
      data: MacosTheme.of(context).pulldownButtonTheme.copyWith(
            pulldownColor: color,
          ),
      child: MacosTooltip(
        message: tooltip ?? '',
        child: MacosPulldownButton(
          items: enabled
              ? items
                  .map((e) => e.macos(context, onSelected: onSelected))
                  .toList()
              : null,
          constraints: constraints,
          onCancelled: onCanceled,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget windows(BuildContext context) {
    return DropDownButton(
      items:
          items.map((e) => e.windows(context, onSelected: onSelected)).toList(),
      buttonBuilder: (context, onOpen) {
        return GestureDetector(
          onTap: onOpen,
          child: child,
        );
      },
      menuColor: color,
      disabled: !enabled,
      onClose: onCanceled,
      verticalOffset: offset.dy,
      menuShape: shape,
      closeAfterClick: closeAfterClick,
    );
  }
}
