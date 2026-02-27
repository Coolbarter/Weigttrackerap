import 'package:flutter/foundation.dart';

class Meal {
  final String id;
  final String name;
  final String mealType;
  final int calories;
  final String? imagePath;
  final String time;

  const Meal({
    required this.id,
    required this.name,
    required this.mealType,
    required this.calories,
    this.imagePath,
    required this.time,
  });
}

class NutritionProvider extends ChangeNotifier {
  List<Meal> _meals = [];
  final int _calorieGoal = 2400;
  final int _proteinGoal = 180;
  final int _carbsGoal = 250;
  final int _fatGoal = 80;
  List<bool> _weekConsistency = List.filled(7, false);

  List<Meal> get meals => List.unmodifiable(_meals);
  int get calorieGoal => _calorieGoal;
  int get proteinGoal => _proteinGoal;
  int get carbsGoal => _carbsGoal;
  int get fatGoal => _fatGoal;
  List<bool> get weekConsistency => List.unmodifiable(_weekConsistency);

  int get totalCalories => _meals.fold(0, (sum, meal) => sum + meal.calories);
  int get caloriesRemaining =>
      (_calorieGoal - totalCalories).clamp(0, _calorieGoal);

  int get proteinConsumed => 95;
  int get carbsConsumed => 124;
  int get fatConsumed => 45;

  double get proteinProgress => proteinConsumed / _proteinGoal;
  double get carbsProgress => carbsConsumed / _carbsGoal;
  double get fatProgress => fatConsumed / _fatGoal;
  double get calorieProgress => totalCalories / _calorieGoal;

  NutritionProvider() {
    _loadMockData();
  }

  void _loadMockData() {
    _weekConsistency = [true, true, true, false, false, false, false];
    _meals = const [
      Meal(
        id: '1',
        name: 'Oatmeal and Berries',
        mealType: 'Breakfast',
        calories: 340,
        time: '8:30 AM',
      ),
      Meal(
        id: '2',
        name: 'Grilled Chicken Salad',
        mealType: 'Lunch',
        calories: 520,
        time: '1:15 PM',
      ),
      Meal(
        id: '3',
        name: 'Greek Yogurt',
        mealType: 'Snack',
        calories: 180,
        time: '4:00 PM',
      ),
    ];
  }

  void addMeal(Meal meal) {
    _meals.add(meal);
    notifyListeners();
  }

  bool get hasDinner => _meals.any((meal) => meal.mealType == 'Dinner');
}
