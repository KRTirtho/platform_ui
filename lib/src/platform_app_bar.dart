import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:macos_ui/macos_ui.dart';

class PlatformAppBar extends StatelessWidget with PlatformMixin<Widget> {
  const PlatformAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    return AppBar();
  }

  @override
  Widget ios(BuildContext context) {
    return CupertinoNavigationBar();
  }

  @override
  Widget linux(BuildContext context) {
    return android(context);
  }

  @override
  Widget macos(BuildContext context) {
    return ToolBar();
  }

  @override
  Widget windows(BuildContext context) {
    return android(context);
  }
}
