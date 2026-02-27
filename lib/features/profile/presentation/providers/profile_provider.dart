import 'package:flutter/foundation.dart';

class UserProfile {
  final String name;
  final String memberSince;
  final String? avatarPath;
  final int photoCount;
  final int daysLogged;
  final int streakDays;
  final String reminderTime;
  final String weightUnit;
  final bool notificationsEnabled;

  const UserProfile({
    required this.name,
    required this.memberSince,
    this.avatarPath,
    required this.photoCount,
    required this.daysLogged,
    required this.streakDays,
    required this.reminderTime,
    required this.weightUnit,
    required this.notificationsEnabled,
  });

  UserProfile copyWith({
    String? name,
    String? memberSince,
    String? avatarPath,
    int? photoCount,
    int? daysLogged,
    int? streakDays,
    String? reminderTime,
    String? weightUnit,
    bool? notificationsEnabled,
  }) {
    return UserProfile(
      name: name ?? this.name,
      memberSince: memberSince ?? this.memberSince,
      avatarPath: avatarPath ?? this.avatarPath,
      photoCount: photoCount ?? this.photoCount,
      daysLogged: daysLogged ?? this.daysLogged,
      streakDays: streakDays ?? this.streakDays,
      reminderTime: reminderTime ?? this.reminderTime,
      weightUnit: weightUnit ?? this.weightUnit,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

class ProfileProvider extends ChangeNotifier {
  UserProfile _profile = const UserProfile(
    name: 'Alex Johnson',
    memberSince: 'Jan 2023',
    photoCount: 142,
    daysLogged: 89,
    streakDays: 12,
    reminderTime: '2:00 PM',
    weightUnit: 'kg',
    notificationsEnabled: true,
  );

  UserProfile get profile => _profile;

  void toggleNotifications(bool value) {
    _profile = _profile.copyWith(notificationsEnabled: value);
    notifyListeners();
  }

  void setWeightUnit(String unit) {
    _profile = _profile.copyWith(weightUnit: unit);
    notifyListeners();
  }

  void setReminderTime(String time) {
    _profile = _profile.copyWith(reminderTime: time);
    notifyListeners();
  }

  Future<void> signOut() async {
    // TODO: Firebase signOut
  }
}
