import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard

void main() {
  runApp(PasswordGeneratorApp());
}

class PasswordGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Generator',
      home: PasswordGeneratorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PasswordGeneratorScreen extends StatefulWidget {
  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  double passwordLength = 12;
  bool includeUppercase = true;
  bool includeLowercase = true;
  bool includeNumbers = true;
  bool includeSpecial = true;
  String generatedPassword = '';
  String chars = '';
  void generatePassword() {
    if (!includeUppercase &&
        !includeLowercase &&
        !includeNumbers &&
        !includeSpecial) {
      setState(() {
        generatedPassword = 'Please select at least one option!';
      });
    }

    const String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String lower = 'abcdefghijklmnopqrstuvwxyz';
    const String numbers = '0123456789';
    const String special = '@#\$%^&*()_-+=[]{}|;:,.<>?/~`';

    if (includeUppercase) chars += upper;
    if (includeLowercase) chars += lower;
    if (includeNumbers) chars += numbers;
    if (includeSpecial) chars += special;

    String password = '';
    Random rand = Random();
    for (int i = 0; i < passwordLength; i++) {
      if (chars != '') {
        password += chars[rand.nextInt(chars.length)];
      }
    }
    if (chars != '') {
      setState(() {
        generatedPassword = password;
      });
    }
  }

  void copyToClipboard() {
    if (generatedPassword.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: generatedPassword));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Password copied to clipboard")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Password Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Password Length: ${passwordLength.round()}'),
            Slider(
              value: passwordLength,
              min: 8,
              max: 32,
              divisions: 24,
              label: passwordLength.round().toString(),
              onChanged: (value) {
                setState(() {
                  passwordLength = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Include Uppercase Letters'),
              value: includeUppercase,
              onChanged: (val) => setState(() => includeUppercase = val),
            ),
            SwitchListTile(
              title: Text('Include Lowercase Letters'),
              value: includeLowercase,
              onChanged: (val) => setState(() => includeLowercase = val),
            ),
            SwitchListTile(
              title: Text('Include Numbers'),
              value: includeNumbers,
              onChanged: (val) => setState(() => includeNumbers = val),
            ),
            SwitchListTile(
              title: Text('Include Special Characters'),
              value: includeSpecial,
              onChanged: (val) => setState(() => includeSpecial = val),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: generatePassword,
              child: Text('Generate Password'),
            ),
            SizedBox(height: 20),
            SelectableText(
              generatedPassword,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.copy),
              onPressed: copyToClipboard,
              tooltip: 'Copy to Clipboard',
            ),
          ],
        ),
      ),
    );
  }
}
