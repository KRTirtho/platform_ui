// ignore_for_file: library_prefixes

import 'package:fluent_ui/fluent_ui.dart' hide ThemeData;
import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/src/platform_mixin.dart';

// TODO: Implement [PlatformTheme]

class PlatformApp extends StatelessWidget with PlatformMixin<Widget> {
  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? androidTheme;
  final ThemeData? androidDarkTheme;
  final ThemeData? androidHighContrastTheme;
  final ThemeData? androidHighContrastDarkTheme;
  final CupertinoThemeData? iosTheme;
  final MacosThemeData? macosTheme;
  final MacosThemeData? macosDarkTheme;
  final FluentUI.ThemeData? windowsTheme;
  final FluentUI.ThemeData? windowsDarkTheme;
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
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool debugShowMaterialGrid;
  final bool useInheritedMediaQuery;

  const PlatformApp({
    Key? key,
    this.navigatorKey,
    this.scaffoldMessengerKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.androidTheme,
    this.androidDarkTheme,
    this.androidHighContrastTheme,
    this.androidHighContrastDarkTheme,
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
    this.debugShowMaterialGrid = false,
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
  }) : super(key: key);

  @override
  Widget android(context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: home,
      routes: routes!,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      navigatorObservers: navigatorObservers!,
      builder: builder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      theme: androidTheme,
      darkTheme: androidDarkTheme,
      highContrastTheme: androidHighContrastTheme,
      highContrastDarkTheme: androidHighContrastDarkTheme,
      themeMode: themeMode,
      color: color,
      locale: locale,
      localizationsDelegates: [
        ...(localizationsDelegates ?? []),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FluentUI.FluentLocalizations.delegate,
      ],
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      scrollBehavior: scrollBehavior,
      debugShowMaterialGrid: debugShowMaterialGrid,
      useInheritedMediaQuery: useInheritedMediaQuery,
    );
  }

  @override
  Widget ios(context) {
    return CupertinoApp(
      navigatorKey: navigatorKey,
      home: home,
      routes: routes!,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      navigatorObservers: navigatorObservers!,
      builder: builder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      theme: iosTheme,
      color: color,
      locale: locale,
      localizationsDelegates: [
        ...(localizationsDelegates ?? []),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FluentUI.FluentLocalizations.delegate,
      ],
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      scrollBehavior: scrollBehavior,
      useInheritedMediaQuery: useInheritedMediaQuery,
    );
  }

  @override
  Widget linux(context) {
    return android(context);
  }

  @override
  Widget macos(context) {
    return MacosApp(
      navigatorKey: navigatorKey,
      home: home,
      routes: routes!,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      navigatorObservers: navigatorObservers!,
      builder: builder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      theme: macosTheme,
      darkTheme: macosDarkTheme,
      themeMode: themeMode,
      color: color,
      locale: locale,
      localizationsDelegates: [
        ...(localizationsDelegates ?? []),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FluentUI.FluentLocalizations.delegate,
      ],
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      scrollBehavior: scrollBehavior ?? const MacosScrollBehavior(),
    );
  }

  @override
  Widget windows(context) {
    return FluentApp(
      navigatorKey: navigatorKey,
      home: home,
      routes: routes!,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      navigatorObservers: navigatorObservers!,
      builder: builder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      theme: windowsTheme,
      darkTheme: windowsDarkTheme,
      themeMode: themeMode,
      color: color,
      locale: locale,
      localizationsDelegates: [
        ...(localizationsDelegates ?? []),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FluentUI.FluentLocalizations.delegate,
      ],
      supportedLocales: [
        ...supportedLocales,
        const Locale('en', 'US'),
      ],
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      scrollBehavior: scrollBehavior ?? const FluentScrollBehavior(),
      useInheritedMediaQuery: useInheritedMediaQuery,
    );
  }

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }
}
