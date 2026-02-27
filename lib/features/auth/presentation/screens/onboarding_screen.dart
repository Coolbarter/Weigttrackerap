import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  double _goalWeight = 80.0;
  int _weeks = 12;
  int _step = 0; // 0 = welcome, 1 = goal weight, 2 = timeline

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: AppSpacing.xl,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _step == 0
                ? _WelcomeStep(
                    key: const ValueKey(0),
                    onStart: () => setState(() => _step = 1),
                  )
                : _step == 1
                ? _GoalWeightStep(
                    key: const ValueKey(1),
                    goalWeight: _goalWeight,
                    onChanged: (v) => setState(() => _goalWeight = v),
                    onContinue: () => setState(() => _step = 2),
                  )
                : _TimelineStep(
                    key: const ValueKey(2),
                    weeks: _weeks,
                    onChanged: (v) => setState(() => _weeks = v),
                    onComplete: () => context.go(AppRoutes.home),
                  ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeStep extends StatelessWidget {
  final VoidCallback onStart;
  const _WelcomeStep({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          AppStrings.appName,
          style: AppTypography.displayHero.copyWith(
            fontSize: 96,
            color: AppColors.limeAccent,
            letterSpacing: 4,
          ),
        ),
        Text(
          AppStrings.appTagline,
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onStart,
            child: Text(
              AppStrings.onboardingGetStarted,
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.backgroundDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GoalWeightStep extends StatelessWidget {
  final double goalWeight;
  final ValueChanged<double> onChanged;
  final VoidCallback onContinue;

  const _GoalWeightStep({
    super.key,
    required this.goalWeight,
    required this.onChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Text(
          AppStrings.onboardingGoalQuestion,
          style: AppTypography.headingLarge,
        ),
        const SizedBox(height: AppSpacing.xxxl),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                goalWeight.toStringAsFixed(1),
                style: AppTypography.displayHero,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Text(
                  ' kg',
                  style: AppTypography.headingMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Slider(
          value: goalWeight,
          min: 40,
          max: 150,
          divisions: 1100,
          activeColor: AppColors.limeAccent,
          inactiveColor: AppColors.surfaceLighter,
          onChanged: onChanged,
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onContinue,
            child: Text(
              AppStrings.onboardingContinue,
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.backgroundDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TimelineStep extends StatelessWidget {
  final int weeks;
  final ValueChanged<int> onChanged;
  final VoidCallback onComplete;

  const _TimelineStep({
    super.key,
    required this.weeks,
    required this.onChanged,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Text(
          AppStrings.onboardingWeeksQuestion,
          style: AppTypography.headingLarge,
        ),
        const SizedBox(height: AppSpacing.xxxl),
        Center(child: Text('$weeks weeks', style: AppTypography.displayHero)),
        Slider(
          value: weeks.toDouble(),
          min: 4,
          max: 52,
          divisions: 48,
          activeColor: AppColors.limeAccent,
          inactiveColor: AppColors.surfaceLighter,
          onChanged: (v) => onChanged(v.toInt()),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onComplete,
            child: Text(
              AppStrings.onboardingGetStarted,
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.backgroundDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
