import 'package:flutter/material.dart';

class PasswordDisplay extends StatelessWidget {
  final String password;
  final VoidCallback onCopy;

  const PasswordDisplay({
    super.key,
    required this.password,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableText(
          password,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: onCopy,
          tooltip: 'Copy to Clipboard',
        ),
      ],
    );
  }
}
