import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

void main() {
  platform = TargetPlatform.windows;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        onChange: (value) {
          setState(() {
            platform = value;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final void Function(TargetPlatform?) onChange;
  const MyHomePage({super.key, required this.title, required this.onChange});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool checked = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText(widget.title),
        automaticallyImplyLeading: true,
        leading: const Icon(Icons.flutter_dash_rounded),
        actions: [
          PlatformIconButton(
            icon: const Icon(
              Icons.notifications_active_rounded,
            ),
            onPressed: () {},
          ),
          PlatformPopupMenuButton<String>(
            items: [
              PlatformPopupMenuItem(
                value: "lol",
                child: const PlatformText("LOL"),
              ),
              PlatformPopupMenuItem(
                value: "lmao",
                child: const PlatformText("LMAO"),
              ),
              PlatformPopupMenuItem(
                value: "ftw",
                child: const PlatformText("FTW"),
              ),
            ],
            onCanceled: () {
              print("Canceled");
            },
            onSelected: (value) {
              print(value);
            },
            child: const Icon(Icons.more_vert_rounded),
          )
        ],
      ),
      body: PlatformSidebar(
        body: {
          PlatformSidebarItem(
            title: const PlatformText("Home"),
            icon: const Icon(Icons.home_rounded),
          ): PlatformTabView(
            body: {
              PlatformTab(
                label: "Widgets",
                icon: const Icon(Icons.collections_bookmark_rounded),
              ): SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PlatformFilledButton(
                          child: const PlatformText('Android'),
                          onPressed: () =>
                              widget.onChange(TargetPlatform.android),
                        ),
                        PlatformFilledButton(
                          child: const PlatformText('iOS'),
                          onPressed: () => widget.onChange(TargetPlatform.iOS),
                        ),
                        PlatformFilledButton(
                          child: const PlatformText('Linux'),
                          onPressed: () =>
                              widget.onChange(TargetPlatform.linux),
                        ),
                        PlatformFilledButton(
                          child: const PlatformText('MacOS'),
                          onPressed: () =>
                              widget.onChange(TargetPlatform.macOS),
                        ),
                        PlatformFilledButton(
                          child: const PlatformText('Windows'),
                          onPressed: () =>
                              widget.onChange(TargetPlatform.windows),
                        ),
                      ],
                    ),
                    const PlatformText(
                      'You have pushed the button this many times:',
                    ),
                    PlatformText(
                      '$_counter',
                      style: PlatformTextTheme.of(context).subheading,
                    ),
                    PlatformFilledButton(
                      child: const PlatformText("Filled Button"),
                      onPressed: () {
                        setState(() {
                          _counter++;
                        });
                      },
                    ),
                    PlatformTextButton(
                      child: const PlatformText("PlatformText Button"),
                      onPressed: () {
                        setState(() {
                          _counter++;
                        });
                      },
                    ),
                    PlatformIconButton(
                      icon: const Icon(Icons.star_border_rounded),
                      onPressed: () {},
                    ),
                    PlatformSwitch(
                      value: checked,
                      onChanged: (value) {
                        setState(() {
                          checked = value;
                        });
                      },
                      activeThumbColor: Colors.red,
                      activeTrackColor: Colors.red[800],
                      inactiveTrackColor: Colors.white,
                      inactiveThumbColor: Colors.green,
                    ),
                    const PlatformTextField(
                      padding: EdgeInsets.all(8),
                      placeholder: "Placeholder",
                      label: "Label",
                      backgroundColor: Colors.blue,
                      focusedBackgroundColor: Colors.amber,
                    ),
                    PlatformDropDownMenu(
                      onChanged: (value) {},
                      dropdownColor: Colors.grey,
                      elevation: 20,
                      items: [
                        PlatformDropDownMenuItem(
                          child: const PlatformText("LOL"),
                          value: "LOL",
                        ),
                        PlatformDropDownMenuItem(
                          child: const PlatformText("Cool"),
                          value: "Cool",
                        ),
                        PlatformDropDownMenuItem(
                          child: const PlatformText("Foul"),
                          value: "Foul",
                        ),
                      ],
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
                    PlatformListTile(
                      title: const PlatformText("Title"),
                      subtitle: const PlatformText("Subtitle"),
                      leading: const Icon(Icons.accessibility_outlined),
                      trailing: const Icon(
                          Icons.airline_seat_legroom_reduced_outlined),
                      onTap: () {
                        print("Tapped");
                      },
                      onLongPress: () {
                        print("Long Pressed");
                      },
                    ),
                    PlatformTooltip(
                      message:
                          "Really Wonderful ${Theme.of(context).platform.name}",
                      child: const PlatformText("Hover/Long-Press for Tooltip"),
                    ),
                    PlatformCheckbox(
                      value: checked,
                      onChanged: (value) {
                        setState(() {
                          checked = value ?? false;
                        });
                      },
                    ),
                    const PlatformText("Hover/Long-Press for Popup Menu"),
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
                                PlatformFilledButton(
                                  child: const PlatformText("Yes"),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ],
                              secondaryActions: [
                                PlatformFilledButton(
                                  isSecondary: true,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      Colors.grey[300],
                                    ),
                                  ),
                                  child: const PlatformText(
                                    "No",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
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
                ),
              ),
              PlatformTab(
                label: "Apple's HIG",
                icon: const Icon(Icons.format_align_justify),
              ): Container(),
            },
          ),
          PlatformSidebarItem(
            title: const PlatformText("Settings"),
            icon: const Icon(Icons.settings_rounded),
          ): const Center(
            child: PlatformText("Settings"),
          ),
          PlatformSidebarItem(
            title: const PlatformText("About"),
            icon: const Icon(Icons.info_rounded),
          ): const Center(
            child: PlatformText("About"),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
