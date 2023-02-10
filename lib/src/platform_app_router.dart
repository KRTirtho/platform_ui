import 'package:adwaita/adwaita.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:platform_ui/platform_ui.dart';

class PlatformAppRouter extends StatelessWidget with PlatformMixin<Widget> {
  final GlobalKey<ScaffoldMessengerState>? androidScaffoldMessengerKey;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object> routeInformationParser;
  final RouterDelegate<Object> routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? androidTheme;
  final ThemeData? androidDarkTheme;
  final ThemeData? linuxTheme;
  final ThemeData? linuxDarkTheme;
  final CupertinoThemeData? iosTheme;
  final MacosThemeData? macosTheme;
  final MacosThemeData? macosDarkTheme;
  final FluentUI.FluentThemeData? windowsTheme;
  final FluentUI.FluentThemeData? windowsDarkTheme;
  final ThemeData? androidHighContrastTheme;
  final ThemeData? androidHghContrastDarkTheme;
  final ThemeMode? themeMode;
  final Color? color;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final PlatformProperty<Map<LogicalKeySet, Intent>>? shortcuts;
  final PlatformProperty<Map<Type, Action<Intent>>>? actions;
  final String? restorationScopeId;
  final PlatformProperty<ScrollBehavior>? scrollBehavior;
  final bool androidDebugShowMaterialGrid;
  final bool useInheritedMediaQuery;
  final PlatformWindowButtonConfig? windowButtonConfig;

  const PlatformAppRouter({
    Key? key,
    this.androidScaffoldMessengerKey,
    this.routeInformationProvider,
    required this.routeInformationParser,
    required this.routerDelegate,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.androidTheme,
    this.androidDarkTheme,
    this.linuxTheme,
    this.linuxDarkTheme,
    this.androidHighContrastTheme,
    this.androidHghContrastDarkTheme,
    this.iosTheme,
    this.macosTheme,
    this.macosDarkTheme,
    this.windowsTheme,
    this.windowsDarkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.androidDebugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.useInheritedMediaQuery = false,
    this.windowButtonConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (windowButtonConfig != null) {
      return PlatformWindowButtonConfigProvider(
        config: windowButtonConfig!,
        child: getPlatformType(context),
      );
    }
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: androidScaffoldMessengerKey,
      routeInformationProvider: routeInformationProvider,
      routeInformationParser: routeInformationParser,
      routerDelegate: routerDelegate,
      backButtonDispatcher: backButtonDispatcher,
      builder: builder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      theme: androidTheme,
      darkTheme: androidDarkTheme,
      highContrastTheme: androidHighContrastTheme,
      highContrastDarkTheme: androidHghContrastDarkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      debugShowMaterialGrid: androidDebugShowMaterialGrid,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts?.android,
      actions: actions?.android,
      scrollBehavior: scrollBehavior?.android,
      restorationScopeId: restorationScopeId,
      useInheritedMediaQuery: useInheritedMediaQuery,
    );
  }

  @override
  Widget ios(BuildContext context) {
    return CupertinoApp.router(
      routeInformationProvider: routeInformationProvider,
      routeInformationParser: routeInformationParser,
      routerDelegate: routerDelegate,
      backButtonDispatcher: backButtonDispatcher,
      builder: builder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      theme: iosTheme,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts?.ios,
      actions: actions?.ios,
      scrollBehavior: scrollBehavior?.ios,
      restorationScopeId: restorationScopeId,
      useInheritedMediaQuery: useInheritedMediaQuery,
    );
  }

  @override
  Widget linux(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: androidScaffoldMessengerKey,
      routeInformationProvider: routeInformationProvider,
      routeInformationParser: routeInformationParser,
      routerDelegate: routerDelegate,
      backButtonDispatcher: backButtonDispatcher,
      builder: builder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      theme: linuxTheme ?? AdwaitaThemeData.light(),
      darkTheme: linuxDarkTheme ?? AdwaitaThemeData.dark(),
      highContrastTheme: androidHighContrastTheme,
      highContrastDarkTheme: androidHghContrastDarkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      debugShowMaterialGrid: androidDebugShowMaterialGrid,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts?.android,
      actions: actions?.android,
      scrollBehavior: scrollBehavior?.android,
      restorationScopeId: restorationScopeId,
      useInheritedMediaQuery: useInheritedMediaQuery,
    );
  }

  @override
  Widget macos(BuildContext context) {
    return MacosApp.router(
      routeInformationProvider: routeInformationProvider,
      routeInformationParser: routeInformationParser,
      routerDelegate: routerDelegate,
      backButtonDispatcher: backButtonDispatcher,
      builder: builder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      theme: macosTheme,
      darkTheme: macosDarkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts?.macos,
      actions: actions?.macos,
      scrollBehavior: scrollBehavior?.macos ?? const MacosScrollBehavior(),
      restorationScopeId: restorationScopeId,
    );
  }

  @override
  Widget windows(BuildContext context) {
    return FluentUI.FluentApp.router(
      routeInformationProvider: routeInformationProvider,
      routeInformationParser: routeInformationParser,
      routerDelegate: routerDelegate,
      backButtonDispatcher: backButtonDispatcher,
      builder: builder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color ?? FluentUI.Colors.blue,
      theme: windowsTheme,
      darkTheme: windowsDarkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts?.windows,
      actions: actions?.windows,
      scrollBehavior:
          scrollBehavior?.windows ?? const FluentUI.FluentScrollBehavior(),
      restorationScopeId: restorationScopeId,
      useInheritedMediaQuery: useInheritedMediaQuery,
    );
  }
}
