import 'package:flutter/cupertino.dart' as Cupertino;
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:platform_ui/src/specific/cupertino_list_tile.dart';
import 'package:fluent_ui/fluent_ui.dart' as FluentUI;

class PlatformListTile extends StatelessWidget with PlatformMixin<Widget> {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final bool isThreeLine;
  final bool? dense;
  final ShapeBorder? shape;
  final Color? selectedColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final MouseCursor? mouseCursor;
  final bool selected;
  final Color? focusColor;
  final Color? hoverColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final Color? tileColor;
  final Color? selectedTileColor;

  const PlatformListTile({
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.shape,
    this.selectedColor,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.mouseCursor,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      isThreeLine: isThreeLine,
      dense: dense,
      shape: shape,
      selectedColor: selectedColor,
      contentPadding: contentPadding,
      enabled: enabled,
      onTap: onTap,
      onLongPress: onLongPress,
      mouseCursor: mouseCursor,
      selected: selected,
      focusColor: focusColor,
      hoverColor: hoverColor,
      focusNode: focusNode,
      autofocus: autofocus,
      tileColor: tileColor,
      selectedTileColor: selectedTileColor,
    );
  }

  @override
  Widget ios(BuildContext context) {
    return CupertinoListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      isThreeLine: isThreeLine,
      dense: dense,
      contentPadding: contentPadding,
      enabled: enabled,
      onTap: onTap,
      onLongPress: onLongPress,
      mouseCursor: mouseCursor,
      selected: selected,
      focusColor: focusColor,
      hoverColor: hoverColor,
      focusNode: focusNode,
      autofocus: autofocus,
      pressColor: selectedTileColor ?? Cupertino.CupertinoColors.systemFill,
    );
  }

  @override
  Widget linux(BuildContext context) {
    return android(context);
  }

  @override
  Widget macos(BuildContext context) {
    return IconTheme(
      data: PlatformTheme.of(context).iconTheme ?? const IconThemeData(),
      child: CupertinoListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        isThreeLine: isThreeLine,
        dense: dense ?? true,
        contentPadding: contentPadding,
        enabled: enabled,
        onTap: onTap,
        onLongPress: onLongPress,
        mouseCursor: mouseCursor,
        selected: selected,
        focusColor: focusColor,
        hoverColor: hoverColor,
        focusNode: focusNode,
        autofocus: autofocus,
        pressColor: selectedTileColor ?? Cupertino.CupertinoColors.systemFill,
      ),
    );
  }

  @override
  Widget windows(BuildContext context) {
    final defaultTileColor = FluentUI.FluentTheme.of(context)
        .accentColor
        .defaultBrushFor(FluentUI.FluentTheme.of(context).brightness);

    return MouseRegion(
      cursor: mouseCursor ?? MouseCursor.defer,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: FluentUI.ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          shape: shape ??
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
          onPressed: enabled ? onTap ?? () {} : null,
          focusNode: focusNode,
          autofocus: autofocus,
          tileColor: tileColor != null ||
                  hoverColor != null ||
                  focusColor != null ||
                  selectedTileColor != null
              ? FluentUI.ButtonState.resolveWith((states) {
                  if (states.contains(FluentUI.ButtonStates.hovering)) {
                    return hoverColor ?? defaultTileColor;
                  }
                  if (states.contains(FluentUI.ButtonStates.pressing)) {
                    return focusColor ?? defaultTileColor;
                  }
                  if (states.contains(FluentUI.ButtonStates.focused)) {
                    return selectedTileColor ?? defaultTileColor;
                  }
                  return tileColor ?? defaultTileColor;
                })
              : null,
        ),
      ),
    );
  }
}
