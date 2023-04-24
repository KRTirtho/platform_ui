// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'constants.dart';
import 'elevation_overlay.dart';
import 'theme.dart';

// Examples can assume:
// late BuildContext context;

/// Signature for the callback used by ink effects to obtain the rectangle for the effect.
///
/// Used by [InkHighlight] and [InkSplash], for example.
typedef RectCallback = Rect Function();

/// The various kinds of material in Material Design. Used to
/// configure the default behavior of [Material] widgets.
///
/// See also:
///
///  * [Material], in particular [Material.type].
///  * [kMaterialEdges]
enum MaterialType {
  /// Rectangle using default theme canvas color.
  canvas,

  /// Rounded edges, card theme color.
  card,

  /// A circle, no color by default (used for floating action buttons).
  circle,

  /// Rounded edges, no color by default (used for [MaterialButton] buttons).
  button,

  /// A transparent piece of material that draws ink splashes and highlights.
  ///
  /// While the material metaphor describes child widgets as printed on the
  /// material itself and do not hide ink effects, in practice the [Material]
  /// widget draws child widgets on top of the ink effects.
  /// A [Material] with type transparency can be placed on top of opaque widgets
  /// to show ink effects on top of them.
  ///
  /// Prefer using the [Ink] widget for showing ink effects on top of opaque
  /// widgets.
  transparency
}

/// The border radii used by the various kinds of material in Material Design.
///
/// See also:
///
///  * [MaterialType]
///  * [Material]
const Map<MaterialType, BorderRadius?> kMaterialEdges = <MaterialType, BorderRadius?>{
  MaterialType.canvas: null,
  MaterialType.card: BorderRadius.all(Radius.circular(2.0)),
  MaterialType.circle: null,
  MaterialType.button: BorderRadius.all(Radius.circular(2.0)),
  MaterialType.transparency: null,
};

/// An interface for creating [InkSplash]s and [InkHighlight]s on a [Material].
///
/// Typically obtained via [Material.of].
abstract class MaterialInkController {
  /// The color of the material.
  Color? get color;

  /// The ticker provider used by the controller.
  ///
  /// Ink features that are added to this controller with [addInkFeature] should
  /// use this vsync to drive their animations.
  TickerProvider get vsync;

  /// Add an [InkFeature], such as an [InkSplash] or an [InkHighlight].
  ///
  /// The ink feature will paint as part of this controller.
  void addInkFeature(InkFeature feature);

  /// Notifies the controller that one of its ink features needs to repaint.
  void markNeedsPaint();
}

