import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:platform_ui/platform_ui.dart';

typedef PlatformWidgetBuilder<T> = Widget Function(
    BuildContext context, T data);

enum PlatformBuilderFallback {
  android,
  ios,
  macos,
  linux,
  windows,
}

class PlatformBuilder<T> extends StatelessWidget {
  final PlatformWidgetBuilder<T>? android;
  final PlatformWidgetBuilder<T>? ios;
  final PlatformWidgetBuilder<T>? macos;
  final PlatformWidgetBuilder<T>? linux;
  final PlatformWidgetBuilder<T>? windows;
  final T Function(BuildContext context)? data;
  final PlatformBuilderFallback? fallback;

  const PlatformBuilder({
    Key? key,
    this.data,
    this.android,
    this.ios,
    this.macos,
    this.linux,
    this.windows,
    this.fallback,
  })  : assert(
          android != null ||
              ios != null ||
              macos != null ||
              linux != null ||
              windows != null,
          'At least one platform must be specified',
        ),
        assert(
          fallback == null ||
              (fallback == PlatformBuilderFallback.android &&
                  android != null) ||
              (fallback == PlatformBuilderFallback.ios && ios != null) ||
              (fallback == PlatformBuilderFallback.macos && macos != null) ||
              (fallback == PlatformBuilderFallback.linux && linux != null) ||
              (fallback == PlatformBuilderFallback.windows && windows != null),
          "The builder for provided fallback `$fallback` can't be null",
        ),
        super(key: key);

  PlatformWidgetBuilder<T>? getByFallback() {
    switch (fallback) {
      case PlatformBuilderFallback.android:
        return android;
      case PlatformBuilderFallback.ios:
        return ios;
      case PlatformBuilderFallback.macos:
        return macos;
      case PlatformBuilderFallback.linux:
        return linux;
      case PlatformBuilderFallback.windows:
        return windows;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = this.data?.call(context);
    final fallback = getByFallback();
    if (kIsWeb) {
      return (windows ?? fallback ?? macos ?? linux ?? android ?? ios)!(
          context, data as T);
    }
    switch (platform ?? defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return (ios ?? fallback ?? android ?? macos ?? windows ?? linux)!(
            context, data as T);
      case TargetPlatform.macOS:
        return (macos ?? fallback ?? windows ?? linux ?? ios ?? android)!(
            context, data as T);
      case TargetPlatform.windows:
        return (windows ?? fallback ?? linux ?? macos ?? android ?? ios)!(
            context, data as T);
      case TargetPlatform.linux:
        return (linux ?? fallback ?? windows ?? macos ?? android ?? ios)!(
            context, data as T);
      case TargetPlatform.android:
      default:
        return (android ?? fallback ?? ios ?? windows ?? macos ?? linux)!(
            context, data as T);
    }
  }
}
