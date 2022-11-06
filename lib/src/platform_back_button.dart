import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';

class PlatformBackButton extends StatelessWidget with PlatformMixin<Widget> {
  final Color? color;
  final VoidCallback? onPressed;
  const PlatformBackButton({Key? key, this.color, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    return BackButton(
      color: color,
      onPressed: onPressed,
    );
  }

  @override
  Widget ios(BuildContext context) {
    return CupertinoNavigationBarBackButton(
      color: color,
      onPressed: onPressed,
    );
  }

  @override
  Widget linux(BuildContext context) {
    return PlatformTooltip(
      message: MaterialLocalizations.of(context).backButtonTooltip,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: AdwButton.circular(
          onPressed: () {
            if (onPressed != null) {
              onPressed!();
            } else {
              Navigator.maybePop(context);
            }
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: color,
          ),
        ),
      ),
    );
  }

  @override
  Widget macos(BuildContext context) {
    return MacosBackButton(
      fillColor: color,
      onPressed: onPressed,
    );
  }

  @override
  Widget windows(BuildContext context) {
    return android(context);
  }
}
