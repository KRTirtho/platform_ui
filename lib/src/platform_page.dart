import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

class PlatformPage extends Page {
  final Widget child;
  final bool fullscreenDialog;
  const PlatformPage({
    required this.child,
    this.fullscreenDialog = false,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route createRoute(BuildContext context) {
    return PlatformPageRoute(
      builder: (context) => child,
      fullscreenDialog: fullscreenDialog,
      settings: this,
    );
  }
}
