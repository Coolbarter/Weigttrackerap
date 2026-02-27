import 'package:flutter/foundation.dart';

class ProgressPhoto {
  final String id;
  final String imagePath; // local path or network URL
  final DateTime date;
  final int dayNumber;

  const ProgressPhoto({
    required this.id,
    required this.imagePath,
    required this.date,
    required this.dayNumber,
  });
}

class ProgressProvider extends ChangeNotifier {
  // ── State ─────────────────────────────────────────────────────────────────
  List<ProgressPhoto> _photos = [];
  bool _isLoading = false;
  DateTime? _startDate;
  int _goalDays = 90;

  // ── Getters ───────────────────────────────────────────────────────────────
  List<ProgressPhoto> get photos => List.unmodifiable(_photos);
  bool get isLoading => _isLoading;
  DateTime? get startDate => _startDate;
  int get goalDays => _goalDays;

  ProgressPhoto? get todayPhoto {
    final today = DateTime.now();
    try {
      return _photos.firstWhere(
        (p) =>
            p.date.year == today.year &&
            p.date.month == today.month &&
            p.date.day == today.day,
      );
    } catch (_) {
      return null;
    }
  }

  ProgressPhoto? get latestPhoto => _photos.isNotEmpty ? _photos.first : null;

  int get currentDay {
    if (_startDate == null) return 1;
    return DateTime.now().difference(_startDate!).inDays + 1;
  }

  double get goalProgress => (currentDay / _goalDays).clamp(0.0, 1.0);

  bool get hasLoggedToday => todayPhoto != null;

  // ── Mock data init ────────────────────────────────────────────────────────
  ProgressProvider() {
    _loadMockData();
  }

  void _loadMockData() {
    _startDate = DateTime.now().subtract(const Duration(days: 44));
    _photos = [
      ProgressPhoto(
        id: '1',
        imagePath: 'assets/images/photo_day45.jpg',
        date: DateTime.now(),
        dayNumber: 45,
      ),
      ProgressPhoto(
        id: '2',
        imagePath: 'assets/images/photo_day43.jpg',
        date: DateTime.now().subtract(const Duration(days: 2)),
        dayNumber: 43,
      ),
      ProgressPhoto(
        id: '3',
        imagePath: 'assets/images/photo_day41.jpg',
        date: DateTime.now().subtract(const Duration(days: 4)),
        dayNumber: 41,
      ),
      ProgressPhoto(
        id: '4',
        imagePath: 'assets/images/photo_day39.jpg',
        date: DateTime.now().subtract(const Duration(days: 6)),
        dayNumber: 39,
      ),
      ProgressPhoto(
        id: '5',
        imagePath: 'assets/images/photo_day36.jpg',
        date: DateTime.now().subtract(const Duration(days: 9)),
        dayNumber: 36,
      ),
      ProgressPhoto(
        id: '6',
        imagePath: 'assets/images/photo_day01.jpg',
        date: _startDate!,
        dayNumber: 1,
      ),
    ];
  }

  // ── Actions ───────────────────────────────────────────────────────────────
  Future<void> addPhoto(String imagePath) async {
    _isLoading = true;
    notifyListeners();

    // TODO: Upload to Firebase Storage, save to Firestore
    await Future.delayed(const Duration(milliseconds: 500));

    final newPhoto = ProgressPhoto(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      imagePath: imagePath,
      date: DateTime.now(),
      dayNumber: currentDay,
    );

    _photos.insert(0, newPhoto);
    _isLoading = false;
    notifyListeners();
  }

  void setGoal(int days) {
    _goalDays = days;
    notifyListeners();
  }
}
