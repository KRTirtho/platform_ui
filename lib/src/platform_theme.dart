import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:platform_ui/src/tools/platform_mixin.dart' as platformMixin;

class PlatformTextTheme {
  TextStyle? body;
  TextStyle? headline;
  TextStyle? caption;
  TextStyle? label;
  TextStyle? subheading;

  PlatformTextTheme({
    this.body,
    this.headline,
    this.caption,
    this.label,
    this.subheading,
  });

  @override
  operator ==(other) {
    if (other is PlatformTextTheme) {
      return body == other.body &&
          headline == other.headline &&
          caption == other.caption &&
          label == other.label &&
          subheading == other.subheading;
    }
    return false;
  }

  @override
  int get hashCode {
    return Object.hash(
      body,
      headline,
      caption,
      label,
      subheading,
    );
  }

  static PlatformTextTheme of(BuildContext context) {
    return PlatformTheme.of(context).textTheme!;
  }

  static PlatformTextTheme? maybeOf(BuildContext context) {
    return PlatformTheme.of(context).textTheme;
  }
}

class PlatformThemeData {
  Color? secondaryBackgroundColor;
  Color? scaffoldBackgroundColor;
  Color? primaryColor;
  Color? shadowColor;
  Color? borderColor;
  IconThemeData? iconTheme;
  PlatformTextTheme? textTheme;
  Brightness? brightness;
  TargetPlatform? platform;

  PlatformThemeData({
    this.secondaryBackgroundColor,
    this.scaffoldBackgroundColor,
    this.primaryColor,
    this.shadowColor,
    this.borderColor,
    this.iconTheme,
    this.textTheme,
    this.brightness,
    this.platform,
  });

  factory PlatformThemeData.fromContext(BuildContext context) {
    final androidTheme = Theme.of(context);
    final macosTheme = MacosTheme.of(context);
    final iosTheme = CupertinoTheme.of(context);
    final windowsTheme = FluentTheme.maybeOf(context);

    final currentPlatform = platformMixin.platform ?? androidTheme.platform;

    return PlatformThemeData(
      platform: currentPlatform,
      iconTheme: PlatformProperty(
        android: androidTheme.iconTheme,
        linux: androidTheme.iconTheme,
        ios: androidTheme.iconTheme,
        macos: IconThemeData(
          color: macosTheme.iconTheme.color,
          opacity: macosTheme.iconTheme.opacity,
          size: macosTheme.iconTheme.size,
        ),
        windows: windowsTheme?.iconTheme,
      ).resolve(currentPlatform),
      primaryColor: PlatformProperty(
        android: androidTheme.primaryColor,
        linux: androidTheme.primaryColor,
        ios: iosTheme.primaryColor,
        macos: macosTheme.primaryColor,
        windows: windowsTheme?.accentColor,
      ).resolve(currentPlatform),
      scaffoldBackgroundColor: PlatformProperty(
        android: androidTheme.scaffoldBackgroundColor,
        linux: androidTheme.scaffoldBackgroundColor,
        ios: iosTheme.scaffoldBackgroundColor,
        macos: macosTheme.canvasColor,
        windows: windowsTheme?.scaffoldBackgroundColor,
      ).resolve(currentPlatform),
      secondaryBackgroundColor: PlatformProperty(
        android: androidTheme.cardColor,
        linux: androidTheme.cardColor,
        ios: iosTheme.barBackgroundColor,
        macos: macosTheme.pulldownButtonTheme.backgroundColor,
        windows: windowsTheme?.cardColor,
      ).resolve(currentPlatform),
      textTheme: PlatformTextTheme(
        body: PlatformProperty(
          android: androidTheme.textTheme.bodyText1,
          linux: androidTheme.textTheme.bodyText1,
          ios: iosTheme.textTheme.textStyle,
          macos: macosTheme.typography.body,
          windows: windowsTheme?.typography.body,
        ).resolve(currentPlatform),
        headline: PlatformProperty(
          android: androidTheme.textTheme.headline3?.copyWith(fontSize: 24),
          linux: androidTheme.textTheme.headline3,
          ios: iosTheme.textTheme.navLargeTitleTextStyle,
          macos: macosTheme.typography.largeTitle,
          windows: windowsTheme?.typography.title,
        ).resolve(currentPlatform),
        caption: PlatformProperty(
          android: androidTheme.textTheme.caption,
          linux: androidTheme.textTheme.caption,
          ios: iosTheme.textTheme.tabLabelTextStyle,
          macos: macosTheme.typography.caption1,
          windows: windowsTheme?.typography.caption,
        ).resolve(currentPlatform),
        label: PlatformProperty(
          android: androidTheme.textTheme.labelMedium,
          linux: androidTheme.textTheme.labelMedium,
          ios: iosTheme.textTheme.navActionTextStyle,
          macos: macosTheme.typography.caption2,
          windows: windowsTheme?.typography.subtitle,
        ).resolve(currentPlatform),
        subheading: PlatformProperty(
          android: androidTheme.textTheme.headline4,
          linux: androidTheme.textTheme.headline4,
          ios: iosTheme.textTheme.navTitleTextStyle,
          macos: macosTheme.typography.title1,
          windows: windowsTheme?.typography.bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ).resolve(currentPlatform),
      ),
      borderColor: PlatformProperty(
        android: androidTheme.dividerColor,
        linux: androidTheme.dividerColor,
        ios: iosTheme.primaryContrastingColor,
        macos: macosTheme.dividerColor,
        windows: windowsTheme?.micaBackgroundColor.withOpacity(.6),
      ).resolve(currentPlatform),
      shadowColor: PlatformProperty(
        android: androidTheme.shadowColor,
        linux: androidTheme.shadowColor,
        ios: Colors.transparent,
        macos: Colors.transparent,
        windows: windowsTheme?.shadowColor,
      ).resolve(currentPlatform),
      brightness: PlatformProperty(
        android: androidTheme.brightness,
        linux: androidTheme.brightness,
        ios: iosTheme.brightness,
        macos: macosTheme.brightness,
        windows: windowsTheme?.brightness,
      ).resolve(currentPlatform),
    );
  }

  void setPlatform(TargetPlatform targetPlatform) {
    platform = targetPlatform;
  }

  @override
  operator ==(other) {
    return other is PlatformThemeData &&
        other.secondaryBackgroundColor == secondaryBackgroundColor &&
        other.scaffoldBackgroundColor == scaffoldBackgroundColor &&
        other.primaryColor == primaryColor &&
        other.shadowColor == shadowColor &&
        other.borderColor == borderColor &&
        other.iconTheme == iconTheme &&
        other.platform == platform &&
        other.textTheme == textTheme;
  }

  @override
  int get hashCode {
    return Object.hash(
      secondaryBackgroundColor,
      scaffoldBackgroundColor,
      primaryColor,
      shadowColor,
      borderColor,
      iconTheme,
      textTheme,
      platform,
    );
  }
}

class PlatformTheme extends InheritedWidget {
  final PlatformThemeData theme;

  const PlatformTheme({
    required this.theme,
    required super.child,
    super.key,
  });

  static PlatformThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PlatformTheme>()!.theme;
  }

  static PlatformThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PlatformTheme>()?.theme;
  }

  @override
  bool updateShouldNotify(covariant PlatformTheme oldWidget) {
    return oldWidget.theme != theme;
  }
}
