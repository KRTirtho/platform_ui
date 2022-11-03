import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';

class PlatformAlertDialog extends StatelessWidget with PlatformMixin<Widget> {
  final Widget title;
  final Widget? content;
  final List<Widget>? primaryActions;
  final List<Widget>? secondaryActions;
  final Widget icon;

  const PlatformAlertDialog({
    Key? key,
    required this.title,
    this.content,
    this.primaryActions,
    this.secondaryActions,
    this.icon = const FlutterLogo(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      textStyle: PlatformTheme.of(context).textTheme!.body!,
      child: getPlatformType(context),
    );
  }

  @override
  Widget android(BuildContext context) {
    return AlertDialog(
      actions: [...?secondaryActions, ...?primaryActions],
      title: title,
      icon: icon,
      content: content,
    );
  }

  @override
  Widget ios(BuildContext context) {
    return CupertinoAlertDialog(
      actions: [...?secondaryActions, ...?primaryActions],
      title: title,
      content: content,
    );
  }

  @override
  Widget linux(BuildContext context) {
    return android(context);
  }

  @override
  Widget macos(BuildContext context) {
    return MacosAlertDialog(
      appIcon: icon,
      title: title,
      message: content ?? Container(),
      primaryButton: Row(
        children: [
          ...?primaryActions?.map((action) => Expanded(child: action))
        ],
      ),
      secondaryButton: Row(children: [
        ...?secondaryActions?.map((action) => Expanded(child: action))
      ]),
    );
  }

  @override
  Widget windows(BuildContext context) {
    return FluentUI.ContentDialog(
      actions: [...?secondaryActions, ...?primaryActions],
      content: content,
      title: title,
    );
  }
}

Future<T?> showPlatformAlertDialog<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  String? barrierLabel,
  bool useRootNavigator = true,
  bool barrierDismissible = false,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  Color? barrierColor,
}) {
  switch (platform) {
    case TargetPlatform.iOS:
      return showCupertinoDialog<T>(
        context: context,
        builder: builder,
        barrierLabel: barrierLabel,
        useRootNavigator: useRootNavigator,
        barrierDismissible: barrierDismissible,
        routeSettings: routeSettings,
        anchorPoint: anchorPoint,
      );
    case TargetPlatform.macOS:
      return showMacosAlertDialog<T>(
        context: context,
        builder: builder,
        barrierLabel: barrierLabel,
        useRootNavigator: useRootNavigator,
        barrierDismissible: barrierDismissible,
        routeSettings: routeSettings,
        barrierColor: barrierColor,
      );
    case TargetPlatform.windows:
      return FluentUI.showDialog<T>(
        context: context,
        builder: builder,
        barrierLabel: barrierLabel,
        useRootNavigator: useRootNavigator,
        barrierDismissible: barrierDismissible,
        routeSettings: routeSettings,
        barrierColor: barrierColor,
      );
    case TargetPlatform.linux:
    case TargetPlatform.android:
    default:
      return showDialog<T>(
        context: context,
        builder: builder,
        barrierLabel: barrierLabel,
        useRootNavigator: useRootNavigator,
        barrierDismissible: barrierDismissible,
        routeSettings: routeSettings,
        anchorPoint: anchorPoint,
        barrierColor: barrierColor,
      );
  }
}
