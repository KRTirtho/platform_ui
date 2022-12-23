import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:platform_ui/src/specific/linux_window_button.dart';
import 'package:platform_ui/src/specific/windows_title_bar_icons.dart';
import 'package:platform_ui/src/tools/gesture_builder.dart';

class PlatformWindowButtonConfig {
  final VoidCallback onClose;
  final VoidCallback onMinimize;
  final VoidCallback onMaximize;
  final VoidCallback onRestore;
  final FutureOr<bool> Function() isMaximized;
  final bool showMinimizeButton;
  final bool showMaximizeButton;
  final bool showCloseButton;
  const PlatformWindowButtonConfig({
    Key? key,
    required this.onClose,
    required this.onMinimize,
    required this.onMaximize,
    required this.onRestore,
    required this.isMaximized,
    this.showMinimizeButton = true,
    this.showMaximizeButton = true,
    this.showCloseButton = true,
  });

  static PlatformWindowButtonConfig? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
            PlatformWindowButtonConfigProvider>()
        ?.config;
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlatformWindowButtonConfig) return false;
    return onClose == other.onClose &&
        onMinimize == other.onMinimize &&
        onMaximize == other.onMaximize &&
        onMaximize == other.onRestore &&
        isMaximized == other.isMaximized;
  }

  @override
  int get hashCode =>
      Object.hash(onClose, onMinimize, onMaximize, onRestore, isMaximized);
}

class PlatformWindowButtonConfigProvider extends InheritedWidget {
  final PlatformWindowButtonConfig config;

