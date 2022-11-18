import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_core/libadwaita_core.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:macos_ui/macos_ui.dart';

// ignore: must_be_immutable
class PlatformAppBar extends StatelessWidget
    with PlatformMixin<Widget>
    implements ObstructingPreferredSizeWidget {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? actionsIconTheme;
  final bool? centerTitle;
  final double? titleSpacing;
  final double toolbarOpacity;
  final double? leadingWidth;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final double? titleWidth;

  PlatformAppBar({
    Key? key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.actionsIconTheme,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleWidth,
    this.titleTextStyle,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key) {
    if (platform == TargetPlatform.windows) {
      preferredSize = const Size.fromHeight(40);
    }
    if (platform == TargetPlatform.linux) {
      preferredSize = const Size.fromHeight(kToolbarHeight - 5);
    }
  }

  @override
  Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    final appBar = AppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      actionsIconTheme: actionsIconTheme,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
    );
    preferredSize = appBar.preferredSize;
    return appBar;
  }

  @override
  Widget ios(BuildContext context) {
    final Color defaultBackgroundColor =
        CupertinoDynamicColor.maybeResolve(backgroundColor, context) ??
            CupertinoTheme.of(context).barBackgroundColor;
    final styledTitle = title != null
        ? DefaultTextStyle(
            style: titleTextStyle ??
                CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            child: title!,
          )
        : null;

    final cupertinoNavigationBar = CupertinoNavigationBar(
      leading: centerTitle == false
          ? Row(children: [
              if (leading != null) leading!,
              SizedBox(width: titleSpacing),
              if (title != null) styledTitle!
            ])
          : leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      middle: centerTitle != false ? styledTitle : null,
      automaticallyImplyMiddle: true,
      backgroundColor: (backgroundColor ?? defaultBackgroundColor)
          .withOpacity(toolbarOpacity),
      transitionBetweenRoutes: true,
      trailing: actions != null
          ? IconTheme(
              data: actionsIconTheme ?? Theme.of(context).iconTheme,
              child: Row(mainAxisSize: MainAxisSize.min, children: actions!),
            )
          : null,
    );

    preferredSize = cupertinoNavigationBar.preferredSize;

    return IconTheme(
      data: const IconThemeData.fallback().copyWith(
        color: foregroundColor ??
            CupertinoDynamicColor.resolve(
              CupertinoColors.label,
              context,
            ),
      ),
      child: cupertinoNavigationBar,
    );
  }

  @override
  Widget linux(BuildContext context) {
    if (kIsWeb) return macos(context);
    final adwHeaderBar = AdwHeaderBar(
      actions: AdwActions(),
      title: title != null && titleTextStyle != null
          ? DefaultTextStyle(
              style: titleTextStyle!,
              child: title!,
            )
          : title,
      start: [
        if (leading != null)
          leading!
        else if (automaticallyImplyLeading == true)
          const PlatformBackButton(),
      ],
      end: [
        ...?actions,
      ],
      style: HeaderBarStyle(
        textStyle: toolbarTextStyle,
        titlebarSpace: titleSpacing ?? 6,
        isTransparent: backgroundColor != null,
      ),
    );
    if (backgroundColor != null) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(bottom: BorderSide(color: context.borderColor)),
        ),
        child: adwHeaderBar,
      );
    }
    return adwHeaderBar;
  }

  @override
  Widget macos(BuildContext context) {
    final styledTitle = title != null
        ? DefaultTextStyle(
            maxLines: 1,
            style: titleTextStyle ??
                CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            child: title!,
          )
        : null;

    preferredSize = const Size.fromHeight(52);

    return ToolBar(
      leading: leading != null
          ? DefaultTextStyle(
              style: toolbarTextStyle ?? MacosTheme.of(context).typography.body,
              child: IconTheme(
                data: actionsIconTheme ??
                    IconTheme.of(context).copyWith(
                      color: foregroundColor ??
                          MacosTheme.of(context).typography.body.color,
                    ),
                child: leading!,
              ),
            )
          : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: styledTitle,
      actions: actions
              ?.map(
                (e) => CustomToolbarItem(
                  inToolbarBuilder: (context) => DefaultTextStyle(
                    style: MacosTheme.of(context).typography.body,
                    child: IconTheme(
                      data: actionsIconTheme ??
                          IconTheme.of(context).copyWith(
                            color: foregroundColor ??
                                MacosTheme.of(context).typography.body.color,
                          ),
                      child: e,
                    ),
                  ),
                ),
              )
              .toList() ??
          <ToolbarItem>[],
      decoration: BoxDecoration(
        color: (backgroundColor ?? MacosTheme.of(context).canvasColor)
            .withOpacity(toolbarOpacity),
      ),
      titleWidth: titleWidth ?? 150,
      centerTitle: centerTitle ?? false,
    );
  }

  @override
  Widget windows(BuildContext context) {
    final appBar = AppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      backgroundColor: backgroundColor ??
          FluentTheme.of(context).navigationPaneTheme.backgroundColor,
      elevation: 0,
      foregroundColor: foregroundColor,
      actionsIconTheme: actionsIconTheme,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing ?? 0,
      toolbarOpacity: toolbarOpacity,
      leadingWidth: leadingWidth,
      iconTheme: FluentTheme.of(context).iconTheme,
      toolbarTextStyle:
          FluentTheme.of(context).typography.bodyLarge?.merge(titleTextStyle),
      titleTextStyle:
          FluentTheme.of(context).typography.bodyLarge?.merge(titleTextStyle),
      toolbarHeight: 40,
    );
    preferredSize = appBar.preferredSize;
    return appBar;
  }

  @override
  bool shouldFullyObstruct(BuildContext context) {
    final Color backgroundColor =
        CupertinoDynamicColor.maybeResolve(this.backgroundColor, context) ??
            CupertinoTheme.of(context).barBackgroundColor;
    return backgroundColor.alpha == 0xFF;
  }
}