/// A piece of material.
///
/// The Material widget is responsible for:
///
/// 1. Clipping: If [clipBehavior] is not [Clip.none], Material clips its widget
///    sub-tree to the shape specified by [shape], [type], and [borderRadius].
///    By default, [clipBehavior] is [Clip.none] for performance considerations.
///    See [Ink] for an example of how this affects clipping [Ink] widgets.
/// 2. Elevation: Material elevates its widget sub-tree on the Z axis by
///    [elevation] pixels, and draws the appropriate shadow.
/// 3. Ink effects: Material shows ink effects implemented by [InkFeature]s
///    like [InkSplash] and [InkHighlight] below its children.
///
/// ## The Material Metaphor
///
/// Material is the central metaphor in Material Design. Each piece of material
/// exists at a given elevation, which influences how that piece of material
/// visually relates to other pieces of material and how that material casts
/// shadows.
///
/// Most user interface elements are either conceptually printed on a piece of
/// material or themselves made of material. Material reacts to user input using
/// [InkSplash] and [InkHighlight] effects. To trigger a reaction on the
/// material, use a [MaterialInkController] obtained via [Material.of].
///
/// In general, the features of a [Material] should not change over time (e.g. a
/// [Material] should not change its [color], [shadowColor] or [type]).
/// Changes to [elevation], [shadowColor] and [surfaceTintColor] are animated
/// for [animationDuration]. Changes to [shape] are animated if [type] is
/// not [MaterialType.transparency] and [ShapeBorder.lerp] between the previous
/// and next [shape] values is supported. Shape changes are also animated
/// for [animationDuration].
///
/// ## Shape
///
/// The shape for material is determined by [shape], [type], and [borderRadius].
///
///  - If [shape] is non null, it determines the shape.
///  - If [shape] is null and [borderRadius] is non null, the shape is a
///    rounded rectangle, with corners specified by [borderRadius].
///  - If [shape] and [borderRadius] are null, [type] determines the
///    shape as follows:
///    - [MaterialType.canvas]: the default material shape is a rectangle.
///    - [MaterialType.card]: the default material shape is a rectangle with
///      rounded edges. The edge radii is specified by [kMaterialEdges].
///    - [MaterialType.circle]: the default material shape is a circle.
///    - [MaterialType.button]: the default material shape is a rectangle with
///      rounded edges. The edge radii is specified by [kMaterialEdges].
///    - [MaterialType.transparency]: the default material shape is a rectangle.
///
/// ## Border
///
/// If [shape] is not null, then its border will also be painted (if any).
///
/// ## Layout change notifications
///
/// If the layout changes (e.g. because there's a list on the material, and it's
/// been scrolled), a [LayoutChangedNotification] must be dispatched at the
/// relevant subtree. This in particular means that transitions (e.g.
/// [SlideTransition]) should not be placed inside [Material] widgets so as to
/// move subtrees that contain [InkResponse]s, [InkWell]s, [Ink]s, or other
/// widgets that use the [InkFeature] mechanism. Otherwise, in-progress ink
/// features (e.g., ink splashes and ink highlights) won't move to account for
/// the new layout.
///
/// ## Painting over the material
///
/// Material widgets will often trigger reactions on their nearest material
/// ancestor. For example, [ListTile.hoverColor] triggers a reaction on the
/// tile's material when a pointer is hovering over it. These reactions will be
/// obscured if any widget in between them and the material paints in such a
/// way as to obscure the material (such as setting a [BoxDecoration.color] on
/// a [DecoratedBox]). To avoid this behavior, use [InkDecoration] to decorate
/// the material itself.
///
/// See also:
///
///  * [MergeableMaterial], a piece of material that can split and re-merge.
///  * [Card], a wrapper for a [Material] of [type] [MaterialType.card].
///  * <https://material.io/design/>
///  * <https://m3.material.io/styles/color/the-color-system/color-roles>
class Material extends StatefulWidget {
  /// Creates a piece of material.
  ///
  /// The [type], [elevation], [borderOnForeground],
  /// [clipBehavior], and [animationDuration] arguments must not be null.
  /// Additionally, [elevation] must be non-negative.
  ///
  /// If a [shape] is specified, then the [borderRadius] property must be
  /// null and the [type] property must not be [MaterialType.circle]. If the
  /// [borderRadius] is specified, then the [type] property must not be
  /// [MaterialType.circle]. In both cases, these restrictions are intended to
  /// catch likely errors.
  const Material({
    super.key,
    this.type = MaterialType.canvas,
    this.elevation = 0.0,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.textStyle,
    this.borderRadius,
    this.shape,
    this.borderOnForeground = true,
    this.clipBehavior = Clip.none,
    this.animationDuration = kThemeChangeDuration,
    this.child,
  }) : assert(type != null),
       assert(elevation != null && elevation >= 0.0),
       assert(!(shape != null && borderRadius != null)),
       assert(animationDuration != null),
       assert(!(identical(type, MaterialType.circle) && (borderRadius != null || shape != null))),
       assert(borderOnForeground != null),
       assert(clipBehavior != null);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// The kind of material to show (e.g., card or canvas). This
  /// affects the shape of the widget, the roundness of its corners if
  /// the shape is rectangular, and the default color.
  final MaterialType type;

