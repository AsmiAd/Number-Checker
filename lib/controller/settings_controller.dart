import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends ChangeNotifier {
  SettingsController._();

  static const _backgroundColorKey = 'background_color';
  static const _fontColorKey = 'font_color';
  static const _fontSizeKey = 'font_size';

  Color _backgroundColor = Colors.white;
  Color get backgroundColor => _backgroundColor;

  double _fontSize = 16.0;
  double get fontSize => _fontSize;

  Color _fontColor = Colors.black;
  Color get fontColor => _fontColor;

  static Future<SettingsController> create() async {
    final controller = SettingsController._();
    await controller._loadSettings();
    return controller;
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    _backgroundColor = Color(
      prefs.getInt(_backgroundColorKey) ?? Colors.white.toARGB32(),
    );
    _fontColor = Color(
      prefs.getInt(_fontColorKey) ?? Colors.black.toARGB32(),
    );
    _fontSize = (prefs.getDouble(_fontSizeKey) ?? 16.0).clamp(12.0, 30.0);
  }

  Future<void> changeBackgroundColor(Color color) async {
    if (_backgroundColor == color) return;
    _backgroundColor = color;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_backgroundColorKey, color.toARGB32());
  }

  Future<void> changeFontSize(double size) async {
    final normalizedSize = size.clamp(12.0, 30.0);
    if (_fontSize == normalizedSize) return;

    _fontSize = normalizedSize;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, normalizedSize);
  }

  Future<void> changeFontColor(Color color) async {
    if (_fontColor == color) return;
    _fontColor = color;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_fontColorKey, color.toARGB32());
  }
}
