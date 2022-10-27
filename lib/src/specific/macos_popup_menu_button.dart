import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:macos_ui/macos_ui.dart';

const Duration _kMenuDuration = Duration(milliseconds: 300);
const double _kMenuItemHeight = 20.0;
const EdgeInsets _kMenuItemPadding = EdgeInsets.symmetric(horizontal: 6.0);
const BorderRadius _kBorderRadius = BorderRadius.all(Radius.circular(5.0));
const double _kMenuLeftOffset = 8.0;

class _MacosPulldownMenuItemButton extends StatefulWidget {
  const _MacosPulldownMenuItemButton({
    Key? key,
    this.padding,
    required this.route,
    required this.buttonRect,
    required this.constraints,
    required this.itemIndex,
  }) : super(key: key);

  final _MacosPulldownRoute route;
  final EdgeInsets? padding;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final int itemIndex;

  @override
  _MacosPulldownMenuItemButtonState createState() =>
      _MacosPulldownMenuItemButtonState();
}

class _MacosPulldownMenuItemButtonState
    extends State<_MacosPulldownMenuItemButton> {
  bool _isHovered = false;

  void _handleFocusChange(bool focused) {
    setState(() {
      if (focused) {
        _isHovered = true;
      } else {
        _isHovered = false;
      }
    });
  }

  void _handleOnTap() {
    final MacosPulldownMenuEntry menuEntity =
        widget.route.items[widget.itemIndex].item!;
    if (menuEntity is MacosPulldownMenuItem) {
      menuEntity.onTap?.call();
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final MacosThemeData theme = MacosTheme.of(context);
    final brightness = MacosTheme.brightnessOf(context);
    final MacosPulldownMenuEntry menuEntity =
        widget.route.items[widget.itemIndex].item!;
    if (menuEntity is MacosPulldownMenuItem) {
      Widget child = Container(
        padding: widget.padding,
        height: widget.route.itemHeight,
        child: widget.route.items[widget.itemIndex],
      );
      if (menuEntity.enabled) {
        child = MouseRegion(
          cursor: SystemMouseCursors.basic,
          onEnter: (_) {
            setState(() => _isHovered = true);
          },
          onExit: (_) {
            setState(() => _isHovered = false);
          },
          child: GestureDetector(
            onTap: _handleOnTap,
            child: Focus(
              onKey: (FocusNode node, RawKeyEvent event) {
                if (event.logicalKey == LogicalKeyboardKey.enter) {
                  _handleOnTap();
                  return KeyEventResult.handled;
                }
                return KeyEventResult.ignored;
              },
              onFocusChange: _handleFocusChange,
              child: Container(
                decoration: BoxDecoration(
                  color: _isHovered
                      ? MacosPulldownButtonTheme.of(context).highlightColor
                      : Colors.transparent,
                  borderRadius: _kBorderRadius,
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 13.0,
                    color: _isHovered
                        ? MacosColors.white
                        : brightness.resolve(
                            MacosColors.black,
                            MacosColors.white,
                          ),
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        );
      } else {
        final textColor = brightness.resolve(
          MacosColors.disabledControlTextColor,
          MacosColors.disabledControlTextColor.darkColor,
        );
        child = DefaultTextStyle(
          style: theme.typography.body.copyWith(color: textColor),
          child: child,
        );
      }
      return child;
    } else {
      return menuEntity;
    }
  }
}

class _MacosPulldownMenu extends StatefulWidget {
  const _MacosPulldownMenu({
    Key? key,
    this.padding,
    required this.route,
    required this.buttonRect,
    required this.constraints,
  }) : super(key: key);

  final _MacosPulldownRoute route;
  final EdgeInsets? padding;
  final Rect buttonRect;
  final BoxConstraints constraints;

  @override
  _MacosPulldownMenuState createState() => _MacosPulldownMenuState();
}

class _MacosPulldownMenuState extends State<_MacosPulldownMenu> {
  late CurvedAnimation _fadeOpacity;

  @override
  void initState() {
    super.initState();

    _fadeOpacity = CurvedAnimation(
      parent: widget.route.animation!,
      curve: const Interval(0.0, 0.25),
      reverseCurve: const Interval(0.75, 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _MacosPulldownRoute route = widget.route;
    final List<Widget> children = <Widget>[
      for (int itemIndex = 0; itemIndex < route.items.length; ++itemIndex)
        _MacosPulldownMenuItemButton(
          route: widget.route,
          padding: widget.padding,
          buttonRect: widget.buttonRect,
          constraints: widget.constraints,
          itemIndex: itemIndex,
        ),
    ];

    return FadeTransition(
      opacity: _fadeOpacity,
      child: Semantics(
        scopesRoute: true,
        namesRoute: true,
        explicitChildNodes: true,
        child: IntrinsicWidth(
          child: MacosOverlayFilter(
            color: MacosPulldownButtonTheme.of(context)
                .pulldownColor
                ?.withOpacity(0.25),
            borderRadius: _kBorderRadius,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MacosPulldownMenuRouteLayout extends SingleChildLayoutDelegate {
  _MacosPulldownMenuRouteLayout({
    required this.buttonRect,
    required this.route,
    required this.textDirection,
    required this.menuAlignment,
  });

  final Rect buttonRect;
  final _MacosPulldownRoute route;
  final TextDirection? textDirection;
  final PulldownMenuAlignment menuAlignment;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: kMinInteractiveDimension,
      maxWidth: constraints.maxWidth,
      maxHeight: constraints.maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final _MenuLimits menuLimits = route.getMenuLimits(buttonRect, size.height);

    assert(() {
      final Rect container = Offset.zero & size;
      if (container.intersect(buttonRect) == buttonRect) {
        assert(menuLimits.top >= 0.0);
        assert(menuLimits.top + menuLimits.height <= size.height);
      }
      return true;
    }());
    assert(textDirection != null);
    double left;
    switch (menuAlignment) {
      case PulldownMenuAlignment.left:
        switch (textDirection!) {
          case TextDirection.rtl:
            left = buttonRect.right.clamp(0.0, size.width) - childSize.width;
            break;
          case TextDirection.ltr:
            left = buttonRect.left + _kMenuLeftOffset;
            break;
        }
        break;
      case PulldownMenuAlignment.right:
        switch (textDirection!) {
          case TextDirection.rtl:
            left = buttonRect.left + _kMenuLeftOffset;
            break;
          case TextDirection.ltr:
            left = buttonRect.left - childSize.width + buttonRect.width;
            break;
        }
        break;
    }
    if (left + childSize.width >= size.width) {
      left = left.clamp(0.0, size.width - childSize.width) - _kMenuLeftOffset;
    }
    return Offset(left, menuLimits.top);
  }

  @override
  bool shouldRelayout(_MacosPulldownMenuRouteLayout oldDelegate) {
    return buttonRect != oldDelegate.buttonRect ||
        textDirection != oldDelegate.textDirection;
  }
}

class _MenuLimits {
  const _MenuLimits(
    this.top,
    this.bottom,
    this.height,
  );
  final double top;
  final double bottom;
  final double height;
}

class _MacosPulldownRoute extends PopupRoute {
  _MacosPulldownRoute({
    required this.items,
    required this.padding,
    required this.buttonRect,
    required this.capturedThemes,
    required this.style,
    required this.constraints,
    this.barrierLabel,
    this.itemHeight,
    required this.menuAlignment,
  }) : itemHeights = List<double>.filled(
          items.length,
          itemHeight ?? _kMenuItemHeight,
        );

  final List<_MenuItem> items;
  final EdgeInsetsGeometry padding;
  final Rect buttonRect;
  final CapturedThemes capturedThemes;
  final TextStyle style;
  final double? itemHeight;
  final PulldownMenuAlignment menuAlignment;
  final List<double> itemHeights;
  final BoxConstraints constraints;

  @override
  Duration get transitionDuration => _kMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String? barrierLabel;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return _MacosPulldownRoutePage(
      route: this,
      constraints: constraints,
      items: items,
      padding: padding,
      buttonRect: buttonRect,
      capturedThemes: capturedThemes,
      style: style,
      menuAlignment: menuAlignment,
    );
  }

  void _dismiss() {
    if (isActive) {
      navigator?.removeRoute(this);
    }
  }

  _MenuLimits getMenuLimits(
    Rect buttonRect,
    double availableHeight,
  ) {
    double computedMaxHeight = availableHeight - 2.0 * _kMenuItemHeight;

    final double buttonTop = buttonRect.top;
    final double buttonBottom = math.min(buttonRect.bottom, availableHeight);

    final double bottomLimit =
        math.max(availableHeight - _kMenuItemHeight, buttonBottom);

    double menuTop = buttonTop + buttonRect.height;
    double preferredMenuHeight = 8.0;
    if (items.isNotEmpty) {
      preferredMenuHeight +=
          itemHeights.reduce((double total, double height) => total + height);
    }

    final double menuHeight = math.min(computedMaxHeight, preferredMenuHeight);
    double menuBottom = menuTop + menuHeight;

    if (menuBottom > bottomLimit) {
      menuBottom = buttonTop - 5.0;
      menuTop = buttonTop - menuHeight - 5.0;
    } else {
      menuBottom += 1.0;
      menuTop += 1.0;
    }

    assert((menuBottom - menuTop - menuHeight).abs() < precisionErrorTolerance);
    return _MenuLimits(
      menuTop,
      menuBottom,
      menuHeight,
    );
  }
}

class _MacosPulldownRoutePage extends StatelessWidget {
  const _MacosPulldownRoutePage({
    Key? key,
    required this.route,
    required this.constraints,
    this.items,
    required this.padding,
    required this.buttonRect,
    required this.capturedThemes,
    this.style,
    required this.menuAlignment,
  }) : super(key: key);

  final _MacosPulldownRoute route;
  final BoxConstraints constraints;
  final List<_MenuItem>? items;
  final EdgeInsetsGeometry padding;
  final Rect buttonRect;
  final CapturedThemes capturedThemes;
  final TextStyle? style;
  final PulldownMenuAlignment menuAlignment;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));

    final TextDirection? textDirection = Directionality.maybeOf(context);
    final Widget menu = _MacosPulldownMenu(
      route: route,
      padding: padding.resolve(textDirection),
      buttonRect: buttonRect,
      constraints: constraints,
    );

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _MacosPulldownMenuRouteLayout(
              buttonRect: buttonRect,
              route: route,
              textDirection: textDirection,
              menuAlignment: menuAlignment,
            ),
            child: capturedThemes.wrap(menu),
          );
        },
      ),
    );
  }
}

class _MenuItem extends SingleChildRenderObjectWidget {
  const _MenuItem({
    Key? key,
    required this.onLayout,
    this.item,
  }) : super(key: key, child: item);

  final ValueChanged<Size> onLayout;

  final MacosPulldownMenuEntry? item;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMenuItem(onLayout);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderMenuItem renderObject,
  ) {
    renderObject.onLayout = onLayout;
  }
}

class _RenderMenuItem extends RenderProxyBox {
  _RenderMenuItem(this.onLayout, [RenderBox? child]) : super(child);

  ValueChanged<Size> onLayout;

  @override
  void performLayout() {
    super.performLayout();
    onLayout(size);
  }
}

class MacosPulldownButton extends StatefulWidget {
  const MacosPulldownButton({
    super.key,
    required this.items,
    required this.child,
    this.onTap,
    this.onCancelled,
    this.constraints,
    this.style,
    this.itemHeight = _kMenuItemHeight,
    this.focusNode,
    this.autofocus = false,
    this.alignment = AlignmentDirectional.centerStart,
    this.menuAlignment = PulldownMenuAlignment.left,
  }) : assert(itemHeight == null || itemHeight >= _kMenuItemHeight);

  final List<MacosPulldownMenuEntry>? items;

  final Widget child;

  final VoidCallback? onTap;

  final TextStyle? style;

  final double? itemHeight;

  final FocusNode? focusNode;

  final bool autofocus;

  final AlignmentGeometry alignment;

  final PulldownMenuAlignment menuAlignment;

  final BoxConstraints? constraints;

  final VoidCallback? onCancelled;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty(
      'itemHeight',
      itemHeight,
    ));
    properties.add(
      FlagProperty('hasAutofocus', value: autofocus, ifFalse: 'noAutofocus'),
    );
    properties.add(DiagnosticsProperty('alignment', alignment));
    properties.add(DiagnosticsProperty('menuAlignment', menuAlignment));
  }

  @override
  State<MacosPulldownButton> createState() => _MacosPulldownButtonState();
}

class _MacosPulldownButtonState extends State<MacosPulldownButton>
    with WidgetsBindingObserver {
  _MacosPulldownRoute? _pulldownRoute;
  FocusNode? _internalNode;
  FocusNode? get focusNode => widget.focusNode ?? _internalNode;
  bool _hasPrimaryFocus = false;
  late Map<Type, Action<Intent>> _actionMap;
  late FocusHighlightMode _focusHighlightMode;
  PulldownButtonState _pullDownButtonState = PulldownButtonState.enabled;

  FocusNode _createFocusNode() {
    return FocusNode(debugLabel: '${widget.runtimeType}');
  }

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _internalNode ??= _createFocusNode();
    }
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (ActivateIntent intent) => _handleTap(),
      ),
      ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
        onInvoke: (ButtonActivateIntent intent) => _handleTap(),
      ),
    };
    focusNode!.addListener(_handleFocusChanged);
    final FocusManager focusManager = WidgetsBinding.instance.focusManager;
    _focusHighlightMode = focusManager.highlightMode;
    focusManager.addHighlightModeListener(_handleFocusHighlightModeChange);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _removeMacosPulldownRoute();
    WidgetsBinding.instance.focusManager
        .removeHighlightModeListener(_handleFocusHighlightModeChange);
    focusNode!.removeListener(_handleFocusChanged);
    _internalNode?.dispose();
    super.dispose();
  }

  void _removeMacosPulldownRoute() {
    _pulldownRoute?._dismiss();
    _pulldownRoute = null;
  }

  void _handleFocusChanged() {
    if (_hasPrimaryFocus != focusNode!.hasPrimaryFocus) {
      setState(() => _hasPrimaryFocus = focusNode!.hasPrimaryFocus);
    }
  }

  void _handleFocusHighlightModeChange(FocusHighlightMode mode) {
    if (!mounted) {
      return;
    }
    setState(() => _focusHighlightMode = mode);
  }

  @override
  void didUpdateWidget(MacosPulldownButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChanged);
      if (widget.focusNode == null) {
        _internalNode ??= _createFocusNode();
      }
      _hasPrimaryFocus = focusNode!.hasPrimaryFocus;
      focusNode!.addListener(_handleFocusChanged);
    }
  }

  TextStyle? get _textStyle =>
      widget.style ?? MacosTheme.of(context).typography.body;

  void _handleTap() {
    final TextDirection? textDirection = Directionality.maybeOf(context);
    const EdgeInsetsGeometry menuMargin =
        EdgeInsetsDirectional.only(start: 4.0, end: 4.0);

    final List<_MenuItem> menuItems = <_MenuItem>[
      for (int index = 0; index < widget.items!.length; index += 1)
        _MenuItem(
          item: widget.items![index],
          onLayout: (Size size) {
            if (_pulldownRoute == null) return;

            _pulldownRoute!.itemHeights[index] = size.height;
          },
        ),
    ];

    setState(() => _pullDownButtonState = PulldownButtonState.pressed);

    final NavigatorState navigator = Navigator.of(context);
    assert(_pulldownRoute == null);
    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(
          Offset.zero,
          ancestor: navigator.context.findRenderObject(),
        ) &
        itemBox.size;
    _pulldownRoute = _MacosPulldownRoute(
      constraints: widget.constraints ?? const BoxConstraints(),
      items: menuItems,
      buttonRect: menuMargin.resolve(textDirection).inflateRect(itemRect),
      padding: _kMenuItemPadding.resolve(textDirection),
      capturedThemes:
          InheritedTheme.capture(from: context, to: navigator.context),
      style: _textStyle!,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      itemHeight: widget.itemHeight,
      menuAlignment: widget.menuAlignment,
    );

    navigator.push(_pulldownRoute!).then<bool?>((result) {
      setState(() => _pullDownButtonState = PulldownButtonState.enabled);
      _removeMacosPulldownRoute();
      if (result != true) widget.onCancelled?.call();
      if (!mounted) return;
      return null;
    });

    widget.onTap?.call();
  }

  bool get _enabled => widget.items != null && widget.items!.isNotEmpty;

  bool get _showHighlight {
    switch (_focusHighlightMode) {
      case FocusHighlightMode.touch:
        return false;
      case FocusHighlightMode.traditional:
        return _hasPrimaryFocus;
    }
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(7.0));
    final buttonStyles =
        _getButtonStyles(_pullDownButtonState, _enabled, context);

    Widget result = Container(
      decoration: _showHighlight
          ? const BoxDecoration(
              color: MacosColors.findHighlightColor,
              borderRadius: borderRadius,
            )
          : BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: buttonStyles.borderColor,
                  offset: const Offset(0, .5),
                  blurRadius: 0.2,
                  spreadRadius: 0,
                ),
              ],
              border: Border.all(width: 0.5, color: buttonStyles.borderColor),
              color: buttonStyles.bgColor,
              borderRadius: borderRadius,
            ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: IconTheme(
        data: IconTheme.of(context).copyWith(color: buttonStyles.textColor),
        child: widget.child,
      ),
    );

    return Semantics(
      button: true,
      child: Actions(
        actions: _actionMap,
        child: Focus(
          canRequestFocus: _enabled,
          focusNode: focusNode,
          autofocus: widget.autofocus,
          child: MouseRegion(
            cursor: SystemMouseCursors.basic,
            onEnter: (_) => setState(
              () => _pullDownButtonState = PulldownButtonState.hovered,
            ),
            onExit: (_) {
              setState(() {
                if (_pullDownButtonState == PulldownButtonState.hovered) {
                  _pullDownButtonState = PulldownButtonState.enabled;
                }
              });
            },
            child: GestureDetector(
              onTap: _enabled ? _handleTap : null,
              behavior: HitTestBehavior.opaque,
              child: result,
            ),
          ),
        ),
      ),
    );
  }
}

