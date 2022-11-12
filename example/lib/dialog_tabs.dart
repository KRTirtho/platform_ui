import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

class DialogTabs extends StatefulWidget {
  const DialogTabs({Key? key}) : super(key: key);

  @override
  State<DialogTabs> createState() => _DialogTabsState();
}

class _DialogTabsState extends State<DialogTabs> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        PlatformTabBar(
          onSelectedIndexChanged: (value) {
            setState(() {
              index = value;
            });
          },
          selectedIndex: index,
          isNavigational: PlatformProperty.all(false),
          tabs: [
            PlatformTab(
              label: "Tab 1",
              icon: const Icon(Icons.star_border_rounded),
            ),
            PlatformTab(
              label: "Tab 2",
              icon: const Icon(Icons.sunny),
            ),
            PlatformTab(
              label: "Tab 3",
              icon: const Icon(Icons.dark_mode_outlined),
            ),
          ],
        ),
        PlatformFilledButton(
          child: const PlatformText("Show Dialog"),
          onPressed: () {
            final answer = showPlatformAlertDialog<bool>(
              context,
              builder: (context) {
                return PlatformAlertDialog(
                  title: const PlatformText("Isn't it great?"),
                  content: const PlatformText(
                    "This is a platform-specific dialog",
                  ),
                  primaryActions: [
                    PlatformBuilder(
                      fallback: PlatformBuilderFallback.android,
                      android: (context, _) {
                        return PlatformFilledButton(
                          child: const PlatformText("Yes"),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        );
                      },
                      ios: (context, parent) {
                        return CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const PlatformText("Yes"),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        );
                      },
                    ),
                  ],
                  secondaryActions: [
                    PlatformBuilder(
                      fallback: PlatformBuilderFallback.android,
                      android: (context, parent) {
                        return PlatformFilledButton(
                          isSecondary: true,
                          child: const PlatformText("No"),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        );
                      },
                      ios: (context, parent) {
                        return CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: const PlatformText("No"),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            );

            print("Did you say this? $answer");
          },
        ),
      ],
    );
  }
}
