// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'list_tile.dart';
import 'material_state.dart';
import 'theme.dart';
import 'theme_data.dart';

// Examples can assume:
// late BuildContext context;

/// Used with [ListTileTheme] to define default property values for
/// descendant [ListTile] widgets, as well as classes that build
/// [ListTile]s, like [CheckboxListTile], [RadioListTile], and
/// [SwitchListTile].
///
/// Descendant widgets obtain the current [ListTileThemeData] object
/// using `ListTileTheme.of(context)`. Instances of
/// [ListTileThemeData] can be customized with
/// [ListTileThemeData.copyWith].
///
/// A [ListTileThemeData] is often specified as part of the
/// overall [Theme] with [ThemeData.listTileTheme].
///
/// All [ListTileThemeData] properties are `null` by default.
/// When a theme property is null, the [ListTile] will provide its own
/// default based on the overall [Theme]'s textTheme and
/// colorScheme. See the individual [ListTile] properties for details.
///
/// The [Drawer] widget specifies a list tile theme for its children that
/// defines [style] to be [ListTileStyle.drawer].
///
/// See also:
///
///  * [ThemeData], which describes the overall theme information for the
///    application.
@immutable
class ListTileThemeData with Diagnosticable {
  /// Creates a [ListTileThemeData].
  const ListTileThemeData ({
    this.dense,
    this.shape,
    this.style,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.contentPadding,
    this.tileColor,
    this.selectedTileColor,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.enableFeedback,
    this.mouseCursor,
    this.visualDensity,
  });

  /// Overrides the default value of [ListTile.dense].
  final bool? dense;

  /// Overrides the default value of [ListTile.shape].
  final ShapeBorder? shape;

  /// Overrides the default value of [ListTile.style].
  final ListTileStyle? style;

  /// Overrides the default value of [ListTile.selectedColor].
  final Color? selectedColor;

  /// Overrides the default value of [ListTile.iconColor].
  final Color? iconColor;

  /// Overrides the default value of [ListTile.textColor].
  final Color? textColor;

  /// Overrides the default value of [ListTile.contentPadding].
  final EdgeInsetsGeometry? contentPadding;

  /// Overrides the default value of [ListTile.tileColor].
  final Color? tileColor;

  /// Overrides the default value of [ListTile.selectedTileColor].
  final Color? selectedTileColor;

  /// Overrides the default value of [ListTile.horizontalTitleGap].
  final double? horizontalTitleGap;

  /// Overrides the default value of [ListTile.minVerticalPadding].
  final double? minVerticalPadding;

  /// Overrides the default value of [ListTile.minLeadingWidth].
  final double? minLeadingWidth;

  /// Overrides the default value of [ListTile.enableFeedback].
  final bool? enableFeedback;

  /// If specified, overrides the default value of [ListTile.mouseCursor].
  final MaterialStateProperty<MouseCursor?>? mouseCursor;

  /// If specified, overrides the default value of [ListTile.visualDensity].
  final VisualDensity? visualDensity;

  /// Creates a copy of this object with the given fields replaced with the
  /// new values.
  ListTileThemeData copyWith({
    bool? dense,
    ShapeBorder? shape,
    ListTileStyle? style,
    Color? selectedColor,
    Color? iconColor,
    Color? textColor,
    EdgeInsetsGeometry? contentPadding,
    Color? tileColor,
    Color? selectedTileColor,
    double? horizontalTitleGap,
    double? minVerticalPadding,
    double? minLeadingWidth,
    bool? enableFeedback,
    MaterialStateProperty<MouseCursor?>? mouseCursor,
    bool? isThreeLine,
    VisualDensity? visualDensity,
  }) {
    return ListTileThemeData(
      dense: dense ?? this.dense,
      shape: shape ?? this.shape,
      style: style ?? this.style,
      selectedColor: selectedColor ?? this.selectedColor,
      iconColor: iconColor ?? this.iconColor,
      textColor: textColor ?? this.textColor,
      contentPadding: contentPadding ?? this.contentPadding,
      tileColor: tileColor ?? this.tileColor,
      selectedTileColor: selectedTileColor ?? this.selectedTileColor,
      horizontalTitleGap: horizontalTitleGap ?? this.horizontalTitleGap,
      minVerticalPadding: minVerticalPadding ?? this.minVerticalPadding,
      minLeadingWidth: minLeadingWidth ?? this.minLeadingWidth,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      visualDensity: visualDensity ?? this.visualDensity,
    );
  }