  const PlatformWindowButtonConfigProvider({
    Key? key,
    required this.config,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(PlatformWindowButtonConfigProvider oldWidget) {
    return oldWidget.config != config;
  }
}

class PlatformWindowButtons extends StatefulWidget
    implements PreferredSizeWidget {
  final VoidCallback? onClose;
  final VoidCallback? onMinimize;
  final VoidCallback? onMaximize;
  final VoidCallback? onRestore;
  final FutureOr<bool> Function()? isMaximized;
  final bool? showMinimizeButton;
  final bool? showMaximizeButton;
  final bool? showCloseButton;
  const PlatformWindowButtons({
    Key? key,
    this.onClose,
    this.onMinimize,
    this.onMaximize,
    this.onRestore,
    this.isMaximized,
    this.showMinimizeButton,
    this.showMaximizeButton,
    this.showCloseButton,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(110, 30);

  @override
  State<PlatformWindowButtons> createState() => _PlatformWindowButtonsState();
}

class _PlatformWindowButtonsState extends State<PlatformWindowButtons>
    with PlatformMixin<Widget> {
  bool showCloseButton(BuildContext context) {
    final config = PlatformWindowButtonConfig.of(context);
    return widget.showCloseButton ?? config!.showCloseButton;
  }

  bool showMinimizeButton(BuildContext context) {
    final config = PlatformWindowButtonConfig.of(context);
    return widget.showMinimizeButton ?? config!.showMinimizeButton;
  }

  bool showMaximizeButton(BuildContext context) {
    final config = PlatformWindowButtonConfig.of(context);
    return widget.showMaximizeButton ?? config!.showMaximizeButton;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (PlatformWindowButtonConfig.of(context) == null &&
          widget.isMaximized == null &&
          widget.onClose == null &&
          widget.onMinimize == null &&
          widget.onMaximize == null &&
          widget.onRestore == null) {
        debugPrintStack(
          label:
              "[PlatformWindowButtons] needs either [PlatformWindowButtonConfig] or individual callbacks to work. Use [PlatformApp]'s windowButtonConfig property to set the config.",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.preferredSize.height,
      child: getPlatformType(context),
    );
  }

  FutureOr<bool> isMaximized(BuildContext context) {
    final config = PlatformWindowButtonConfig.of(context);
    return (widget.isMaximized?.call() ?? config?.isMaximized()) == true;
  }

  @override
  Widget android(BuildContext context) {
    return linux(context);
  }

  @override
  Widget ios(BuildContext context) {
    return macos(context);
  }

  @override
  Widget linux(BuildContext context) {
    final config = PlatformWindowButtonConfig.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showMinimizeButton(context))
          AdwWindowButton(
            buttonType: WindowButtonType.minimize,
            onPressed: widget.onMinimize ?? config?.onMinimize,
          ),
        if (showMaximizeButton(context))
          FutureBuilder<bool>(
              future: Future.value(isMaximized(context)),
              builder: (context, snapshot) {
                return AdwWindowButton(
                  buttonType: WindowButtonType.maximize,
                  onPressed: snapshot.data ?? false
                      ? widget.onRestore ?? config?.onRestore
                      : widget.onMaximize ?? config?.onMaximize,
                );
              }),
        if (showCloseButton(context))
          AdwWindowButton(
            buttonType: WindowButtonType.close,
            onPressed: widget.onClose ?? config?.onClose,
          ),
        const SizedBox(width: 4),
      ],
    );
  }

  @override
  Widget macos(BuildContext context) {
    final config = PlatformWindowButtonConfig.of(context);
    final decoration = BoxDecoration(
      color: Colors.red[400],
      borderRadius: BorderRadius.circular(18),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showCloseButton(context))
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureBuilder(
              onTap: widget.onClose ?? config?.onClose,
              builder: (context, states) {
                return Container(
                  height: 18,
                  width: 18,
                  decoration: states.isPressing
                      ? decoration.copyWith(
                          color: Colors.red[800],
                        )
                      : decoration,
                );
              },
            ),
          ),
        const SizedBox(width: 4),
        if (showMinimizeButton(context))
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureBuilder(
              onTap: widget.onMinimize ?? config?.onMinimize,
              builder: (context, states) {
                return Container(
                  height: 18,
                  width: 18,
                  decoration: decoration.copyWith(
                    color: states.isPressing
                        ? Colors.orange[400]
                        : Colors.orange[200],
                  ),
                );
              },
            ),
          ),
        const SizedBox(width: 4),
        if (showMaximizeButton(context))
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: FutureBuilder(
                future: Future.value(isMaximized(context)),
                builder: (context, snapshot) {
                  return GestureBuilder(
                    onTap: snapshot.data ?? false
                        ? widget.onRestore ?? config?.onRestore
                        : widget.onMaximize ?? config?.onMaximize,
                    builder: (context, states) {
                      return Container(
                        height: 18,
                        width: 18,
                        decoration: decoration.copyWith(
                          color: states.isPressing
                              ? Colors.green[800]
                              : Colors.green[400],
                        ),
                      );
                    },
                  );
                }),
          ),
      ],
    );
  }

  @override
  Widget windows(BuildContext context) {
    final buttonStyle = FluentUI.ButtonStyle(
      backgroundColor: FluentUI.ButtonState.resolveWith(
        (states) {
          if (states.contains(FluentUI.ButtonStates.focused) ||
              states.contains(FluentUI.ButtonStates.focused)) {
            return Colors.black26;
          } else if (states.contains(FluentUI.ButtonStates.hovering)) {
            return Colors.black12;
          }
          return Colors.transparent;
        },
      ),
      shape: FluentUI.ButtonState.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      border: FluentUI.ButtonState.all(BorderSide.none),
    );
    final config = PlatformWindowButtonConfig.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showMinimizeButton(context))
          FluentUI.Button(
            style: buttonStyle,
            onPressed: widget.onMinimize ?? config?.onMinimize,
            child:
                MinimizeIcon(color: PlatformTextTheme.of(context).body!.color!),
          ),
        if (showMaximizeButton(context))
          FutureBuilder(
              future: Future.value(isMaximized(context)),
              builder: (context, snapshot) {
                return FluentUI.Button(
                  style: buttonStyle,
                  onPressed: snapshot.data ?? false
                      ? widget.onRestore ?? config?.onRestore
                      : widget.onMaximize ?? config?.onMaximize,
                  child: snapshot.data ?? false
                      ? RestoreIcon(
                          color: PlatformTextTheme.of(context).body!.color!)
                      : MaximizeIcon(
                          color: PlatformTextTheme.of(context).body!.color!),
                );
              }),
        if (showCloseButton(context))
          FluentUI.Button(
            style: buttonStyle.copyWith(
              backgroundColor: FluentUI.ButtonState.resolveWith(
                (states) {
                  if (states.contains(FluentUI.ButtonStates.hovering)) {
                    return Colors.red;
                  }
                  return Colors.transparent;
                },
              ),
            ),
            onPressed: widget.onClose ?? config?.onClose,
            child: CloseIcon(
              color: PlatformTextTheme.of(context).body!.color!,
            ),
          ),
      ],
    );
  }
}
