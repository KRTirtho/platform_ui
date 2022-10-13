import 'package:flutter/material.dart';
import 'package:platform_ui/src/platform_property.dart';
import 'package:platform_ui/src/platform_theme.dart';

class PlatformButtonThemeData {
  final PlatformProperty<ButtonTextTheme>? textTheme;
  final PlatformProperty<Color>? textColor;
  final PlatformProperty<Color>? disabledTextColor;
  final PlatformProperty<Color>? color;
  final PlatformProperty<Color>? disabledColor;
  final PlatformProperty<Color>? focusColor;
  final PlatformProperty<Color>? hoverColor;
  final PlatformProperty<Color>? highlightColor;
  final PlatformProperty<Color>? splashColor;
  final PlatformProperty<double>? elevation;
  final PlatformProperty<double>? focusElevation;
  final PlatformProperty<double>? hoverElevation;
  final PlatformProperty<double>? highlightElevation;
  final PlatformProperty<double>? disabledElevation;
  final PlatformProperty<EdgeInsetsGeometry>? padding;
  final PlatformProperty<ShapeBorder>? shape;
  final PlatformProperty<Duration>? animationDuration;
  final PlatformProperty<double>? minWidth;
  final PlatformProperty<double>? height;

  PlatformButtonThemeData({
    this.textTheme,
    this.textColor,
    this.disabledTextColor,
    this.color,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding,
    this.shape,
    this.animationDuration,
    this.minWidth,
    this.height,
  });
}

class PlatformButton extends StatelessWidget {
  final PlatformProperty<ButtonTextTheme>? textTheme;
  final PlatformProperty<Color>? textColor;
  final PlatformProperty<Color>? disabledTextColor;
  final PlatformProperty<Color>? color;
  final PlatformProperty<Color>? disabledColor;
  final PlatformProperty<Color>? focusColor;
  final PlatformProperty<Color>? hoverColor;
  final PlatformProperty<Color>? highlightColor;
  final PlatformProperty<Color>? splashColor;
  final PlatformProperty<double>? elevation;
  final PlatformProperty<double>? focusElevation;
  final PlatformProperty<double>? hoverElevation;
  final PlatformProperty<double>? highlightElevation;
  final PlatformProperty<double>? disabledElevation;
  final PlatformProperty<EdgeInsetsGeometry>? padding;
  final PlatformProperty<ShapeBorder>? shape;
  final PlatformProperty<double>? materialTapTargetSize;
  final PlatformProperty<Duration>? animationDuration;
  final PlatformProperty<double>? minWidth;
  final PlatformProperty<double>? height;

  final void Function() onPressed;
  final Widget? child;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final Brightness? colorBrightness;

  const PlatformButton({
    required this.onPressed,
    this.child,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.textTheme,
    this.textColor,
    this.enableFeedback = false,
    this.focusNode,
    this.disabledTextColor,
    this.colorBrightness,
    this.color,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding,
    this.shape,
    this.materialTapTargetSize,
    this.animationDuration,
    this.minWidth,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final platformTheme = PlatformTheme.of(context)?.buttonTheme;

    return MaterialButton(
      onPressed: onPressed,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      colorBrightness: colorBrightness,
      enableFeedback: enableFeedback,
      textTheme: (textTheme ?? platformTheme?.textTheme)?.resolve(platform),
      textColor: (textColor ?? platformTheme?.textColor)?.resolve(platform),
      disabledTextColor: (disabledTextColor ?? platformTheme?.disabledTextColor)
          ?.resolve(platform),
      color: (color ?? platformTheme?.color)?.resolve(platform),
      disabledColor:
          (disabledColor ?? platformTheme?.disabledColor)?.resolve(platform),
      focusColor: (focusColor ?? platformTheme?.focusColor)?.resolve(platform),
      hoverColor: (hoverColor ?? platformTheme?.hoverColor)?.resolve(platform),
      highlightColor:
          (highlightColor ?? platformTheme?.highlightColor)?.resolve(platform),
      splashColor:
          (splashColor ?? platformTheme?.splashColor)?.resolve(platform),
      elevation: (elevation ?? platformTheme?.elevation)?.resolve(platform),
      focusElevation:
          (focusElevation ?? platformTheme?.focusElevation)?.resolve(platform),
      hoverElevation:
          (hoverElevation ?? platformTheme?.hoverElevation)?.resolve(platform),
      highlightElevation:
          (highlightElevation ?? platformTheme?.highlightElevation)
              ?.resolve(platform),
      disabledElevation: (disabledElevation ?? platformTheme?.disabledElevation)
          ?.resolve(platform),
      padding: (padding ?? platformTheme?.padding)?.resolve(platform),
      shape: (shape ?? platformTheme?.shape)?.resolve(platform),
      animationDuration: (animationDuration ?? platformTheme?.animationDuration)
          ?.resolve(platform),
      minWidth: (minWidth ?? platformTheme?.minWidth)?.resolve(platform),
      height: (height ?? platformTheme?.height)?.resolve(platform),
      child: child,
    );
  }
}
