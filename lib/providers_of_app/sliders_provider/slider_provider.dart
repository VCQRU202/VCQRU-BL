import 'dart:async';
import 'package:flutter/material.dart';

class SliderProvider with ChangeNotifier {
  int _index = 0;
  final List<Color> _colors = [
    Color(0xFFFFDCA9),
    Color(0xFFCDF0EA),
    Color(0xFFFFE6E6)
  ];
  final List<String> _textsTitle = [
    "Anti Counterfeit",
    "Build Loyalty",
    "E-Warranty"
  ];
  final List<String> _texts = [
    "Counterfeit products have far-reaching consequences for both brands and consumers.",
    "Building customer loyalty is the most challenging thing that most businesses face nowadays.",
    "E-warranty services simplify the warranty claim process for customers, manufacturers, & retailers."
  ];

  int get index => _index;
  String get title => _textsTitle[_index];
  String get description => _texts[_index];
  Color get color => _colors[_index];

  void nextSlide() {
    _index = (_index + 1) % 3;
    notifyListeners();
  }

  void startSlider() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      nextSlide();
    });
  }
}