  /// Linearly interpolate between ListTileThemeData objects.
  static ListTileThemeData? lerp(ListTileThemeData? a, ListTileThemeData? b, double t) {
    assert (t != null);
    if (a == null && b == null) {
      return null;
    }
    return ListTileThemeData(
      dense: t < 0.5 ? a?.dense : b?.dense,
      shape: ShapeBorder.lerp(a?.shape, b?.shape, t),
      style: t < 0.5 ? a?.style : b?.style,
      selectedColor: Color.lerp(a?.selectedColor, b?.selectedColor, t),
      iconColor: Color.lerp(a?.iconColor, b?.iconColor, t),
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      contentPadding: EdgeInsetsGeometry.lerp(a?.contentPadding, b?.contentPadding, t),
      tileColor: Color.lerp(a?.tileColor, b?.tileColor, t),
      selectedTileColor: Color.lerp(a?.selectedTileColor, b?.selectedTileColor, t),
      horizontalTitleGap: lerpDouble(a?.horizontalTitleGap, b?.horizontalTitleGap, t),
      minVerticalPadding: lerpDouble(a?.minVerticalPadding, b?.minVerticalPadding, t),
      minLeadingWidth: lerpDouble(a?.minLeadingWidth, b?.minLeadingWidth, t),
      enableFeedback: t < 0.5 ? a?.enableFeedback : b?.enableFeedback,
      mouseCursor: t < 0.5 ? a?.mouseCursor : b?.mouseCursor,
      visualDensity: t < 0.5 ? a?.visualDensity : b?.visualDensity,
    );
  }

