import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/src/platform_mixin.dart';

class PlatformCircularProgressIndicator extends StatelessWidget
    with PlatformMixin<Widget> {
  final Color? backgroundColor;
  final Color? color;

  /// doesn't work in macos and ios
  ///
  /// use [radius] instead for them
  final double? strokeWidth;

  /// only works in macos and ios
  ///
  /// use [strokeWidth] instead for other platforms
  final double? radius;
  final double? value;
  final Animation<Color?>? valueColor;

  const PlatformCircularProgressIndicator({
    Key? key,
    this.backgroundColor,
    this.color,
    this.strokeWidth,
    this.radius,
    this.value,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: backgroundColor,
      color: color,
      strokeWidth: strokeWidth ?? 4,
      value: value,
      valueColor: valueColor,
    );
  }

  @override
  Widget ios(BuildContext context) {
    return CupertinoActivityIndicator(color: color, radius: radius ?? 10);
  }

  @override
  Widget linux(BuildContext context) {
    return android(context);
  }

  @override
  Widget macos(BuildContext context) {
    return ProgressCircle(
      borderColor: backgroundColor,
      innerColor: color,
      radius: radius ?? 10,
      value: value,
    );
  }

  @override
  Widget windows(BuildContext context) {
    return ProgressRing(
      backgroundColor: backgroundColor,
      activeColor: color,
      strokeWidth: strokeWidth ?? 4,
      value: value,
    );
  }
}
