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
                  Switch(
                    value: isChecked ?? false,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value;
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
            ],
          ),
        ),
      ),
    );
  }
}
