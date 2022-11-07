import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:platform_ui/src/specific/linux_window_button.dart';
import 'package:platform_ui/src/specific/windows_title_bar_icons.dart';
import 'package:platform_ui/src/tools/gesture_builder.dart';

class PlatformWindowButtons extends StatelessWidget
    with PlatformMixin<Widget>
    implements PreferredSizeWidget {
  final VoidCallback onClose;
  final VoidCallback onMinimize;
  final VoidCallback onMaximize;
  final bool isMaximized;
  const PlatformWindowButtons({
    Key? key,
    required this.onClose,
    required this.onMinimize,
    required this.onMaximize,
    required this.isMaximized,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: getPlatformType(context),
    );
  }

  @override
  Size get preferredSize => const Size(110, 30);

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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AdwWindowButton(
          buttonType: WindowButtonType.minimize,
          onPressed: onMinimize,
        ),
        AdwWindowButton(
          buttonType: WindowButtonType.maximize,
          onPressed: onMaximize,
        ),
        AdwWindowButton(
          buttonType: WindowButtonType.close,
          onPressed: onClose,
        ),
      ],
    );
  }

  @override
  Widget macos(BuildContext context) {
    final decoration = BoxDecoration(
      color: Colors.red[400],
      borderRadius: BorderRadius.circular(18),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureBuilder(
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
        const SizedBox(width: 4),
        GestureBuilder(builder: (context, states) {
          return Container(
            height: 18,
            width: 18,
            decoration: decoration.copyWith(
              color:
                  states.isPressing ? Colors.orange[400] : Colors.orange[200],
            ),
          );
        }),
        const SizedBox(width: 4),
        GestureBuilder(builder: (context, states) {
          return Container(
            height: 18,
            width: 18,
            decoration: decoration.copyWith(
              color: states.isPressing ? Colors.green[800] : Colors.green[400],
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget windows(BuildContext context) {
    var buttonStyle = FluentUI.ButtonStyle(
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FluentUI.Button(
          style: buttonStyle,
          onPressed: onMinimize,
          child:
              MinimizeIcon(color: PlatformTextTheme.of(context).body!.color!),
        ),
        FluentUI.Button(
          style: buttonStyle,
          onPressed: onMaximize,
          child: isMaximized
              ? RestoreIcon(color: PlatformTextTheme.of(context).body!.color!)
              : MaximizeIcon(color: PlatformTextTheme.of(context).body!.color!),
        ),
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
          onPressed: onMinimize,
          child: CloseIcon(color: PlatformTextTheme.of(context).body!.color!),
        ),
      ],
    );
  }
}
