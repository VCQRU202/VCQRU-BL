import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';

import '../../ui_view/language_change/language_util.dart';

class TranslationProvider with ChangeNotifier {
  String _translatedText = "";
  String _selectedLanguage = 'en'; // Default language is English
  final GoogleTranslator _translator = GoogleTranslator();
  final LanguagePreferences _prefs = LanguagePreferences();

  String get translatedText => _translatedText;

  String get selectedLanguage => _selectedLanguage;

  /// Load saved language preference
  TranslationProvider() {
    loadSavedLanguage();
  }

  void loadSavedLanguage() async {
    _selectedLanguage = await _prefs.getLanguageCode();
    notifyListeners();
  }

  /// Translate text
  Future<void> translateText(String input) async {
    if (input.isNotEmpty) {
      final translation = await _translator.translate(
          input, to: _selectedLanguage);
      _translatedText = translation.text;
      notifyListeners();
    }
  }
  /// Change language and persist it
  void changeLanguage(String langCode) async {
    _selectedLanguage = langCode;
    await _prefs.setLanguageCode(langCode);
    notifyListeners();
  }
}