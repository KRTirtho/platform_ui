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
  bool isMaximized = false;

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
            ],
          ),
        ),
      ),
    );
  }
}