  /// {@template flutter.material.material.elevation}
  /// The z-coordinate at which to place this material relative to its parent.
  ///
  /// This controls the size of the shadow below the material and the opacity
  /// of the elevation overlay color if it is applied.
  ///
  /// If this is non-zero, the contents of the material are clipped, because the
  /// widget conceptually defines an independent printed piece of material.
  ///
  /// Defaults to 0. Changing this value will cause the shadow and the elevation
  /// overlay or surface tint to animate over [Material.animationDuration].
  ///
  /// The value is non-negative.
  ///
  /// See also:
  ///
  ///  * [ThemeData.useMaterial3] which defines whether a surface tint or
  ///    elevation overlay is used to indicate elevation.
  ///  * [ThemeData.applyElevationOverlayColor] which controls the whether
  ///    an overlay color will be applied to indicate elevation.
  ///  * [Material.color] which may have an elevation overlay applied.
  ///  * [Material.shadowColor] which will be used for the color of a drop shadow.
  ///  * [Material.surfaceTintColor] which will be used as the overlay tint to
  ///    show elevation.
  /// {@endtemplate}
  final double elevation;

  /// The color to paint the material.
  ///
  /// Must be opaque. To create a transparent piece of material, use
  /// [MaterialType.transparency].
  ///
  /// If [ThemeData.useMaterial3] is true then an optional [surfaceTintColor]
  /// overlay may be applied on top of this color to indicate elevation.
  ///
  /// If [ThemeData.useMaterial3] is false and [ThemeData.applyElevationOverlayColor]
  /// is true and [ThemeData.brightness] is [Brightness.dark] then a
  /// semi-transparent overlay color will be composited on top of this
  /// color to indicate the elevation. This is no longer needed for Material
  /// Design 3, which uses [surfaceTintColor].
  ///
  /// By default, the color is derived from the [type] of material.
  final Color? color;

  /// The color to paint the shadow below the material.
  ///
  /// If null and [ThemeData.useMaterial3] is true then [ThemeData]'s
  /// [ColorScheme.shadow] will be used. If [ThemeData.useMaterial3] is false
  /// then [ThemeData.shadowColor] will be used.
  ///
  /// To remove the drop shadow when [elevation] is greater than 0, set
  /// [shadowColor] to [Colors.transparent].
  ///
  /// See also:
  ///  * [ThemeData.useMaterial3], which determines the default value for this
  ///    property if it is null.
  ///  * [ThemeData.applyElevationOverlayColor], which turns elevation overlay
  /// on or off for dark themes.
  final Color? shadowColor;

  /// The color of the surface tint overlay applied to the material color
  /// to indicate elevation.
  ///
  /// Material Design 3 introduced a new way for some components to indicate
  /// their elevation by using a surface tint color overlay on top of the
  /// base material [color]. This overlay is painted with an opacity that is
  /// related to the [elevation] of the material.
  ///
  /// If [ThemeData.useMaterial3] is false, then this property is not used.
  ///
  /// If [ThemeData.useMaterial3] is true and [surfaceTintColor] is not null and
  /// not [Colors.transparent], then it will be used to overlay the base [color]
  /// with an opacity based on the [elevation].
  ///
  /// Otherwise, no surface tint will be applied.
  ///
  /// See also:
  ///
  ///   * [ThemeData.useMaterial3], which turns this feature on.
  ///   * [ElevationOverlay.applySurfaceTint], which is used to implement the
  ///     tint.
  ///   * https://m3.material.io/styles/color/the-color-system/color-roles
  ///     which specifies how the overlay is applied.
  final Color? surfaceTintColor;

  /// The typographical style to use for text within this material.
  final TextStyle? textStyle;

  /// Defines the material's shape as well its shadow.
  ///
  /// If shape is non null, the [borderRadius] is ignored and the material's
  /// clip boundary and shadow are defined by the shape.
  ///
  /// A shadow is only displayed if the [elevation] is greater than
  /// zero.
  final ShapeBorder? shape;

