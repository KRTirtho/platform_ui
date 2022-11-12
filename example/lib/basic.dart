import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

class Basic extends StatelessWidget {
  const Basic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlatformText.headline("Headline"),
          PlatformText.subheading("Subheading"),
          const PlatformText("Body"),
          PlatformText.label("Label"),
          PlatformText.caption("Caption"),
          PlatformTextButton(
            onPressed: () {},
            child: const PlatformText("Text Button"),
          ),
          PlatformFilledButton(
            onPressed: () {},
            child: const PlatformText("Filled Button"),
          ),
          PlatformFilledButton(
            isSecondary: true,
            onPressed: () {},
            child: const PlatformText("Secondary Filled Button"),
          ),
          PlatformIconButton(
            icon: const Icon(Icons.star_border_rounded),
            onPressed: () {},
          ),
          PlatformListTile(
            title: const PlatformText("Title"),
            subtitle: const PlatformText("Subtitle"),
            leading: const Icon(Icons.star_border_rounded),
            trailing: const Icon(Icons.star_border_rounded),
            onTap: () {
              print("Tapped");
            },
            onLongPress: () {
              print("Long Pressed");
            },
          ),
          PlatformTooltip(
            message: "Really Wonderful ${Theme.of(context).platform.name}",
            child: const PlatformText("Hover/Long-Press for Tooltip"),
          ),
        ],
      ),
    );
  }
}
