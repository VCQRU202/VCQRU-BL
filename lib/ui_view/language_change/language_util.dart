import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
class LanguagePreferences {
  static const String _keyLanguageCode = "language_code";

  Future<void> setLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguageCode, languageCode);
  }

  Future<String> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguageCode) ?? 'en';
  }
}

/// Provider for Language Translation
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
      final translation = await _translator.translate(input, to: _selectedLanguage);
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