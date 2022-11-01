import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

class PlatformText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  const PlatformText(
    this.data, {
    super.key,
    this.locale,
    this.maxLines,
    this.overflow,
    this.selectionColor,
    this.semanticsLabel,
    this.softWrap,
    this.strutStyle,
    this.style,
    this.textAlign,
    this.textDirection,
    this.textHeightBehavior,
    this.textScaleFactor,
    this.textWidthBasis,
  });

  static Widget headline(
    String data, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFacto,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    Color? selectionColor,
  }) {
    return Builder(builder: (context) {
      return Text(
        data,
        locale: locale,
        maxLines: maxLines,
        overflow: overflow,
        selectionColor: selectionColor,
        semanticsLabel: semanticsLabel,
        softWrap: softWrap,
        strutStyle: strutStyle,
        style: PlatformTextTheme.of(context).headline?.merge(style),
        textAlign: textAlign,
        textDirection: textDirection,
        textHeightBehavior: textHeightBehavior,
        textScaleFactor: textScaleFactor,
        textWidthBasis: textWidthBasis,
      );
    });
  }

  static Widget subheading(
    String data, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFacto,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    Color? selectionColor,
  }) {
    return Builder(builder: (context) {
      return Text(
        data,
        locale: locale,
        maxLines: maxLines,
        overflow: overflow,
        selectionColor: selectionColor,
        semanticsLabel: semanticsLabel,
        softWrap: softWrap,
        strutStyle: strutStyle,
        style: PlatformTextTheme.of(context).subheading?.merge(style),
        textAlign: textAlign,
        textDirection: textDirection,
        textHeightBehavior: textHeightBehavior,
        textScaleFactor: textScaleFactor,
        textWidthBasis: textWidthBasis,
      );
    });
  }

  static Widget caption(
    String data, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFacto,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    Color? selectionColor,
  }) {
    return Builder(builder: (context) {
      return Text(
        data,
        locale: locale,
        maxLines: maxLines,
        overflow: overflow,
        selectionColor: selectionColor,
        semanticsLabel: semanticsLabel,
        softWrap: softWrap,
        strutStyle: strutStyle,
        style: PlatformTextTheme.of(context).caption?.merge(style),
        textAlign: textAlign,
        textDirection: textDirection,
        textHeightBehavior: textHeightBehavior,
        textScaleFactor: textScaleFactor,
        textWidthBasis: textWidthBasis,
      );
    });
  }

  static Widget label(
    String data, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFacto,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    double? textScaleFactor,
    Color? selectionColor,
  }) {
    return Builder(builder: (context) {
      return Text(
        data,
        locale: locale,
        maxLines: maxLines,
        overflow: overflow,
        selectionColor: selectionColor,
        semanticsLabel: semanticsLabel,
        softWrap: softWrap,
        strutStyle: strutStyle,
        style: PlatformTextTheme.of(context).label?.merge(style),
        textAlign: textAlign,
        textDirection: textDirection,
        textHeightBehavior: textHeightBehavior,
        textScaleFactor: textScaleFactor,
        textWidthBasis: textWidthBasis,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      locale: locale,
      maxLines: maxLines,
      overflow: overflow,
      selectionColor: selectionColor,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      strutStyle: strutStyle,
      style: PlatformTextTheme.of(context).body?.merge(
            DefaultTextStyle.of(context).style.merge(style),
          ),
      textAlign: textAlign,
      textDirection: textDirection,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}
