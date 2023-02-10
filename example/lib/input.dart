import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool checked = false;
  double sliderValue = 0.5;
  bool isDiscrete = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const PlatformTextField(
            padding: EdgeInsets.all(8),
            placeholder: "Placeholder",
            label: "Label",
            backgroundColor: Colors.blue,
            focusedBackgroundColor: Colors.amber,
          ),
          PlatformCheckbox(
            label: const PlatformText("Checkbox"),
            value: checked,
            onChanged: (value) {
              setState(() {
                checked = value ?? false;
              });
            },
          ),
          const PlatformTextField(
            prefixIcon: Icons.search,
            padding: EdgeInsets.all(8),
            placeholder: "Placeholder",
            label: "Label",
            suffixIcon: Icons.image,
          ),
          PlatformSwitch(
            value: checked,
            onChanged: (value) {
              setState(() {
                checked = value;
              });
            },
          ),
          PlatformDropDownMenu(
            onChanged: (value) {
              print(value);
            },
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
          PlatformSlider(
            value: sliderValue,
            divisions: isDiscrete ? 10 : null,
            onChangeStart: (value) {
              print("Start: $value");
            },
            onChangeEnd: (value) {
              print("End: $value");
            },
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: PlatformCheckbox(
              label: const PlatformText("Is Discrete Slider"),
              value: isDiscrete,
              onChanged: (value) {
                setState(() {
                  isDiscrete = value ?? false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
