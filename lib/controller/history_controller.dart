import 'package:flutter/material.dart';

class NumberHistoryEntry {
  NumberHistoryEntry({
    required this.number,
    required this.checkedAt,
    this.isFavorite = false,
  });

  final int number;
  final DateTime checkedAt;
  bool isFavorite;
}

class HistoryController extends ChangeNotifier {
  final List<NumberHistoryEntry> _entries = [];

  List<NumberHistoryEntry> get entries => List.unmodifiable(_entries);

  void addEntry(int number) {
    _entries.insert(
      0,
      NumberHistoryEntry(number: number, checkedAt: DateTime.now()),
    );
    if (_entries.length > 20) {
      _entries.removeLast();
    }
    notifyListeners();
  }

  void toggleFavorite(NumberHistoryEntry entry) {
    entry.isFavorite = !entry.isFavorite;
    notifyListeners();
  }

  void clearHistory() {
    _entries.clear();
    notifyListeners();
  }
}
