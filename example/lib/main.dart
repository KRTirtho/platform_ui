import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(context) =>
      context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;
  bool? isChecked = false;
  int dropdownValue = 1;
  bool extended = false;
  TextEditingController controller = TextEditingController();

  toggleTheme() {
    setState(() {
      themeMode =
          themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Platform UI",
      theme: PlatformThemeData.windows(),
      darkTheme: PlatformThemeData.windows(brightness: Brightness.dark),
      themeMode: themeMode,
      home: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              extended: extended,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    extended = !extended;
                  });
                },
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: Text('First'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_border),
                  selectedIcon: Icon(Icons.book),
                  label: Text('Second'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.star_border),
                  selectedIcon: Icon(Icons.star),
                  label: Text('Third'),
                ),
              ],
              selectedIndex: dropdownValue - 1,
              onDestinationSelected: (index) {
                setState(() {
                  dropdownValue = index + 1;
                });
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: toggleTheme,
                        child: const Text("Toggle Theme"),
                      ),
                      IconButton(
                        onPressed: toggleTheme,
                        icon: const Icon(Icons.lightbulb),
                      ),
                      TextButton(
                        onPressed: toggleTheme,
                        child: const Text("Toggle Theme"),
                      ),
                      OutlinedButton(
                        onPressed: toggleTheme,
                        child: const Text("Toggle Theme"),
                      ),
                      FilledButton(
                        onPressed: toggleTheme,
                        child: const Text("Toggle Theme"),
                      ),
                      Chip(
                        label: const Text("Chip"),
                        onDeleted: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        tristate: true,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value;
                          });
                        },
                      ),
                      Switch(
                        value: isChecked ?? false,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value;
                          });
                        },
                      ),
                      DropdownMenu<int>(
                        initialSelection: dropdownValue,
                        dropdownMenuEntries: const [
                          DropdownMenuEntry<int>(value: 1, label: "One"),
                          DropdownMenuEntry<int>(value: 2, label: "Two"),
                          DropdownMenuEntry<int>(value: 3, label: "Three"),
                        ],
                        onSelected: (value) {
                          if (value == null) return;
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),
                      PopupMenuButton<int>(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => const [
                          PopupMenuItem<int>(value: 1, child: Text("One")),
                          PopupMenuItem<int>(value: 2, child: Text("Two")),
                          PopupMenuItem<int>(value: 3, child: Text("Three")),
                        ],
                        initialValue: dropdownValue,
                        onSelected: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),
                      Radio<int>(
                        value: 1,
                        groupValue: dropdownValue,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),
                      Radio<int>(
                        value: 2,
                        groupValue: dropdownValue,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),
                      Radio<int>(
                        value: 3,
                        groupValue: dropdownValue,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),
                      Slider(
                        value: dropdownValue.toDouble(),
                        min: 1,
                        max: 3,
                        label: dropdownValue.toString(),
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value.toInt();
                          });
                        },
                      ),
                    ],
                  ),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Enter text",
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.clear),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Error text",
                      errorText: "Error",
                    ),
                  ),
                  const SizedBox(height: 8),
                  Autocomplete<String>(
                    optionsBuilder: (textEditingValue) {
                      const kOptions = <String>[
                        'aardvark',
                        'bobcat',
                        'chameleon'
                      ];
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return kOptions.where((String option) {
                        return option
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      print('You just selected $selection');
                    },
                  ),
                  const DefaultTabController(
                    length: 3,
                    child: SizedBox(
                      height: 35,
                      child: TabBar(
                        tabs: [
                          Tab(text: "Tab 1"),
                          Tab(text: "Tab 2"),
                          Tab(text: "Tab 3"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  NavigationBar(
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.favorite),
                        label: "Favorites",
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.bookmark),
                        label: "Bookmarks",
                      ),
                    ],
                    selectedIndex: dropdownValue - 1,
                    onDestinationSelected: (index) {
                      setState(() {
                        dropdownValue = index + 1;
                      });
                    },
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 300,
                      maxWidth: 400,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.favorite),
                          title: Text("Item $index"),
                          subtitle: const Text("Subtitle"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
