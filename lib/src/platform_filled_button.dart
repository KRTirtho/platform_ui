// ignore_for_file: library_prefixes

import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:platform_ui/src/tools/utils.dart';

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
  final bool? isSecondary;
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
    this.isSecondary,
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
        style: themedStyle(context),
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

  ButtonStyle? themedStyle(BuildContext context) {
    final isDark = PlatformTheme.of(context).brightness == Brightness.dark;

    return isSecondary == true
        ? (style ?? const ButtonStyle()).copyWith(
            backgroundColor: MaterialStatePropertyAll(
              isDark ? Colors.grey[700] : Colors.grey[300],
            ),
            foregroundColor: MaterialStatePropertyAll(
              isDark ? Colors.white : Colors.black,
            ),
          )
        : style;
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
              padding: style?.padding?.resolve(allStates) ??
                  const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget linux(context) {
    final buttonStyle = themedStyle(context);

    return ClipRect(
      clipBehavior: clipBehavior,
      child: Focus(
        autofocus: autofocus,
        focusNode: focusNode,
        child: MouseRegion(
          cursor: mouseCursor,
          onHover: onHover,
          child: GestureDetector(
            onLongPress: onLongPress,
            child: AdwButton(
              opaque: true,
              onPressed: onPressed,
              animationDuration: buttonStyle?.animationDuration ??
                  const Duration(milliseconds: 200),
              backgroundColor:
                  buttonStyle?.backgroundColor?.resolve(allStates) ??
                      PlatformTheme.of(context).primaryColor,
              borderRadius:
                  borderRadius ?? const BorderRadius.all(Radius.circular(6)),
              padding: buttonStyle?.padding?.resolve(allStates) ??
                  AdwButton.defaultButtonPadding,
              textStyle: buttonStyle?.backgroundColor == null
                  ? PlatformTheme.of(context)
                      .textTheme
                      ?.body
                      ?.copyWith(color: Colors.white)
                  : buttonStyle?.textStyle?.resolve(allStates),
              boxShadow: buttonStyle?.elevation?.resolve(allStates) != null
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            buttonStyle!.elevation!.resolve(allStates)! / 1000),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget macos(context) {
    final themedStyle = this.themedStyle(context);
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
            child: IconTheme(
              data: IconTheme.of(context).copyWith(
                color: themedStyle?.foregroundColor
                        ?.resolve(Utils.allMaterialStates) ??
                    MacosTheme.of(context).pushButtonTheme.secondaryColor,
              ),
              child: PushButton(
                onPressed: onPressed,
                pressedOpacity: macOSiOSPressedOpacity,
                borderRadius: borderRadius ??
                    const BorderRadius.all(Radius.circular(4.0)),
                buttonSize: macOSButtonSize,
                isSecondary: isSecondary,
                mouseCursor: mouseCursor,
                color: themedStyle?.backgroundColor?.resolve(allStates),
                disabledColor: themedStyle?.backgroundColor
                        ?.resolve({MaterialState.disabled}) ??
                    CupertinoColors.quaternarySystemFill,
                padding: style?.padding?.resolve(allStates),
                child: DefaultTextStyle(
                  style: MacosTheme.of(context).typography.body.copyWith(
                        color: themedStyle?.foregroundColor
                                ?.resolve(Utils.allMaterialStates) ??
                            MacosTheme.of(context)
                                .pushButtonTheme
                                .secondaryColor,
                      ),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget windows(context) {
    final themedStyle = this.themedStyle(context);
    return ClipRect(
      clipBehavior: clipBehavior,
      child: MouseRegion(
        cursor: mouseCursor,
        onHover: onHover,
        child: FluentUI.FilledButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          autofocus: autofocus,
          focusNode: focusNode,
          style: FluentUI.ButtonStyle(
            backgroundColor:
                Utils.resolveMaterialPropertyAsAllButtonState<Color?>(
              allStates,
              themedStyle?.backgroundColor,
            ),
            elevation: Utils.resolveMaterialPropertyAsAllButtonState<double?>(
              allStates,
              style?.elevation,
            ),
            foregroundColor:
                Utils.resolveMaterialPropertyAsAllButtonState<Color?>(
              allStates,
              themedStyle?.foregroundColor,
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
    final child = getPlatformType(context);
    return style?.textStyle != null
        ? DefaultTextStyle(
            style: style!.textStyle!.resolve(Utils.allMaterialStates)!,
            child: child,
          )
        : child;
  }
}