  /// Whether to paint the [shape] border in front of the [child].
  ///
  /// The default value is true.
  /// If false, the border will be painted behind the [child].
  final bool borderOnForeground;

  /// {@template flutter.material.Material.clipBehavior}
  /// The content will be clipped (or not) according to this option.
  ///
  /// See the enum [Clip] for details of all possible options and their common
  /// use cases.
  /// {@endtemplate}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip clipBehavior;

  /// Defines the duration of animated changes for [shape], [elevation],
  /// [shadowColor], [surfaceTintColor] and the elevation overlay if it is applied.
  ///
  /// The default value is [kThemeChangeDuration].
  final Duration animationDuration;

  /// If non-null, the corners of this box are rounded by this
  /// [BorderRadiusGeometry] value.
  ///
  /// Otherwise, the corners specified for the current [type] of material are
  /// used.
  ///
  /// If [shape] is non null then the border radius is ignored.
  ///
  /// Must be null if [type] is [MaterialType.circle].
  final BorderRadiusGeometry? borderRadius;

  /// The ink controller from the closest instance of this class that
  /// encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// MaterialInkController? inkController = Material.maybeOf(context);
  /// ```
  ///
  /// This method can be expensive (it walks the element tree).
  ///
  /// See also:
  ///
  /// * [Material.of], which is similar to this method, but asserts if
  ///   no [Material] ancestor is found.
  static MaterialInkController? maybeOf(BuildContext context) {
    return context.findAncestorRenderObjectOfType<_RenderInkFeatures>();
  }

  /// The ink controller from the closest instance of [Material] that encloses
  /// the given context.
  ///
  /// If no [Material] widget ancestor can be found then this method will assert
  /// in debug mode, and throw an exception in release mode.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// MaterialInkController inkController = Material.of(context);
  /// ```
  ///
  /// This method can be expensive (it walks the element tree).
  ///
  /// See also:
  ///
  /// * [Material.maybeOf], which is similar to this method, but returns null if
  ///   no [Material] ancestor is found.
  static MaterialInkController of(BuildContext context) {
    final MaterialInkController? controller = maybeOf(context);
    assert(() {
      if (controller == null) {
        throw FlutterError(
          'Material.of() was called with a context that does not contain a Material widget.\n'
          'No Material widget ancestor could be found starting from the context that was passed to '
          'Material.of(). This can happen because you are using a widget that looks for a Material '
          'ancestor, but no such ancestor exists.\n'
          'The context used was:\n'
          '  $context',
        );
      }
      return true;
    }());
    return controller!;
  }

  @override
  State<Material> createState() => _MaterialState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<MaterialType>('type', type));
    properties.add(DoubleProperty('elevation', elevation, defaultValue: 0.0));
    properties.add(ColorProperty('color', color, defaultValue: null));
    properties.add(ColorProperty('shadowColor', shadowColor, defaultValue: null));
    properties.add(ColorProperty('surfaceTintColor', surfaceTintColor, defaultValue: null));
    textStyle?.debugFillProperties(properties, prefix: 'textStyle.');
    properties.add(DiagnosticsProperty<ShapeBorder>('shape', shape, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('borderOnForeground', borderOnForeground, defaultValue: true));
    properties.add(DiagnosticsProperty<BorderRadiusGeometry>('borderRadius', borderRadius, defaultValue: null));
  }

  /// The default radius of an ink splash in logical pixels.
  static const double defaultSplashRadius = 35.0;
}

class _MaterialState extends State<Material> with TickerProviderStateMixin {
  final GlobalKey _inkFeatureRenderer = GlobalKey(debugLabel: 'ink renderer');

