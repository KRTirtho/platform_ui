import 'package:platform_ui/platform_ui.dart';
import 'package:platform_ui/src/core/platform_preset.dart';

class TabsPreset extends PlatformPreset<TabBarTheme> {
  TabsPreset(super.colorScheme);

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
    return TabBarTheme(
      splashFactory: NoSplash.splashFactory,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontWeight: FontWeight.normal),
      labelColor: colorScheme.onSurface,
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      dividerColor: Colors.transparent,
      indicator: UnderlineTabIndicator(
        borderRadius: constants.fluent.defaultBorderRadius,
        insets: const EdgeInsets.symmetric(horizontal: 8),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
    );
  }

  @override
  material() {
    // TODO: implement material
    throw UnimplementedError();
  }
}
