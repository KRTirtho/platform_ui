import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:popover_gtk/popover_gtk.dart';

class GtkDropdownItem<T> extends StatelessWidget {
  final Widget child;
  final void Function(T)? onTap;
  final T value;
  const GtkDropdownItem({
    Key? key,
    required this.child,
    required this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdwButton.flat(
      onPressed: () => onTap?.call(value),
      padding: AdwButton.defaultButtonPadding.copyWith(
        top: 10,
        bottom: 10,
      ),
      child: child,
    );
  }
}

class GtkDropdownMenu<T> extends StatefulWidget {
  const GtkDropdownMenu({
    Key? key,
    required this.items,
    this.value,
    this.popupWidth = 200,
    this.popupHeight,
    this.onTap,
    this.dropdownColor,
    this.hint,
    this.hintStyle,
  }) : super(key: key);
  final VoidCallback? onTap;

  /// The body of the popup
  final List<GtkDropdownItem> items;

  /// The width of the popup
  final double popupWidth;

  /// The height of the popup
  final double? popupHeight;
  final T? value;
  final Color? dropdownColor;
  final Widget? hint;
  final TextStyle? hintStyle;

  @override
  State<GtkDropdownMenu> createState() => _GtkDropdownMenuState();
}

class _GtkDropdownMenuState extends State<GtkDropdownMenu> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return AdwButton.flat(
      isActive: isActive,
      onPressed: () {
        setState(() => isActive = true);
        showPopover(
          context: context,
          arrowHeight: 14,
          shadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.2),
              blurRadius: 6,
            ),
          ],
          barrierColor: Colors.transparent,
          bodyBuilder: (_) => Padding(
            padding: const EdgeInsets.all(4),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (context, i) {
                return widget.items[i];
              },
            ),
          ),
          width: widget.popupWidth,
          height: widget.popupHeight,
          backgroundColor: widget.dropdownColor ?? Theme.of(context).cardColor,
        ).whenComplete(() => setState(() => isActive = false));
        widget.onTap?.call();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.value != null)
            widget
                .items[widget.items
                    .map((e) => e.value)
                    .toList()
                    .indexOf(widget.value)]
                .child
          else
            DefaultTextStyle(
              style: widget.hintStyle ??
                  PlatformTheme.of(context).textTheme!.caption!,
              child: widget.hint ?? const SizedBox.shrink(),
            ),
          const Icon(
            Icons.arrow_drop_down_rounded,
            size: 27,
          ),
        ],
      ),
    );
  }
}
