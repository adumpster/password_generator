import 'package:flutter/material.dart';

class SettingsPanel extends StatelessWidget {
  final double length;
  final bool upper, lower, numbers, special;
  final Function(double) onLengthChanged;
  final Function(bool) onUpperChanged,
      onLowerChanged,
      onNumberChanged,
      onSpecialChanged;

  const SettingsPanel({
    super.key,
    required this.length,
    required this.onLengthChanged,
    required this.upper,
    required this.lower,
    required this.numbers,
    required this.special,
    required this.onUpperChanged,
    required this.onLowerChanged,
    required this.onNumberChanged,
    required this.onSpecialChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Password Length: ${length.toInt()}"),
        Slider(
          value: length,
          min: 8,
          max: 32,
          divisions: 24,
          label: length.toInt().toString(),
          onChanged: onLengthChanged,
        ),
        CheckboxListTile(
          value: upper,
          onChanged: (val) => onUpperChanged(val!),
          title: const Text("Include Uppercase Letters"),
        ),
        CheckboxListTile(
          value: lower,
          onChanged: (val) => onLowerChanged(val!),
          title: const Text("Include Lowercase Letters"),
        ),
        CheckboxListTile(
          value: numbers,
          onChanged: (val) => onNumberChanged(val!),
          title: const Text("Include Numbers"),
        ),
        CheckboxListTile(
          value: special,
          onChanged: (val) => onSpecialChanged(val!),
          title: const Text("Include Special Characters"),
        ),
      ],
    );
  }
}
