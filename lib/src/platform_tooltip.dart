import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

class PlatformTooltip extends StatelessWidget with PlatformMixin<Widget> {
  final String? message;
  final InlineSpan? richMessage;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? verticalOffset;
  final bool? preferBelow;
  final bool? excludeFromSemantics;
  final Widget? child;
  final Decoration? decoration;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Duration? waitDuration;
  final Duration? showDuration;
  final TooltipTriggerMode? triggerMode;
  final bool? enableFeedback;
  final TooltipTriggeredCallback? onTriggered;

  const PlatformTooltip({
    Key? key,
    this.message,
    this.richMessage,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.textAlign,
    this.waitDuration,
    this.showDuration,
    this.triggerMode,
    this.enableFeedback,
    this.onTriggered,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    return Tooltip(
      key: key,
      message: message,
      richMessage: richMessage,
      height: height,
      padding: padding,
      margin: margin,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
      excludeFromSemantics: excludeFromSemantics,
      decoration: decoration,
      textStyle: textStyle,
      textAlign: textAlign,
      waitDuration: waitDuration,
      showDuration: showDuration,
      triggerMode: triggerMode,
      enableFeedback: enableFeedback,
      onTriggered: onTriggered,
      child: child,
    );
  }

  @override
  Widget ios(BuildContext context) {
    return Tooltip(
      key: key,
      message: message,
      richMessage: richMessage,
      height: height,
      padding: padding ?? const EdgeInsets.all(12),
      margin: margin,
      verticalOffset: verticalOffset ?? 10,
      preferBelow: preferBelow ?? false,
      excludeFromSemantics: excludeFromSemantics,
      decoration:
          (decoration as BoxDecoration? ?? const BoxDecoration()).copyWith(
        color: CupertinoTheme.of(context).brightness == Brightness.light
            ? Colors.grey[900]
            : Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: textStyle,
      textAlign: textAlign,
      waitDuration: waitDuration,
      showDuration: showDuration,
      triggerMode: triggerMode,
      enableFeedback: enableFeedback,
      onTriggered: onTriggered,
      child: child,
    );
  }

  @override
  Widget linux(BuildContext context) {
    return android(context);
  }

  @override
  Widget macos(BuildContext context) {
    return Tooltip(
      key: key,
      message: message,
      richMessage: richMessage,
      height: height,
      padding: padding ?? const EdgeInsets.all(8),
      margin: margin,
      verticalOffset: verticalOffset ?? 10,
      preferBelow: preferBelow ?? false,
      excludeFromSemantics: excludeFromSemantics,
      decoration:
          (decoration as BoxDecoration? ?? const BoxDecoration()).copyWith(
        color: CupertinoTheme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.grey[800],
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: CupertinoTheme.of(context).brightness == Brightness.light
                ? Colors.grey[300]!
                : Colors.grey[900]!,
            blurRadius: 7,
            offset: const Offset(0, 0),
          )
        ],
      ),
      textStyle: textStyle ??
          TextStyle(
            color: CupertinoTheme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
      textAlign: textAlign,
      waitDuration: waitDuration,
      showDuration: showDuration,
      triggerMode: triggerMode,
      enableFeedback: enableFeedback,
      onTriggered: onTriggered,
      child: child,
    );
  }

  @override
  Widget windows(BuildContext context) {
    final fluentTheme = FluentUI.FluentTheme.of(context).tooltipTheme;

    return FluentUI.TooltipTheme(
      data: FluentUI.TooltipThemeData(
        textStyle: textStyle ?? fluentTheme.textStyle,
        decoration: decoration ?? fluentTheme.decoration,
        height: height ?? fluentTheme.height,
        margin: margin ?? fluentTheme.margin,
        verticalOffset: verticalOffset ?? fluentTheme.verticalOffset,
        preferBelow: preferBelow ?? fluentTheme.preferBelow,
        waitDuration: waitDuration ?? fluentTheme.waitDuration,
        showDuration: showDuration ?? fluentTheme.showDuration,
        padding: padding ?? fluentTheme.padding,
      ),
      child: FluentUI.Tooltip(
        key: key,
        message: message,
        richMessage: richMessage,
        excludeFromSemantics: excludeFromSemantics ?? false,
        triggerMode: triggerMode,
        enableFeedback: enableFeedback,
        child: child,
      ),
    );
  }
}
