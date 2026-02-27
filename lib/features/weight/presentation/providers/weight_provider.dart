import 'package:flutter/foundation.dart';

class WeightEntry {
  final String id;
  final double weight;
  final DateTime date;

  const WeightEntry({
    required this.id,
    required this.weight,
    required this.date,
  });
}

enum WeightChartPeriod { oneWeek, oneMonth, threeMonths }

class WeightProvider extends ChangeNotifier {
  // ── State ─────────────────────────────────────────────────────────────────
  List<WeightEntry> _entries = [];
  WeightChartPeriod _period = WeightChartPeriod.oneWeek;
  double _goalWeight = 80.0;
  String _unit = 'kg';
  int _streakDays = 7;

  // ── Getters ───────────────────────────────────────────────────────────────
  List<WeightEntry> get entries => List.unmodifiable(_entries);
  WeightChartPeriod get period => _period;
  double get goalWeight => _goalWeight;
  String get unit => _unit;
  int get streakDays => _streakDays;

  double get currentWeight => _entries.isNotEmpty ? _entries.last.weight : 0.0;

  double get highestWeight => _entries.isEmpty
      ? 0.0
      : _entries.map((e) => e.weight).reduce((a, b) => a > b ? a : b);

  double get lowestWeight => _entries.isEmpty
      ? 0.0
      : _entries.map((e) => e.weight).reduce((a, b) => a < b ? a : b);

  double get monthlyChange {
    final monthAgo = DateTime.now().subtract(const Duration(days: 30));
    final monthEntries = _entries
        .where((e) => e.date.isAfter(monthAgo))
        .toList();
    if (monthEntries.length < 2) return 0.0;
    return monthEntries.last.weight - monthEntries.first.weight;
  }

  double get weeklyChange {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final weekEntries = _entries.where((e) => e.date.isAfter(weekAgo)).toList();
    if (weekEntries.length < 2) return 0.0;
    return weekEntries.last.weight - weekEntries.first.weight;
  }

  List<WeightEntry> get chartEntries {
    final now = DateTime.now();
    late DateTime cutoff;
    switch (_period) {
      case WeightChartPeriod.oneWeek:
        cutoff = now.subtract(const Duration(days: 7));
        break;
      case WeightChartPeriod.oneMonth:
        cutoff = now.subtract(const Duration(days: 30));
        break;
      case WeightChartPeriod.threeMonths:
        cutoff = now.subtract(const Duration(days: 90));
        break;
    }
    return _entries.where((e) => e.date.isAfter(cutoff)).toList();
  }

  // ── Init ──────────────────────────────────────────────────────────────────
  WeightProvider() {
    _loadMockData();
  }

  void _loadMockData() {
    final now = DateTime.now();
    _entries = [
      WeightEntry(
        id: '1',
        weight: 84.1,
        date: now.subtract(const Duration(days: 6)),
      ),
      WeightEntry(
        id: '2',
        weight: 83.5,
        date: now.subtract(const Duration(days: 5)),
      ),
      WeightEntry(
        id: '3',
        weight: 83.8,
        date: now.subtract(const Duration(days: 4)),
      ),
      WeightEntry(
        id: '4',
        weight: 83.2,
        date: now.subtract(const Duration(days: 3)),
      ),
      WeightEntry(
        id: '5',
        weight: 82.9,
        date: now.subtract(const Duration(days: 2)),
      ),
      WeightEntry(
        id: '6',
        weight: 82.6,
        date: now.subtract(const Duration(days: 1)),
      ),
      WeightEntry(id: '7', weight: 82.4, date: now),
    ];
  }

  // ── Actions ───────────────────────────────────────────────────────────────
  void setPeriod(WeightChartPeriod period) {
    _period = period;
    notifyListeners();
  }

  Future<void> logWeight(double weight) async {
    // TODO: Save to Firestore
    final entry = WeightEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      weight: weight,
      date: DateTime.now(),
    );
    _entries.add(entry);
    _streakDays++;
    notifyListeners();
  }

  void setGoalWeight(double goal) {
    _goalWeight = goal;
    notifyListeners();
  }

  void setUnit(String unit) {
    _unit = unit;
    notifyListeners();
  }
}