  Color? _getBackgroundColor(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Color? color = widget.color;
    if (color == null) {
      switch (widget.type) {
        case MaterialType.canvas:
          color = theme.canvasColor;
          break;
        case MaterialType.card:
          color = theme.cardColor;
          break;
        case MaterialType.button:
        case MaterialType.circle:
        case MaterialType.transparency:
          break;
      }
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color? backgroundColor = _getBackgroundColor(context);
    final Color modelShadowColor = widget.shadowColor ?? (theme.useMaterial3 ? theme.colorScheme.shadow : theme.shadowColor);
    // If no shadow color is specified, use 0 for elevation in the model so a drop shadow won't be painted.
    final double modelElevation = modelShadowColor != null ? widget.elevation : 0;
    assert(
      backgroundColor != null || widget.type == MaterialType.transparency,
      'If Material type is not MaterialType.transparency, a color must '
      'either be passed in through the `color` property, or be defined '
      'in the theme (ex. canvasColor != null if type is set to '
      'MaterialType.canvas)',
    );
    Widget? contents = widget.child;
    if (contents != null) {
      contents = AnimatedDefaultTextStyle(
        style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium!,
        duration: widget.animationDuration,
        child: contents,
      );
    }
    contents = NotificationListener<LayoutChangedNotification>(
      onNotification: (LayoutChangedNotification notification) {
        final _RenderInkFeatures renderer = _inkFeatureRenderer.currentContext!.findRenderObject()! as _RenderInkFeatures;
        renderer._didChangeLayout();
        return false;
      },
      child: _InkFeatures(
        key: _inkFeatureRenderer,
        absorbHitTest: widget.type != MaterialType.transparency,
        color: backgroundColor,
        vsync: this,
        child: contents,
      ),
    );

    // PhysicalModel has a temporary workaround for a performance issue that
    // speeds up rectangular non transparent material (the workaround is to
    // skip the call to ui.Canvas.saveLayer if the border radius is 0).
    // Until the saveLayer performance issue is resolved, we're keeping this
    // special case here for canvas material type that is using the default
    // shape (rectangle). We could go down this fast path for explicitly
    // specified rectangles (e.g shape RoundedRectangleBorder with radius 0, but
    // we choose not to as we want the change from the fast-path to the
    // slow-path to be noticeable in the construction site of Material.
    if (widget.type == MaterialType.canvas && widget.shape == null && widget.borderRadius == null) {
      final Color color = Theme.of(context).useMaterial3
        ? ElevationOverlay.applySurfaceTint(backgroundColor!, widget.surfaceTintColor, widget.elevation)
        : ElevationOverlay.applyOverlay(context, backgroundColor!, widget.elevation);

      return AnimatedPhysicalModel(
        curve: Curves.fastOutSlowIn,
        duration: widget.animationDuration,
        shape: BoxShape.rectangle,
        clipBehavior: widget.clipBehavior,
        elevation: modelElevation,
        color: color,
        shadowColor: modelShadowColor,
        animateColor: false,
        child: contents,
      );
    }

    final ShapeBorder shape = _getShape();

    if (widget.type == MaterialType.transparency) {
      return _transparentInterior(
        context: context,
        shape: shape,
        clipBehavior: widget.clipBehavior,
        contents: contents,
      );
    }

    return _MaterialInterior(
      curve: Curves.fastOutSlowIn,
      duration: widget.animationDuration,
      shape: shape,
      borderOnForeground: widget.borderOnForeground,
      clipBehavior: widget.clipBehavior,
      elevation: widget.elevation,
      color: backgroundColor!,
      shadowColor: modelShadowColor,
      surfaceTintColor: widget.surfaceTintColor,
      child: contents,
    );
  }

  static Widget _transparentInterior({
    required BuildContext context,
    required ShapeBorder shape,
    required Clip clipBehavior,
    required Widget contents,
  }) {
    final _ShapeBorderPaint child = _ShapeBorderPaint(
      shape: shape,
      child: contents,
    );
    return ClipPath(
      clipper: ShapeBorderClipper(
        shape: shape,
        textDirection: Directionality.maybeOf(context),
      ),
      clipBehavior: clipBehavior,
      child: child,
    );
  }

  // Determines the shape for this Material.
  //
  // If a shape was specified, it will determine the shape.
  // If a borderRadius was specified, the shape is a rounded
  // rectangle.
  // Otherwise, the shape is determined by the widget type as described in the
  // Material class documentation.
  ShapeBorder _getShape() {
    if (widget.shape != null) {
      return widget.shape!;
    }
    if (widget.borderRadius != null) {
      return RoundedRectangleBorder(borderRadius: widget.borderRadius!);
    }
    switch (widget.type) {
      case MaterialType.canvas:
      case MaterialType.transparency:
        return const RoundedRectangleBorder();

      case MaterialType.card:
      case MaterialType.button:
        return RoundedRectangleBorder(
          borderRadius: widget.borderRadius ?? kMaterialEdges[widget.type]!,
        );

      case MaterialType.circle:
        return const CircleBorder();
    }
  }
}

class _RenderInkFeatures extends RenderProxyBox implements MaterialInkController {
  _RenderInkFeatures({
    RenderBox? child,
    required this.vsync,
    required this.absorbHitTest,
    this.color,
  }) : assert(vsync != null),
       super(child);