_ButtonStyles _getButtonStyles(
  PulldownButtonState pullDownButtonState,
  bool enabled,
  BuildContext context,
) {
  final theme = MacosTheme.of(context);
  final brightness = theme.brightness;
  final pulldownTheme = MacosPulldownButtonTheme.of(context);
  Color textColor = theme.typography.body.color!;
  Color bgColor = pulldownTheme.backgroundColor!;
  Color borderColor = brightness.resolve(
    const Color(0xffc3c4c9),
    const Color(0xff222222),
  );
  Color iconColor = pulldownTheme.iconColor!;
  if (!enabled) {
    textColor = brightness.resolve(
      const Color.fromRGBO(0, 0, 0, 0.3),
      const Color.fromRGBO(255, 255, 255, 0.3),
    );
    bgColor = borderColor = MacosColors.transparent;
  } else {
    borderColor = MacosColors.transparent;
    switch (pullDownButtonState) {
      case PulldownButtonState.enabled:
        textColor = iconColor;
        bgColor = MacosColors.transparent;
        break;
      case PulldownButtonState.hovered:
        textColor = iconColor;
        bgColor = brightness.resolve(
          const Color(0xfff4f5f5),
          const Color(0xff323232),
        );
        break;
      case PulldownButtonState.pressed:
        textColor = iconColor.withOpacity(0.85);
        bgColor = brightness.resolve(
          const Color.fromRGBO(0, 0, 0, 0.1),
          const Color.fromRGBO(255, 255, 255, 0.1),
        );
        break;
    }
  }
  return _ButtonStyles(
    textColor: textColor,
    bgColor: bgColor,
    borderColor: borderColor,
  );
}

class _ButtonStyles {
  _ButtonStyles({
    required this.textColor,
    required this.bgColor,
    required this.borderColor,
  });

  Color textColor;
  Color bgColor;
  Color borderColor;
}
