import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier {

  Color _backgroundColor = Colors.white;
  Color get backgroundColor => _backgroundColor;

  double _fontSize = 16.0;
  double get fontSize => _fontSize;

  Color _fontColor = Colors.black;
  Color get fontColor => _fontColor;

  void changeBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  void changeFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }

  void changeFontColor(Color color) {
    _fontColor = color;
    notifyListeners();
  }
}
