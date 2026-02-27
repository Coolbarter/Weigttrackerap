import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../../features/weight/presentation/screens/weight_screen.dart';
import '../../features/nutrition/presentation/screens/nutrition_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../widgets/app_scaffold.dart';

abstract class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String home = '/';
  static const String progress = '/progress';
  static const String weight = '/weight';
  static const String nutrition = '/nutrition';
  static const String profile = '/profile';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProgressScreen()),
        ),
        GoRoute(
          path: AppRoutes.weight,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: WeightScreen()),
        ),
        GoRoute(
          path: AppRoutes.nutrition,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: NutritionScreen()),
        ),
        GoRoute(
          path: AppRoutes.profile,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfileScreen()),
        ),
      ],
    ),
  ],
);
