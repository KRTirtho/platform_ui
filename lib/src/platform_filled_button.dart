// ignore_for_file: library_prefixes

import 'package:fluent_ui/fluent_ui.dart' hide ButtonStyle;
import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';
import "package:platform_ui/src/utils.dart";

class PlatformFilledButton extends StatelessWidget with PlatformMixin<Widget> {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final void Function(PointerHoverEvent)? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final Widget child;
  final ButtonSize macOSButtonSize;
  final bool? macOSIsSecondary;
  final double macOSiOSPressedOpacity;
  final MouseCursor mouseCursor;

  const PlatformFilledButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.macOSButtonSize = ButtonSize.large,
    this.mouseCursor = SystemMouseCursors.click,
    this.onHover,
    this.macOSIsSecondary,
    this.macOSiOSPressedOpacity = .4,
  }) : super(key: key);

  Set<MaterialState> get allStates => Utils.allMaterialStates;

  @override
  Widget android(context) {
    return MouseRegion(
      onHover: onHover,
      cursor: mouseCursor,
      child: ElevatedButton(
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
            child: CupertinoButton.filled(
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
            child: PushButton(
              onPressed: onPressed,
              pressedOpacity: macOSiOSPressedOpacity,
              borderRadius:
                  borderRadius ?? const BorderRadius.all(Radius.circular(4.0)),
              buttonSize: macOSButtonSize,
              isSecondary: macOSIsSecondary,
              mouseCursor: mouseCursor,
              color: style?.backgroundColor?.resolve(allStates),
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
  Widget windows(context) {
    return ClipRect(
      clipBehavior: clipBehavior,
      child: MouseRegion(
        cursor: mouseCursor,
        onHover: onHover,
        child: FilledButton(
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
  Widget build(context) {
    return getPlatformType(context);
  }
}
