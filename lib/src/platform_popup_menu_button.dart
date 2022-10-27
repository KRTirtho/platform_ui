import 'package:fluent_ui/fluent_ui.dart' hide ThemeData, Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:platform_ui/src/specific/macos_popup_menu_button.dart';
import 'package:platform_ui/src/utils.dart';
import 'package:collection/collection.dart';

class PlatformPopupMenuItem<T> {
  final Widget child;
  final T value;
  void Function()? onTap;

  PlatformPopupMenuItem({
    required this.child,
    required this.value,
    this.onTap,
  });

  PopupMenuItem<T> android(
    BuildContext context,
  ) {
    return PopupMenuItem<T>(
      onTap: onTap,
      value: value,
      child: child,
    );
  }

  PopupMenuItem<T> ios(BuildContext context, {void Function(T)? onSelected}) {
    return PopupMenuItem<T>(
      value: value,
      onTap: onTap,
      height: 45,
      textStyle: CupertinoTheme.of(context).textTheme.textStyle,
      child: child,
    );
  }

  MacosPopupMenuItem<T> macos(BuildContext context,
      {void Function(T)? onSelected}) {
    return MacosPopupMenuItem<T>(
      value: value,
      onTap: onTap,
      height: 30,
      textStyle: CupertinoTheme.of(context).textTheme.textStyle,
      child: child,
    );
  }

  PopupMenuItem<T> linux(
    BuildContext context,
  ) {
    return android(context);
  }

  MenuFlyoutItem windows(BuildContext context, {void Function(T)? onSelected}) {
    return MenuFlyoutItem(
      onPressed: () {
        onSelected?.call(value);
        onTap?.call();
      },
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
    if (closeAfterClick) {
      Navigator.of(context).pop();
    }
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
      data: (Theme.of(context) ?? ThemeData()).copyWith(
        splashFactory: NoSplash.splashFactory,
        dividerColor: CupertinoColors.separator,
      ),
      child: Material(
        child: Localizations(
          delegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          locale: const Locale('en', 'US'),
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
            color: Utils.brightnessSpecific(
              context,
              light: color ?? CupertinoColors.secondarySystemBackground,
              dark: color ?? CupertinoColors.darkBackgroundGray,
            ),
            constraints: constraints,
            child: child,
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
    return Theme(
      data: (Theme.of(context) ?? ThemeData()).copyWith(
        splashFactory: NoSplash.splashFactory,
        dividerColor: CupertinoColors.separator,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Localizations(
          delegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          locale: const Locale('en', 'US'),
          child: MacosPopupMenuButton<T>(
            itemBuilder: (context) {
              return items.map((e) => e.macos(context)).toList();
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
            color: color,
            constraints: constraints,
            child: child,
          ),
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
