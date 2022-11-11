import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class GestureStates {
  bool isPressing = false;
  bool isHovering = false;
  bool isFocused = false;
}

class GestureBuilder extends StatefulWidget {
  final VoidCallback? onTap;
  final ValueChanged<PointerHoverEvent>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final Widget Function(BuildContext context, GestureStates states) builder;
  const GestureBuilder({
    Key? key,
    required this.builder,
    this.onTap,
    this.onHover,
    this.onFocusChange,
  }) : super(key: key);

  @override
  State<GestureBuilder> createState() => _GestureBuilderState();
}

class _GestureBuilderState extends State<GestureBuilder> {
  final states = GestureStates();

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        setState(() {
          states.isFocused = value;
        });
        widget.onFocusChange?.call(value);
      },
      child: MouseRegion(
        onHover: widget.onHover,
        onEnter: (event) {
          setState(() {
            states.isHovering = true;
          });
        },
        onExit: (event) {
          setState(() {
            states.isHovering = false;
          });
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: widget.onTap,
          onTapDown: (_) {
            setState(() {
              states.isPressing = true;
            });
          },
          onTapCancel: () {
            setState(() {
              states.isPressing = false;
            });
          },
          onTapUp: (details) {
            setState(() {
              states.isPressing = false;
            });
          },
          child: widget.builder(context, states),
        ),
      ),
    );
  }
}
