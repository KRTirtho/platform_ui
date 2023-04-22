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

  toggleTheme() {
    setState(() {
      themeMode =
          themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Platform UI",
      theme: PlatformThemeData.windows(),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  DropdownButton<int>(
                    value: dropdownValue,
                    items: const [
                      DropdownMenuItem<int>(value: 1, child: Text("One")),
                      DropdownMenuItem<int>(value: 2, child: Text("Two")),
                      DropdownMenuItem<int>(value: 3, child: Text("Three")),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        dropdownValue = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
