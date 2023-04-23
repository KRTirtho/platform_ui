import 'package:flutter/material.dart';
import 'package:platform_ui/src/core/platform_preset.dart';

class MiscellaneousPresetCollection {
  final ChipThemeData chip;
  final TooltipThemeData tooltip;
  final ScrollbarThemeData scrollbar;

  MiscellaneousPresetCollection({
    required this.chip,
    required this.tooltip,
    required this.scrollbar,
  });
}

class MiscellaneousPreset
    extends PlatformPreset<MiscellaneousPresetCollection> {
  MiscellaneousPreset(super.colorScheme);

  @override
  adwaita() {
    // TODO: implement adwaita
    throw UnimplementedError();
  }

  @override
  aqua() {
    // TODO: implement aqua
    throw UnimplementedError();
  }

  @override
  cupertino() {
    // TODO: implement cupertino
    throw UnimplementedError();
  }

  @override
  fluent() {
    final chipThemeData = ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide(color: colorScheme.primary, width: 1.2),
      elevation: 0,
      pressElevation: 0,
      deleteIconColor: colorScheme.primary,
      checkmarkColor: colorScheme.primary,
      labelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface,
      ),
    );
    final scrollbarThemeData = ScrollbarThemeData(
      radius: const Radius.circular(8),
      thickness: MaterialStateProperty.resolveWith<double>(
        (states) {
          if (states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed) ||
              states.contains(MaterialState.dragged)) {
            return 6;
          }
          return 4;
        },
      ),
      thumbVisibility: const MaterialStatePropertyAll(true),
      thumbColor: MaterialStatePropertyAll(colorScheme.outline),
      mainAxisMargin: 10,
      trackVisibility: MaterialStateProperty.resolveWith<bool>(
        (states) =>
            states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.pressed) ||
            states.contains(MaterialState.dragged),
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.pressed) ||
              states.contains(MaterialState.dragged)) {
            return colorScheme.surfaceVariant;
          }
          return colorScheme.surface;
        },
      ),
    );

    const tooltipThemeData = TooltipThemeData(
      decoration: BoxDecoration(
        color: Color(0xFF000000),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: Color(0xFFFFFFFF),
      ),
    );
    return MiscellaneousPresetCollection(
      chip: chipThemeData,
      tooltip: tooltipThemeData,
      scrollbar: scrollbarThemeData,
    );
  }

  @override
  material() {
    // TODO: implement material
    throw UnimplementedError();
  }
}
