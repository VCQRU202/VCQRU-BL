// Provider for managing selected game
import 'package:flutter/cupertino.dart';

class RunnerGameProvider with ChangeNotifier {
  String _selectedGame = '';

  String get selectedGame => _selectedGame;

  void selectGame(String game) {
    _selectedGame = game;
    notifyListeners();
  }
}