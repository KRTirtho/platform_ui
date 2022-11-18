# Platform UI 
_by [@KRTirtho](https://github.com/KRTirtho)_

Flutter platform specific UI widgets

It mimics the native UI widgets (android, iOS, macOS, linux and windows) as much as possible in Flutter & has a wide collection of platform specific widgets. The names and APIs are similar to Flutter's Material UI widgets to make the Flutter developer feel at home. It's utilizes:
- [fluent_ui](https://pub.dev/packages/fluent_ui) for windows
- [macos_ui](https://pub.dev/packages/macos_ui) for macOS
- [Material UI/You](https://m3.material.io/) for android
- [Cupertino](https://docs.flutter.dev/development/ui/widgets/cupertino) for iOS
- [libadwaita](https://pub.dev/packages/libadwaita) for linux

## Feature Highlights
- Simple and customizable platform specific UI widgets
- Supports all major platforms (android, iOS, macOS, linux and windows)
- Exposes the internal API to build widgets on top of it
- Changeable default `TargetPlatform` for overriding platform design in another platform (it's crazy but cool)
- Wide collection of platform specific widgets
- Widget APIs are similar to Flutter's Material UI widgets
- Dark Mode support

## Install

Run following in a terminal:
```bash
$ flutter pub add platform_ui fluent_ui macos_ui libadwaita adwaita
```

## Usage

Import the package:
```dart
import 'package:platform_ui/platform_ui.dart';
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: 'Platform UI',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Platform UI'),
      ),
      body: Center(
        child: PlatformText(
          'Hello World',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
```

## Documentation

- [API Reference](https://pub.dev/documentation/platform_ui/latest/)
- [Example app](https://github.com/KRTirtho/platform_ui/blob/main/example/lib/main.dart)
- Production App
  - [Spotube](https://github.com/KRTirtho/spotube)

## Preview

### Desktop (Linux → Macos → Windows)

![Desktop](https://raw.githubusercontent.com/KRTirtho/platform_ui/main/assets/desktop.png)

### Mobile (Android → iOS)

![Mobile](https://raw.githubusercontent.com/KRTirtho/platform_ui/main/assets/mobile.png)


## Support

If you like this project, please consider supporting it by:
- Starring and sharing the project
- Following @KrTirtho on [Twitter](https://twitter.com/KrTirtho)
- Buying us a coffee ☕️

<a href="https://www.buymeacoffee.com/krtirtho">
<img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=krtirtho&button_colour=FF5F5F&font_colour=ffffff&font_family=Inter&outline_colour=000000&coffee_colour=FFDD00" />
</a>

## License

[MIT](https://github.com/KRTirtho/platform_ui/blob/main/LICENSE)