  // This class should exist in a 1:1 relationship with a MaterialState object,
  // since there's no current support for dynamically changing the ticker
  // provider.
  @override
  final TickerProvider vsync;

  // This is here to satisfy the MaterialInkController contract.
  // The actual painting of this color is done by a Container in the
  // MaterialState build method.
  @override
  Color? color;

  bool absorbHitTest;

  @visibleForTesting
  List<InkFeature>? get debugInkFeatures {
    if (kDebugMode) {
      return _inkFeatures;
    }
    return null;
  }
  List<InkFeature>? _inkFeatures;

  @override
  void addInkFeature(InkFeature feature) {
    assert(!feature._debugDisposed);
    assert(feature._controller == this);
    _inkFeatures ??= <InkFeature>[];
    assert(!_inkFeatures!.contains(feature));
    _inkFeatures!.add(feature);
    markNeedsPaint();
  }

  void _removeFeature(InkFeature feature) {
    assert(_inkFeatures != null);
    _inkFeatures!.remove(feature);
    markNeedsPaint();
  }

  void _didChangeLayout() {
    if (_inkFeatures != null && _inkFeatures!.isNotEmpty) {
      markNeedsPaint();
    }
  }

  @override
  bool hitTestSelf(Offset position) => absorbHitTest;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_inkFeatures != null && _inkFeatures!.isNotEmpty) {
      final Canvas canvas = context.canvas;
      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.clipRect(Offset.zero & size);
      for (final InkFeature inkFeature in _inkFeatures!) {
        inkFeature._paint(canvas);
      }
      canvas.restore();
    }
    super.paint(context, offset);
  }
}

class _InkFeatures extends SingleChildRenderObjectWidget {
  const _InkFeatures({
    super.key,
    this.color,
    required this.vsync,
    required this.absorbHitTest,
    super.child,
  });

  // This widget must be owned by a MaterialState, which must be provided as the vsync.
  // This relationship must be 1:1 and cannot change for the lifetime of the MaterialState.

  final Color? color;

  final TickerProvider vsync;

  final bool absorbHitTest;

  @override
  _RenderInkFeatures createRenderObject(BuildContext context) {
    return _RenderInkFeatures(
      color: color,
      absorbHitTest: absorbHitTest,
      vsync: vsync,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderInkFeatures renderObject) {
    renderObject..color = color
                ..absorbHitTest = absorbHitTest;
    assert(vsync == renderObject.vsync);
  }
}

/// A visual reaction on a piece of [Material].
///
/// To add an ink feature to a piece of [Material], obtain the
/// [MaterialInkController] via [Material.of] and call
/// [MaterialInkController.addInkFeature].
abstract class InkFeature {
  /// Initializes fields for subclasses.
  InkFeature({
    required MaterialInkController controller,
    required this.referenceBox,
    this.onRemoved,
  }) : assert(controller != null),
       assert(referenceBox != null),
       _controller = controller as _RenderInkFeatures;

