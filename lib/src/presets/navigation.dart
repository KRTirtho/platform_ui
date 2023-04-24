import 'package:platform_ui/platform_ui.dart';
import 'package:platform_ui/src/core/platform_preset.dart';

class NavigationPresetCollection {
  final NavigationRailThemeData navigationRail;
  final NavigationBarThemeData navigationBar;

  NavigationPresetCollection({
    required this.navigationRail,
    required this.navigationBar,
  });
}

class NavigationPreset extends PlatformPreset<NavigationPresetCollection> {
  NavigationPreset(super.colorScheme);

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
    final navigationBarThemeData = NavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      height: 50,
      indicatorColor: Colors.transparent,
      indicatorShape: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary, width: 2.5),
      ),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: const MaterialStatePropertyAll(
        TextStyle(fontWeight: FontWeight.normal),
      ),
    );
    final navigationRailThemeData = NavigationRailThemeData(
      backgroundColor: colorScheme.surfaceVariant,
      elevation: 0,
      indicatorColor: Colors.transparent,
      indicatorShape: Border(
        left: BorderSide(color: colorScheme.primary, width: 2.5),
      ),
      selectedLabelTextStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface,
      ),
      unselectedLabelTextStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface,
      ),
      selectedIconTheme: IconThemeData(color: colorScheme.onSurface),
      unselectedIconTheme: IconThemeData(color: colorScheme.onSurface),
    );

    return NavigationPresetCollection(
      navigationBar: navigationBarThemeData,
      navigationRail: navigationRailThemeData,
    );
  }

  @override
  material() {
    // TODO: implement material
    throw UnimplementedError();
  }
}
