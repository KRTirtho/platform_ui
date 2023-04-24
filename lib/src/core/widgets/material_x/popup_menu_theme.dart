// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'material_state.dart';
import 'theme.dart';

// Examples can assume:
// late BuildContext context;

/// Used to configure how the [PopupMenuButton] positions its popup menu.
enum PopupMenuPosition {
  /// Menu is positioned over the anchor.
  over,
  /// Menu is positioned under the anchor.
  under,
}

/// Defines the visual properties of the routes used to display popup menus
/// as well as [PopupMenuItem] and [PopupMenuDivider] widgets.
///
/// Descendant widgets obtain the current [PopupMenuThemeData] object
/// using `PopupMenuTheme.of(context)`. Instances of
/// [PopupMenuThemeData] can be customized with
/// [PopupMenuThemeData.copyWith].
///
/// Typically, a [PopupMenuThemeData] is specified as part of the
/// overall [Theme] with [ThemeData.popupMenuTheme]. Otherwise,
/// [PopupMenuTheme] can be used to configure its own widget subtree.
///
/// All [PopupMenuThemeData] properties are `null` by default.
/// If any of these properties are null, the popup menu will provide its
/// own defaults.
///
/// See also:
///
///  * [ThemeData], which describes the overall theme information for the
///    application.
@immutable
class PopupMenuThemeData with Diagnosticable {
  /// Creates the set of properties used to configure [PopupMenuTheme].
  const PopupMenuThemeData({
    this.color,
    this.shape,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.textStyle,
    this.labelTextStyle,
    this.enableFeedback,
    this.mouseCursor,
    this.position,
  });

  /// The background color of the popup menu.
  final Color? color;

  /// The shape of the popup menu.
  final ShapeBorder? shape;

  /// The elevation of the popup menu.
  final double? elevation;

  /// The color used to paint shadow below the popup menu.
  final Color? shadowColor;

  /// The color used as an overlay on [color] of the popup menu.
  final Color? surfaceTintColor;

  /// The text style of items in the popup menu.
  final TextStyle? textStyle;

  /// You can use this to specify a different style of the label
  /// when the popup menu item is enabled and disabled.
  final MaterialStateProperty<TextStyle?>? labelTextStyle;

  /// If specified, defines the feedback property for [PopupMenuButton].
  ///
  /// If [PopupMenuButton.enableFeedback] is provided, [enableFeedback] is ignored.
  final bool? enableFeedback;

  /// {@macro flutter.material.popupmenu.mouseCursor}
  ///
  /// If specified, overrides the default value of [PopupMenuItem.mouseCursor].
  final MaterialStateProperty<MouseCursor?>? mouseCursor;

  /// Whether the popup menu is positioned over or under the popup menu button.
  ///
  /// When not set, the position defaults to [PopupMenuPosition.over] which makes the
  /// popup menu appear directly over the button that was used to create it.
  final PopupMenuPosition? position;

  /// Creates a copy of this object with the given fields replaced with the
  /// new values.
  PopupMenuThemeData copyWith({
    Color? color,
    ShapeBorder? shape,
    double? elevation,
    Color? shadowColor,
    Color? surfaceTintColor,
    TextStyle? textStyle,
    MaterialStateProperty<TextStyle?>? labelTextStyle,
    bool? enableFeedback,
    MaterialStateProperty<MouseCursor?>? mouseCursor,
    PopupMenuPosition? position,
  }) {
    return PopupMenuThemeData(
      color: color ?? this.color,
      shape: shape ?? this.shape,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      textStyle: textStyle ?? this.textStyle,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      position: position ?? this.position,
    );
  }

  /// Linearly interpolate between two popup menu themes.
  ///
  /// If both arguments are null, then null is returned.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static PopupMenuThemeData? lerp(PopupMenuThemeData? a, PopupMenuThemeData? b, double t) {
    assert(t != null);
    if (a == null && b == null) {
      return null;
    }
    return PopupMenuThemeData(
      color: Color.lerp(a?.color, b?.color, t),
      shape: ShapeBorder.lerp(a?.shape, b?.shape, t),
      elevation: lerpDouble(a?.elevation, b?.elevation, t),
      shadowColor: Color.lerp(a?.shadowColor, b?.shadowColor, t),
      surfaceTintColor: Color.lerp(a?.surfaceTintColor, b?.surfaceTintColor, t),
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
      labelTextStyle: MaterialStateProperty.lerp<TextStyle?>(a?.labelTextStyle, b?.labelTextStyle, t, TextStyle.lerp),
      enableFeedback: t < 0.5 ? a?.enableFeedback : b?.enableFeedback,
      mouseCursor: t < 0.5 ? a?.mouseCursor : b?.mouseCursor,
      position: t < 0.5 ? a?.position : b?.position,
    );
  }

  @override
  int get hashCode => Object.hash(
    color,
    shape,
    elevation,
    shadowColor,
    surfaceTintColor,
    textStyle,
    labelTextStyle,
    enableFeedback,
    mouseCursor,
    position,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is PopupMenuThemeData
        && other.color == color
        && other.shape == shape
        && other.elevation == elevation
        && other.shadowColor == shadowColor
        && other.surfaceTintColor == surfaceTintColor
        && other.textStyle == textStyle
        && other.labelTextStyle == labelTextStyle
        && other.enableFeedback == enableFeedback
        && other.mouseCursor == mouseCursor
        && other.position == position;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('shape', shape, defaultValue: null));
    properties.add(DoubleProperty('elevation', elevation, defaultValue: null));
    properties.add(ColorProperty('shadowColor', shadowColor, defaultValue: null));
    properties.add(ColorProperty('surfaceTintColor', surfaceTintColor, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('text style', textStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<MaterialStateProperty<TextStyle?>>('labelTextStyle', labelTextStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('enableFeedback', enableFeedback, defaultValue: null));
    properties.add(DiagnosticsProperty<MaterialStateProperty<MouseCursor?>>('mouseCursor', mouseCursor, defaultValue: null));
    properties.add(EnumProperty<PopupMenuPosition?>('position', position, defaultValue: null));
  }
}

/// An inherited widget that defines the configuration for
/// popup menus in this widget's subtree.
///
/// Values specified here are used for popup menu properties that are not
/// given an explicit non-null value.
class PopupMenuTheme extends InheritedTheme {
  /// Creates a popup menu theme that controls the configurations for
  /// popup menus in its widget subtree.
  ///
  /// The data argument must not be null.
  const PopupMenuTheme({
    super.key,
    required this.data,
    required super.child,
  }) : assert(data != null);

  /// The properties for descendant popup menu widgets.
  final PopupMenuThemeData data;

  /// The closest instance of this class's [data] value that encloses the given
  /// context. If there is no ancestor, it returns [ThemeData.popupMenuTheme].
  /// Applications can assume that the returned value will not be null.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// PopupMenuThemeData theme = PopupMenuTheme.of(context);
  /// ```
  static PopupMenuThemeData of(BuildContext context) {
    final PopupMenuTheme? popupMenuTheme = context.dependOnInheritedWidgetOfExactType<PopupMenuTheme>();
    return popupMenuTheme?.data ?? Theme.of(context).popupMenuTheme;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return PopupMenuTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(PopupMenuTheme oldWidget) => data != oldWidget.data;
}