  /// The [MaterialInkController] associated with this [InkFeature].
  ///
  /// Typically used by subclasses to call
  /// [MaterialInkController.markNeedsPaint] when they need to repaint.
  MaterialInkController get controller => _controller;
  final _RenderInkFeatures _controller;

  /// The render box whose visual position defines the frame of reference for this ink feature.
  final RenderBox referenceBox;

  /// Called when the ink feature is no longer visible on the material.
  final VoidCallback? onRemoved;

  bool _debugDisposed = false;

  /// Free up the resources associated with this ink feature.
  @mustCallSuper
  void dispose() {
    assert(!_debugDisposed);
    assert(() {
      _debugDisposed = true;
      return true;
    }());
    _controller._removeFeature(this);
    onRemoved?.call();
  }

  void _paint(Canvas canvas) {
    assert(referenceBox.attached);
    assert(!_debugDisposed);
    // find the chain of renderers from us to the feature's referenceBox
    final List<RenderObject> descendants = <RenderObject>[referenceBox];
    RenderObject node = referenceBox;
    while (node != _controller) {
      final RenderObject childNode = node;
      node = node.parent! as RenderObject;
      if (!node.paintsChild(childNode)) {
        // Some node between the reference box and this would skip painting on
        // the reference box, so bail out early and avoid unnecessary painting.
        // Some cases where this can happen are the reference box being
        // offstage, in a fully transparent opacity node, or in a keep alive
        // bucket.
        return;
      }
      descendants.add(node);
    }
    // determine the transform that gets our coordinate system to be like theirs
    final Matrix4 transform = Matrix4.identity();
    assert(descendants.length >= 2);
    for (int index = descendants.length - 1; index > 0; index -= 1) {
      descendants[index].applyPaintTransform(descendants[index - 1], transform);
    }
    paintFeature(canvas, transform);
  }

  /// Override this method to paint the ink feature.
  ///
  /// The transform argument gives the coordinate conversion from the coordinate
  /// system of the canvas to the coordinate system of the [referenceBox].
  @protected
  void paintFeature(Canvas canvas, Matrix4 transform);

  @override
  String toString() => describeIdentity(this);
}

/// An interpolation between two [ShapeBorder]s.
///
/// This class specializes the interpolation of [Tween] to use [ShapeBorder.lerp].
class ShapeBorderTween extends Tween<ShapeBorder?> {
  /// Creates a [ShapeBorder] tween.
  ///
  /// the [begin] and [end] properties may be null; see [ShapeBorder.lerp] for
  /// the null handling semantics.
  ShapeBorderTween({super.begin, super.end});

  /// Returns the value this tween has at the given animation clock value.
  @override
  ShapeBorder? lerp(double t) {
    return ShapeBorder.lerp(begin, end, t);
  }
}

/// The interior of non-transparent material.
///
/// Animates [elevation], [shadowColor], and [shape].
class _MaterialInterior extends ImplicitlyAnimatedWidget {
  /// Creates a const instance of [_MaterialInterior].
  ///
  /// The [child], [shape], [clipBehavior], [color], and [shadowColor] arguments
  /// must not be null. The [elevation] must be specified and greater than or
  /// equal to zero.
  const _MaterialInterior({
    required this.child,
    required this.shape,
    this.borderOnForeground = true,
    this.clipBehavior = Clip.none,
    required this.elevation,
    required this.color,
    required this.shadowColor,
    required this.surfaceTintColor,
    super.curve,
    required super.duration,
  }) : assert(child != null),
       assert(shape != null),
       assert(clipBehavior != null),
       assert(elevation != null && elevation >= 0.0),
       assert(color != null);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// The border of the widget.
  ///
  /// This border will be painted, and in addition the outer path of the border
  /// determines the physical shape.
  final ShapeBorder shape;

