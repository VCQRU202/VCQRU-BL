import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers_of_app/language_change_provider/language_change_provider.dart';
class TranslateScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TranslationProvider>(context);

    /// Supported Languages
    final List<Map<String, String>> languages = [
      {'code': 'en', 'name': 'English'},
      {'code': 'hi', 'name': 'Hindi'},
      {'code': 'ta', 'name': 'Tamil'},
      {'code': 'te', 'name': 'Telugu'},
      {'code': 'mr', 'name': 'Marathi'},
      {'code': 'gu', 'name': 'Gujarati'},
      {'code': 'kn', 'name': 'Kannada'},
      {'code': 'bn', 'name': 'Bengali'},
      {'code': 'ml', 'name': 'Malayalam'},
      {'code': 'pa', 'name': 'Punjabi'},
      {'code': 'ur', 'name': 'Urdu'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Indian Language Translator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Input Field
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Enter text to translate",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            /// Language Dropdown
            DropdownButton<String>(
              value: provider.selectedLanguage,
              onChanged: (value) {
                provider.changeLanguage(value!);
              },
              items: languages.map((lang) {
                return DropdownMenuItem<String>(
                  value: lang['code']!,
                  child: Text(lang['name']!),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            /// Translate Button
            ElevatedButton(
              onPressed: () {
                provider.translateText(_controller.text);
              },
              child: Text("Translate"),
            ),
            SizedBox(height: 20),

            /// Display Translated Text
            Text(
              "Translated Text:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              provider.translatedText,
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}