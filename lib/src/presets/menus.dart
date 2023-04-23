import 'package:flutter/material.dart';
import 'package:platform_ui/src/core/platform_preset.dart';

class MenuPresetCollection {
  final PopupMenuThemeData popup;
  final MenuStyle menu;
  final MenuButtonThemeData menuButton;
  final DropdownMenuThemeData dropdown;

  MenuPresetCollection({
    required this.popup,
    required this.menu,
    required this.menuButton,
    required this.dropdown,
  });
}

class MenusPreset extends PlatformPreset<MenuPresetCollection> {
  MenusPreset(super.colorScheme);

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
    final menuButtonThemeData = MenuButtonThemeData(
      style: MenuItemButton.styleFrom(
        minimumSize: const Size.fromHeight(32),
        shape: RoundedRectangleBorder(
          borderRadius: constants.fluent.defaultBorderRadius,
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.normal),
      ).copyWith(
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (states) {
            if (states.contains(MaterialState.hovered)) {
              return RoundedRectangleBorder(
                borderRadius: constants.fluent.defaultBorderRadius,
                side: defaultBorderSide,
              );
            }
            return RoundedRectangleBorder(
              borderRadius: constants.fluent.defaultBorderRadius,
            );
          },
        ),
      ),
    );

    final menuStyle = MenuStyle(
      backgroundColor: MaterialStatePropertyAll(colorScheme.surface),
      elevation: const MaterialStatePropertyAll(4),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: constants.fluent.extendedBorderRadius,
          side: constants.fluent.borderSideVariant,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const MaterialStatePropertyAll(EdgeInsets.all(6)),
    );

    final dropdownInputBorder = OutlineInputBorder(
      borderSide: defaultBorderSide,
      borderRadius: constants.fluent.defaultBorderRadius,
    );
    final dropdownMenuThemeData = DropdownMenuThemeData(
      textStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      menuStyle: menuStyle,
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        constraints: const BoxConstraints(maxHeight: 32),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        filled: true,
        fillColor: colorScheme.surface,
        border: dropdownInputBorder,
        enabledBorder: dropdownInputBorder,
        focusedBorder: dropdownInputBorder,
      ),
    );
    final popupMenuThemeData = PopupMenuThemeData(
      position: PopupMenuPosition.under,
      elevation: 4,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: constants.fluent.extendedBorderRadius,
        side: constants.fluent.borderSideVariant,
      ),
      labelTextStyle: MaterialStateProperty.all(
        TextStyle(
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurface,
        ),
      ),
    );

    return MenuPresetCollection(
      menuButton: menuButtonThemeData,
      dropdown: dropdownMenuThemeData,
      popup: popupMenuThemeData,
      menu: menuStyle,
    );
  }

  @override
  material() {
    // TODO: implement material
    throw UnimplementedError();
  }
}