  /// Whether to paint the border in front of the child.
  ///
  /// The default value is true.
  /// If false, the border will be painted behind the child.
  final bool borderOnForeground;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip clipBehavior;

  /// The target z-coordinate at which to place this physical object relative
  /// to its parent.
  ///
  /// The value is non-negative.
  final double elevation;

  /// The target background color.
  final Color color;

  /// The target shadow color.
  final Color? shadowColor;

  /// The target surface tint color.
  final Color? surfaceTintColor;

  @override
  _MaterialInteriorState createState() => _MaterialInteriorState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(DiagnosticsProperty<ShapeBorder>('shape', shape));
    description.add(DoubleProperty('elevation', elevation));
    description.add(ColorProperty('color', color));
    description.add(ColorProperty('shadowColor', shadowColor));
  }
}

class _MaterialInteriorState extends AnimatedWidgetBaseState<_MaterialInterior> {
  Tween<double>? _elevation;
  ColorTween? _surfaceTintColor;
  ColorTween? _shadowColor;
  ShapeBorderTween? _border;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _elevation = visitor(
      _elevation,
      widget.elevation,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
    _shadowColor =  widget.shadowColor != null
      ? visitor(
          _shadowColor,
          widget.shadowColor,
          (dynamic value) => ColorTween(begin: value as Color),
        ) as ColorTween?
      : null;
    _surfaceTintColor = widget.surfaceTintColor != null
      ? visitor(
          _surfaceTintColor,
          widget.surfaceTintColor,
              (dynamic value) => ColorTween(begin: value as Color),
        ) as ColorTween?
      : null;
    _border = visitor(
      _border,
      widget.shape,
      (dynamic value) => ShapeBorderTween(begin: value as ShapeBorder),
    ) as ShapeBorderTween?;
  }

  @override
  Widget build(BuildContext context) {
    final ShapeBorder shape = _border!.evaluate(animation)!;
    final double elevation = _elevation!.evaluate(animation);
    final Color color = Theme.of(context).useMaterial3
      ? ElevationOverlay.applySurfaceTint(widget.color, _surfaceTintColor?.evaluate(animation), elevation)
      : ElevationOverlay.applyOverlay(context, widget.color, elevation);
    // If no shadow color is specified, use 0 for elevation in the model so a drop shadow won't be painted.
    final double modelElevation = widget.shadowColor != null ? elevation : 0;
    final Color shadowColor = _shadowColor?.evaluate(animation) ?? const Color(0x00000000);
    return PhysicalShape(
      clipper: ShapeBorderClipper(
        shape: shape,
        textDirection: Directionality.maybeOf(context),
      ),
      clipBehavior: widget.clipBehavior,
      elevation: modelElevation,
      color: color,
      shadowColor: shadowColor,
      child: _ShapeBorderPaint(
        shape: shape,
        borderOnForeground: widget.borderOnForeground,
        child: widget.child,
      ),
    );
  }
}

class _ShapeBorderPaint extends StatelessWidget {
  const _ShapeBorderPaint({
    required this.child,
    required this.shape,
    this.borderOnForeground = true,
  });

  final Widget child;
  final ShapeBorder shape;
  final bool borderOnForeground;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: borderOnForeground ? null : _ShapeBorderPainter(shape, Directionality.maybeOf(context)),
      foregroundPainter: borderOnForeground ? _ShapeBorderPainter(shape, Directionality.maybeOf(context)) : null,
      child: child,
    );
  }
}

class _ShapeBorderPainter extends CustomPainter {
  _ShapeBorderPainter(this.border, this.textDirection);
  final ShapeBorder border;
  final TextDirection? textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    border.paint(canvas, Offset.zero & size, textDirection: textDirection);
  }

  @override
  bool shouldRepaint(_ShapeBorderPainter oldDelegate) {
    return oldDelegate.border != border;
  }
}
