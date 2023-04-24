// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'card_theme.dart';
import 'material.dart';
import 'theme.dart';

/// A Material Design card: a panel with slightly rounded corners and an
/// elevation shadow.
///
/// A card is a sheet of [Material] used to represent some related information,
/// for example an album, a geographical location, a meal, contact details, etc.
///
/// This is what it looks like when run:
///
/// ![A card with a slight shadow, consisting of two rows, one with an icon and
/// some text describing a musical, and the other with buttons for buying
/// tickets or listening to the show.](https://flutter.github.io/assets-for-api-docs/assets/material/card.png)
///
/// {@tool dartpad}
/// This sample shows creation of a [Card] widget that shows album information
/// and two actions.
///
/// ** See code in examples/api/lib/material/card/card.0.dart **
/// {@end-tool}
///
/// Sometimes the primary action area of a card is the card itself. Cards can be
/// one large touch target that shows a detail screen when tapped.
///
/// {@tool dartpad}
/// This sample shows creation of a [Card] widget that can be tapped. When
/// tapped this [Card]'s [InkWell] displays an "ink splash" that fills the
/// entire card.
///
/// ** See code in examples/api/lib/material/card/card.1.dart **
/// {@end-tool}
///
/// Material Design 3 introduced new types of cards. These can
/// be produced by configuring the [Card] widget's properties.
/// [Card] widget.
/// {@tool dartpad}
/// This sample shows creation of [Card] widgets for elevated, filled and
/// outlined types, as described in: https://m3.material.io/components/cards/overview
///
/// ** See code in examples/api/lib/material/card/card.2.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ListTile], to display icons and text in a card.
///  * [showDialog], to display a modal card.
///  * <https://material.io/design/components/cards.html>
///  * <https://m3.material.io/components/cards>
class Card extends StatelessWidget {
  /// Creates a Material Design card.
  ///
  /// The [elevation] must be null or non-negative. The [borderOnForeground]
  /// must not be null.
  const Card({
    super.key,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.child,
    this.semanticContainer = true,
  }) : assert(elevation == null || elevation >= 0.0),
       assert(borderOnForeground != null);

  /// The card's background color.
  ///
  /// Defines the card's [Material.color].
  ///
  /// If this property is null then [CardTheme.color] of [ThemeData.cardTheme]
  /// is used. If that's null then [ThemeData.cardColor] is used.
  final Color? color;

  /// The color to paint the shadow below the card.
  ///
  /// If null then the ambient [CardTheme]'s shadowColor is used.
  /// If that's null too, then the overall theme's [ThemeData.shadowColor]
  /// (default black) is used.
  final Color? shadowColor;

  /// The color used as an overlay on [color] to indicate elevation.
  ///
  /// If this is null, no overlay will be applied. Otherwise this color
  /// will be composited on top of [color] with an opacity related
  /// to [elevation] and used to paint the background of the card.
  ///
  /// The default is null.
  ///
  /// See [Material.surfaceTintColor] for more details on how this
  /// overlay is applied.
  final Color? surfaceTintColor;

  /// The z-coordinate at which to place this card. This controls the size of
  /// the shadow below the card.
  ///
  /// Defines the card's [Material.elevation].
  ///
  /// If this property is null then [CardTheme.elevation] of
  /// [ThemeData.cardTheme] is used. If that's null, the default value is 1.0.
  final double? elevation;

  /// The shape of the card's [Material].
  ///
  /// Defines the card's [Material.shape].
  ///
  /// If this property is null then [CardTheme.shape] of [ThemeData.cardTheme]
  /// is used. If that's null then the shape will be a [RoundedRectangleBorder]
  /// with a circular corner radius of 4.0.
  final ShapeBorder? shape;

  /// Whether to paint the [shape] border in front of the [child].
  ///
  /// The default value is true.
  /// If false, the border will be painted behind the [child].
  final bool borderOnForeground;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// If this property is null then [CardTheme.clipBehavior] of
  /// [ThemeData.cardTheme] is used. If that's null then the behavior will be [Clip.none].
  final Clip? clipBehavior;

  /// The empty space that surrounds the card.
  ///
  /// Defines the card's outer [Container.margin].
  ///
  /// If this property is null then [CardTheme.margin] of
  /// [ThemeData.cardTheme] is used. If that's null, the default margin is 4.0
  /// logical pixels on all sides: `EdgeInsets.all(4.0)`.
  final EdgeInsetsGeometry? margin;

  /// Whether this widget represents a single semantic container, or if false
  /// a collection of individual semantic nodes.
  ///
  /// Defaults to true.
  ///
  /// Setting this flag to true will attempt to merge all child semantics into
  /// this node. Setting this flag to false will force all child semantic nodes
  /// to be explicit.
  ///
  /// This flag should be false if the card contains multiple different types
  /// of content.
  final bool semanticContainer;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final CardTheme cardTheme = CardTheme.of(context);
    final CardTheme defaults = Theme.of(context).useMaterial3 ? _CardDefaultsM3(context) : _CardDefaultsM2(context);

    return Semantics(
      container: semanticContainer,
      child: Container(
        margin: margin ?? cardTheme.margin ?? defaults.margin!,
        child: Material(
          type: MaterialType.card,
          color: color ?? cardTheme.color ?? defaults.color,
          shadowColor: shadowColor ?? cardTheme.shadowColor ?? defaults.shadowColor,
          surfaceTintColor: surfaceTintColor ?? cardTheme.surfaceTintColor ?? defaults.surfaceTintColor,
          elevation: elevation ?? cardTheme.elevation ?? defaults.elevation!,
          shape: shape ?? cardTheme.shape ?? defaults.shape,
          borderOnForeground: borderOnForeground,
          clipBehavior: clipBehavior ?? cardTheme.clipBehavior ?? defaults.clipBehavior!,
          child: Semantics(
            explicitChildNodes: !semanticContainer,
            child: child,
          ),
        ),
      ),
    );
  }
}

// Hand coded defaults based on Material Design 2.
class _CardDefaultsM2 extends CardTheme {
  const _CardDefaultsM2(this.context)
    : super(
        clipBehavior: Clip.none,
        elevation: 1.0,
        margin: const EdgeInsets.all(4.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        )
    );

  final BuildContext context;

  @override
  Color? get color => Theme.of(context).cardColor;

  @override
  Color? get shadowColor => Theme.of(context).shadowColor;
}

// BEGIN GENERATED TOKEN PROPERTIES - Card

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

// Token database version: v0_143

class _CardDefaultsM3 extends CardTheme {
  const _CardDefaultsM3(this.context)
    : super(
        clipBehavior: Clip.none,
        elevation: 1.0,
        margin: const EdgeInsets.all(4.0),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
      );

  final BuildContext context;

  @override
  Color? get color => Theme.of(context).colorScheme.surface;

  @override
  Color? get shadowColor => Theme.of(context).colorScheme.shadow;

  @override
  Color? get surfaceTintColor => Theme.of(context).colorScheme.surfaceTint;
}

// END GENERATED TOKEN PROPERTIES - Card
