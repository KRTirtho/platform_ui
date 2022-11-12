import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
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
      child: AdwHeaderButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          } else {
            Navigator.maybePop(context);
          }
        },
        icon: Icon(
          Icons.chevron_left_rounded,
          color: color,
          size: 25,
        ),
      ),
    );
  }

  @override
  Widget macos(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: MacosBackButton(
        fillColor: color,
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget windows(BuildContext context) {
    return PlatformTooltip(
      message: FluentUI.FluentLocalizations.of(context).backButtonTooltip,
      child: Container(
        margin: const EdgeInsets.all(4),
        child: FluentUI.IconButton(
          onPressed: () {
            if (onPressed != null) {
              onPressed!();
            } else {
              Navigator.maybePop(context);
            }
          },
          icon: Icon(
            Icons.arrow_back,
            color: color,
            size: 18,
          ),
        ),
      ),
    );
  }
}