  @override
  int get hashCode => Object.hash(
    dense,
    shape,
    style,
    selectedColor,
    iconColor,
    textColor,
    contentPadding,
    tileColor,
    selectedTileColor,
    horizontalTitleGap,
    minVerticalPadding,
    minLeadingWidth,
    enableFeedback,
    mouseCursor,
    visualDensity,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ListTileThemeData
      && other.dense == dense
      && other.shape == shape
      && other.style == style
      && other.selectedColor == selectedColor
      && other.iconColor == iconColor
      && other.textColor == textColor
      && other.contentPadding == contentPadding
      && other.tileColor == tileColor
      && other.selectedTileColor == selectedTileColor
      && other.horizontalTitleGap == horizontalTitleGap
      && other.minVerticalPadding == minVerticalPadding
      && other.minLeadingWidth == minLeadingWidth
      && other.enableFeedback == enableFeedback
      && other.mouseCursor == mouseCursor
      && other.visualDensity == visualDensity;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('dense', dense, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('shape', shape, defaultValue: null));
    properties.add(EnumProperty<ListTileStyle>('style', style, defaultValue: null));
    properties.add(ColorProperty('selectedColor', selectedColor, defaultValue: null));
    properties.add(ColorProperty('iconColor', iconColor, defaultValue: null));
    properties.add(ColorProperty('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('contentPadding', contentPadding, defaultValue: null));
    properties.add(ColorProperty('tileColor', tileColor, defaultValue: null));
    properties.add(ColorProperty('selectedTileColor', selectedTileColor, defaultValue: null));
    properties.add(DoubleProperty('horizontalTitleGap', horizontalTitleGap, defaultValue: null));
    properties.add(DoubleProperty('minVerticalPadding', minVerticalPadding, defaultValue: null));
    properties.add(DoubleProperty('minLeadingWidth', minLeadingWidth, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('enableFeedback', enableFeedback, defaultValue: null));
    properties.add(DiagnosticsProperty<MaterialStateProperty<MouseCursor?>>('mouseCursor', mouseCursor, defaultValue: null));
    properties.add(DiagnosticsProperty<VisualDensity>('visualDensity', visualDensity, defaultValue: null));
  }
}

/// An inherited widget that defines color and style parameters for [ListTile]s
/// in this widget's subtree.
///
/// Values specified here are used for [ListTile] properties that are not given
/// an explicit non-null value.
///
/// The [Drawer] widget specifies a tile theme for its children which sets
/// [style] to [ListTileStyle.drawer].
class ListTileTheme extends InheritedTheme {
  /// Creates a list tile theme that defines the color and style parameters for
  /// descendant [ListTile]s.
  ///
  /// Only the [data] parameter should be used. The other parameters are
  /// redundant (are now obsolete) and will be deprecated in a future update.
  const ListTileTheme({
    super.key,
    ListTileThemeData? data,
    bool? dense,
    ShapeBorder? shape,
    ListTileStyle? style,
    Color? selectedColor,
    Color? iconColor,
    Color? textColor,
    EdgeInsetsGeometry? contentPadding,
    Color? tileColor,
    Color? selectedTileColor,
    bool? enableFeedback,
    MaterialStateProperty<MouseCursor?>? mouseCursor,
    double? horizontalTitleGap,
    double? minVerticalPadding,
    double? minLeadingWidth,
    required super.child,
  }) : assert(
         data == null ||
         (shape ??
          selectedColor ??
          iconColor ??
          textColor ??
          contentPadding ??
          tileColor ??
          selectedTileColor ??
          enableFeedback ??
          mouseCursor ??
          horizontalTitleGap ??
          minVerticalPadding ??
          minLeadingWidth) == null),
       _data = data,
       _dense = dense,
       _shape = shape,
       _style = style,
       _selectedColor = selectedColor,
       _iconColor = iconColor,
       _textColor = textColor,
       _contentPadding = contentPadding,
       _tileColor = tileColor,
       _selectedTileColor = selectedTileColor,
       _enableFeedback = enableFeedback,
       _mouseCursor = mouseCursor,
       _horizontalTitleGap = horizontalTitleGap,
       _minVerticalPadding = minVerticalPadding,
       _minLeadingWidth = minLeadingWidth;

  final ListTileThemeData? _data;
  final bool? _dense;
  final ShapeBorder? _shape;
  final ListTileStyle? _style;
  final Color? _selectedColor;
  final Color? _iconColor;
  final Color? _textColor;
  final EdgeInsetsGeometry? _contentPadding;
  final Color? _tileColor;
  final Color? _selectedTileColor;
  final double? _horizontalTitleGap;
  final double? _minVerticalPadding;
  final double? _minLeadingWidth;
  final bool? _enableFeedback;
  final MaterialStateProperty<MouseCursor?>? _mouseCursor;

  /// The configuration of this theme.
  ListTileThemeData get data {
    return _data ?? ListTileThemeData(
      dense: _dense,
      shape: _shape,
      style: _style,
      selectedColor: _selectedColor,
      iconColor: _iconColor,
      textColor: _textColor,
      contentPadding: _contentPadding,
      tileColor: _tileColor,
      selectedTileColor: _selectedTileColor,
      enableFeedback: _enableFeedback,
      mouseCursor: _mouseCursor,
      horizontalTitleGap: _horizontalTitleGap,
      minVerticalPadding: _minVerticalPadding,
      minLeadingWidth: _minLeadingWidth,
    );
  }

  /// Overrides the default value of [ListTile.dense].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.dense] property instead.
  bool? get dense => _data != null ? _data!.dense : _dense;

  /// Overrides the default value of [ListTile.shape].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.shape] property instead.
  ShapeBorder? get shape => _data != null ? _data!.shape : _shape;

  /// Overrides the default value of [ListTile.style].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.style] property instead.
  ListTileStyle? get style => _data != null ? _data!.style : _style;

  /// Overrides the default value of [ListTile.selectedColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.selectedColor] property instead.
  Color? get selectedColor => _data != null ? _data!.selectedColor : _selectedColor;

  /// Overrides the default value of [ListTile.iconColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.iconColor] property instead.
  Color? get iconColor => _data != null ? _data!.iconColor : _iconColor;

  /// Overrides the default value of [ListTile.textColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.textColor] property instead.
  Color? get textColor => _data != null ? _data!.textColor : _textColor;

  /// Overrides the default value of [ListTile.contentPadding].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.contentPadding] property instead.
  EdgeInsetsGeometry? get contentPadding => _data != null ? _data!.contentPadding : _contentPadding;

  /// Overrides the default value of [ListTile.tileColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.tileColor] property instead.
  Color? get tileColor => _data != null ? _data!.tileColor : _tileColor;

  /// Overrides the default value of [ListTile.selectedTileColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.selectedTileColor] property instead.
  Color? get selectedTileColor => _data != null ? _data!.selectedTileColor : _selectedTileColor;

  /// Overrides the default value of [ListTile.horizontalTitleGap].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.horizontalTitleGap] property instead.
  double? get horizontalTitleGap => _data != null ? _data!.horizontalTitleGap : _horizontalTitleGap;

  /// Overrides the default value of [ListTile.minVerticalPadding].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.minVerticalPadding] property instead.
  double? get minVerticalPadding => _data != null ? _data!.minVerticalPadding : _minVerticalPadding;

  /// Overrides the default value of [ListTile.minLeadingWidth].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.minLeadingWidth] property instead.
  double? get minLeadingWidth => _data != null ? _data!.minLeadingWidth : _minLeadingWidth;

  /// Overrides the default value of [ListTile.enableFeedback].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.enableFeedback] property instead.
  bool? get enableFeedback => _data != null ? _data!.enableFeedback : _enableFeedback;

  /// The [data] property of the closest instance of this class that
  /// encloses the given context.
  ///
  /// If there is no enclosing [ListTileTheme] widget, then
  /// [ThemeData.listTileTheme] is used (see [Theme.of]).
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ListTileThemeData theme = ListTileTheme.of(context);
  /// ```
  static ListTileThemeData of(BuildContext context) {
    final ListTileTheme? result = context.dependOnInheritedWidgetOfExactType<ListTileTheme>();
    return result?.data ?? Theme.of(context).listTileTheme;
  }

  /// Creates a list tile theme that controls the color and style parameters for
  /// [ListTile]s, and merges in the current list tile theme, if any.
  ///
  /// The [child] argument must not be null.
  static Widget merge({
    Key? key,
    bool? dense,
    ShapeBorder? shape,
    ListTileStyle? style,
    Color? selectedColor,
    Color? iconColor,
    Color? textColor,
    EdgeInsetsGeometry? contentPadding,
    Color? tileColor,
    Color? selectedTileColor,
    bool? enableFeedback,
    double? horizontalTitleGap,
    double? minVerticalPadding,
    double? minLeadingWidth,
    required Widget child,
  }) {
    assert(child != null);
    return Builder(
      builder: (BuildContext context) {
        final ListTileThemeData parent = ListTileTheme.of(context);
        return ListTileTheme(
          key: key,
          data: ListTileThemeData(
            dense: dense ?? parent.dense,
            shape: shape ?? parent.shape,
            style: style ?? parent.style,
            selectedColor: selectedColor ?? parent.selectedColor,
            iconColor: iconColor ?? parent.iconColor,
            textColor: textColor ?? parent.textColor,
            contentPadding: contentPadding ?? parent.contentPadding,
            tileColor: tileColor ?? parent.tileColor,
            selectedTileColor: selectedTileColor ?? parent.selectedTileColor,
            enableFeedback: enableFeedback ?? parent.enableFeedback,
            horizontalTitleGap: horizontalTitleGap ?? parent.horizontalTitleGap,
            minVerticalPadding: minVerticalPadding ?? parent.minVerticalPadding,
            minLeadingWidth: minLeadingWidth ?? parent.minLeadingWidth,
          ),
          child: child,
        );
      },
    );
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return ListTileTheme(
      data: ListTileThemeData(
        dense: dense,
        shape: shape,
        style: style,
        selectedColor: selectedColor,
        iconColor: iconColor,
        textColor: textColor,
        contentPadding: contentPadding,
        tileColor: tileColor,
        selectedTileColor: selectedTileColor,
        enableFeedback: enableFeedback,
        horizontalTitleGap: horizontalTitleGap,
        minVerticalPadding: minVerticalPadding,
        minLeadingWidth: minLeadingWidth,
      ),
      child: child,
    );
  }

  @override
  bool updateShouldNotify(ListTileTheme oldWidget) => data != oldWidget.data;
}
