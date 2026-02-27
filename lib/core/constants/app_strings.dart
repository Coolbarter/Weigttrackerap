/// All user-facing strings. No hardcoded strings elsewhere.
abstract class AppStrings {
  // ── App ───────────────────────────────────────────────────────────────────
  static const String appName = 'FORM';
  static const String appTagline = 'Track. Progress. Transform.';

  // ── Bottom Nav ────────────────────────────────────────────────────────────
  static const String navHome = 'Home';
  static const String navDiary = 'Diary';
  static const String navProgress = 'Progress';
  static const String navStats = 'Stats';
  static const String navProfile = 'Profile';

  // ── Progress Screen ───────────────────────────────────────────────────────
  static const String progressTitle = 'MY PROGRESS';
  static const String progressLatestCheckin = 'LATEST CHECK-IN';
  static const String progressHistory = 'HISTORY';
  static const String progressViewAll = 'View All';
  static const String progressCaptureToday = 'CAPTURE TODAY';
  static const String progressPhotosLogged = 'photos logged';
  static const String progressToGoal = '% TO GOAL';
  static const String progressDayPrefix = 'DAY';
  static const String progressStart = 'Start';
  static const String progressToday = 'TODAY';
  static const String progressMorningCheck = 'Morning Physique Check';

  // ── Weight Screen ─────────────────────────────────────────────────────────
  static const String weightTitle = 'WEIGHT ANALYTICS';
  static const String weightProgress = 'PROGRESS';
  static const String weightHighest = 'HIGHEST';
  static const String weightLowest = 'LOWEST';
  static const String weightChange = 'CHANGE';
  static const String weightWeek = 'WEEK';
  static const String weightMonth = 'MONTH';
  static const String weightGoalPrefix = 'GOAL:';
  static const String weightThisMonth = 'this month';
  static const String weightBeatingAvg = 'Beating avg';
  static const String weightOnTrack = 'On track';
  static const String weightTab1W = '1W';
  static const String weightTab1M = '1M';
  static const String weightTab3M = '3M';
  static const String weightLogWeight = 'Log Weight';
  static const String weightUnitKg = 'kg';
  static const String weightUnitLbs = 'lbs';
  static const String weightStreakSuffix = 'Day Streak';

  // ── Nutrition Screen ──────────────────────────────────────────────────────
  static const String nutritionTitle = 'Nutrition';
  static const String nutritionKcalRemaining = 'KCAL REMAINING';
  static const String nutritionEaten = 'Eaten:';
  static const String nutritionGoal = 'Goal:';
  static const String nutritionProtein = 'PROTEIN';
  static const String nutritionCarbs = 'CARBS';
  static const String nutritionFat = 'FAT';
  static const String nutritionConsistency = 'Consistency';
  static const String nutritionHistory = 'History';
  static const String nutritionTodaysMeals = "Today's Meals";
  static const String nutritionLogMeal = 'LOG A MEAL';
  static const String nutritionAddBreakfast = '+ Add Breakfast';
  static const String nutritionAddLunch = '+ Add Lunch';
  static const String nutritionAddDinner = '+ Add Dinner';
  static const String nutritionAddSnack = '+ Add Snack';
  static const String nutritionScheduleFor = 'Schedule for';
  static const String nutritionKcal = 'kcal';

  // ── Days of week ──────────────────────────────────────────────────────────
  static const List<String> daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  // ── Profile Screen ────────────────────────────────────────────────────────
  static const String profileTitle = 'Profile';
  static const String profileEdit = 'Edit';
  static const String profilePhotos = 'PHOTOS';
  static const String profileDays = 'DAYS';
  static const String profileStreak = 'STREAK';
  static const String profileShareJourney = 'Share My Journey';
  static const String profileSettings = 'SETTINGS';
  static const String profileDailyReminder = 'Daily Reminder';
  static const String profileWeightUnit = 'Weight Unit';
  static const String profileNotifications = 'Notifications';
  static const String profileRateApp = 'Rate App';
  static const String profileRestorePurchase = 'Restore Purchase';
  static const String profileLogOut = 'Log Out';
  static const String profileMemberSince = 'Member since';
  static const String profileVersion = 'Version';

  // ── Onboarding ────────────────────────────────────────────────────────────
  static const String onboardingWelcome = 'Welcome to FORM';
  static const String onboardingSubtitle = 'Your daily fitness ritual';
  static const String onboardingGetStarted = 'Get Started';
  static const String onboardingGoalQuestion = 'What\'s your goal weight?';
  static const String onboardingWeeksQuestion =
      'How many weeks is your timeline?';
  static const String onboardingContinue = 'Continue';
  static const String onboardingSkip = 'Skip';

  // ── Errors ────────────────────────────────────────────────────────────────
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNoInternet = 'No internet connection.';
}
