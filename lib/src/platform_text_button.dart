// ignore_for_file: library_prefixes

import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';
import "package:platform_ui/src/utils.dart";

class PlatformTextButton extends StatelessWidget with PlatformMixin<Widget> {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final void Function(PointerHoverEvent)? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final Widget child;
  final double macOSiOSPressedOpacity;
  final MouseCursor mouseCursor;

  const PlatformTextButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.mouseCursor = SystemMouseCursors.click,
    this.onHover,
    this.macOSiOSPressedOpacity = .4,
  }) : super(key: key);

  final allStates = const {
    MaterialState.focused,
    MaterialState.disabled,
    MaterialState.error,
    MaterialState.hovered,
    MaterialState.pressed,
    MaterialState.selected,
  };

  @override
  Widget android(context) {
    return MouseRegion(
      onHover: onHover,
      cursor: mouseCursor,
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        onFocusChange: onFocusChange,
        style: style,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        child: child,
      ),
    );
  }

  BorderRadius? get borderRadius {
    final shape = style?.shape?.resolve(allStates);
    if (shape is RoundedRectangleBorder && shape.borderRadius is BorderRadius) {
      return shape.borderRadius as BorderRadius;
    }
    return null;
  }

  @override
  Widget ios(context) {
    return ClipRect(
      clipBehavior: clipBehavior,
      child: Focus(
        autofocus: autofocus,
        focusNode: focusNode,
        child: MouseRegion(
          onHover: onHover,
          cursor: mouseCursor,
          child: GestureDetector(
            onLongPress: onLongPress,
            child: CupertinoButton(
              color: style?.foregroundColor?.resolve(allStates),
              onPressed: onPressed,
              pressedOpacity: macOSiOSPressedOpacity,
              borderRadius:
                  borderRadius ?? const BorderRadius.all(Radius.circular(8.0)),
              minSize: style?.minimumSize?.resolve(allStates)?.width,
              disabledColor:
                  style?.backgroundColor?.resolve({MaterialState.disabled}) ??
                      CupertinoColors.quaternarySystemFill,
              padding: style?.padding?.resolve(allStates),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget linux(context) {
    return android(context);
  }

  @override
  Widget macos(context) {
    return ios(context);
  }

  @override
  Widget windows(context) {
    return ClipRect(
      clipBehavior: clipBehavior,
      child: MouseRegion(
        cursor: mouseCursor,
        onHover: onHover,
        child: FluentUI.TextButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          autofocus: autofocus,
          focusNode: focusNode,
          style: FluentUI.ButtonStyle(
            backgroundColor:
                Utils.resolveMaterialPropertyAsAllButtonState<Color?>(
              allStates,
              style?.backgroundColor,
            ),
            elevation: Utils.resolveMaterialPropertyAsAllButtonState<double?>(
              allStates,
              style?.elevation,
            ),
            foregroundColor:
                Utils.resolveMaterialPropertyAsAllButtonState<Color?>(
              allStates,
              style?.foregroundColor,
            ),
            padding: Utils.resolveMaterialPropertyAsAllButtonState(
              allStates,
              style?.padding,
            ),
            shadowColor: Utils.resolveMaterialPropertyAsAllButtonState<Color?>(
              allStates,
              style?.shadowColor,
            ),
            textStyle: Utils.resolveMaterialPropertyAsAllButtonState(
              allStates,
              style?.textStyle,
            ),
            shape: Utils.resolveMaterialPropertyAsAllButtonState(
              allStates,
              style?.shape,
            ),
            border: Utils.resolveMaterialPropertyAsAllButtonState(
              allStates,
              style?.side,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }
}
