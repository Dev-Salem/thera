import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:thera/app.dart';

class LanguageLevelSelector extends StatefulWidget {
  const LanguageLevelSelector({super.key});

  @override
  LanguageLevelSelectorState createState() => LanguageLevelSelectorState();
}

class LanguageLevelSelectorState extends State<LanguageLevelSelector> {
  String _selectedLevel = 'Beginner';

  final List<String> _languageLevels = ['Beginner', 'Intermediate', 'Advanced'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ما هو مستواك؟",
              style: context.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Text(
              "لنحدد نقطة البداية! اختر المستوى الذي يناسب مهاراتك الحالية في اللغة العربية.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),
            // Wide buttons for selecting language levels
            Column(
              children: _languageLevels.map((level) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: level == _selectedLevel
                          ? Colors.black87
                          : Colors.grey,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedLevel = level;
                      });
                    },
                    child: Text(
                      level,
                      style: context.titleLarge!
                          .copyWith(color: Colors.white)
                          .bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
