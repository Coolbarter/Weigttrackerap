import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/constants/app_strings.dart';
import '../providers/nutrition_provider.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.nutritionTitle,
          style: AppTypography.headingMedium,
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
      body: Consumer<NutritionProvider>(
        builder: (context, provider, _) => Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Calorie Ring Card ───────────────────────────────────
                  _CalorieCard(provider: provider),
                  const SizedBox(height: AppSpacing.sectionGap),

                  // ── Consistency ─────────────────────────────────────────
                  Row(
                    children: [
                      Text(
                        AppStrings.nutritionConsistency,
                        style: AppTypography.headingMedium,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          AppStrings.nutritionHistory,
                          style: AppTypography.labelLime.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _ConsistencyDots(consistency: provider.weekConsistency),
                  const SizedBox(height: AppSpacing.sectionGap),

                  // ── Today's Meals ───────────────────────────────────────
                  Text(
                    AppStrings.nutritionTodaysMeals,
                    style: AppTypography.headingMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ...provider.meals.map(
                    (m) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppSpacing.itemGap,
                      ),
                      child: _MealCard(meal: m),
                    ),
                  ),

                  // Add dinner if missing
                  if (!provider.hasDinner)
                    _AddMealCard(
                      label: AppStrings.nutritionAddDinner,
                      time: '7:00 PM',
                    ),

                  const SizedBox(height: 120),
                ],
              ),
            ),

            // ── Log Meal Button ─────────────────────────────────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: AppColors.backgroundDark.withValues(alpha: 0.95),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.md,
                  AppSpacing.screenHorizontal,
                  AppSpacing.xxl,
                ),
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Open camera for food photo
                    },
                    icon: const Text('📷', style: TextStyle(fontSize: 18)),
                    label: Text(
                      AppStrings.nutritionLogMeal,
                      style: AppTypography.headingSmall.copyWith(
                        color: AppColors.backgroundDark,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Calorie Ring Card ──────────────────────────────────────────────────────────

class _CalorieCard extends StatelessWidget {
  final NutritionProvider provider;
  const _CalorieCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: AppRadius.xxxlAll,
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          // Ring
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(200, 200),
                  painter: _RingPainter(
                    progress: provider.calorieProgress,
                    trackColor: AppColors.surfaceLighter,
                    progressColor: AppColors.limeAccent,
                    strokeWidth: 14,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      provider.caloriesRemaining.toString(),
                      style: AppTypography.calorieDisplay,
                    ),
                    Text(
                      AppStrings.nutritionKcalRemaining,
                      style: AppTypography.calorieLabel,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLighter,
                        borderRadius: AppRadius.pillAll,
                        border: Border.all(color: AppColors.borderSubtle),
                      ),
                      child: Text(
                        '${AppStrings.nutritionEaten} ${provider.totalCalories} / ${AppStrings.nutritionGoal} ${provider.calorieGoal}',
                        style: AppTypography.caption,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Macro bars
          _MacroBar(
            label: AppStrings.nutritionProtein,
            current: provider.proteinConsumed,
            goal: provider.proteinGoal,
            progress: provider.proteinProgress,
          ),
          const SizedBox(height: AppSpacing.md),
          _MacroBar(
            label: AppStrings.nutritionCarbs,
            current: provider.carbsConsumed,
            goal: provider.carbsGoal,
            progress: provider.carbsProgress,
          ),
          const SizedBox(height: AppSpacing.md),
          _MacroBar(
            label: AppStrings.nutritionFat,
            current: provider.fatConsumed,
            goal: provider.fatGoal,
            progress: provider.fatProgress,
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -math.pi / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, 2 * math.pi, false, trackPaint);
    canvas.drawArc(
      rect,
      startAngle,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}

class _MacroBar extends StatelessWidget {
  final String label;
  final int current;
  final int goal;
  final double progress;

  const _MacroBar({
    required this.label,
    required this.current,
    required this.goal,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTypography.label),
            Text(
              '${current}g / ${goal}g',
              style: AppTypography.label.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: AppRadius.pillAll,
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: AppColors.surfaceLighter,
            valueColor: const AlwaysStoppedAnimation(AppColors.limeAccent),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}

// ── Consistency Dots ───────────────────────────────────────────────────────────

class _ConsistencyDots extends StatelessWidget {
  final List<bool> consistency;
  const _ConsistencyDots({required this.consistency});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().weekday - 1; // 0 = Mon

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final checked = consistency[index];
        final isToday = index == today;

        return Column(
          children: [
            Text(
              AppStrings.daysOfWeek[index],
              style: AppTypography.label.copyWith(
                color: isToday ? AppColors.limeAccent : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: checked ? AppColors.limeAccent : AppColors.surfaceDark,
                border: Border.all(
                  color: isToday
                      ? AppColors.limeAccent
                      : AppColors.borderSubtle,
                  width: isToday ? 2 : 1,
                ),
                boxShadow: checked
                    ? [
                        const BoxShadow(
                          color: AppColors.limeGlow,
                          blurRadius: 10,
                        ),
                      ]
                    : null,
              ),
              child: checked
                  ? const Icon(
                      Icons.check,
                      color: AppColors.backgroundDark,
                      size: 20,
                    )
                  : isToday
                  ? Center(
                      child: Text(
                        DateTime.now().day.toString(),
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.limeAccent,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        );
      }),
    );
  }
}

// ── Meal Card ──────────────────────────────────────────────────────────────────

class _MealCard extends StatelessWidget {
  final Meal meal;
  const _MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: AppRadius.xxlAll,
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Row(
          children: [
            // Photo / icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.surfaceLighter,
                borderRadius: AppRadius.mdAll,
              ),
              child: meal.imagePath != null
                  ? ClipRRect(
                      borderRadius: AppRadius.mdAll,
                      child: Image.asset(meal.imagePath!, fit: BoxFit.cover),
                    )
                  : const Icon(
                      Icons.restaurant_outlined,
                      color: AppColors.textSecondary,
                      size: 22,
                    ),
            ),
            const SizedBox(width: AppSpacing.md),

            // Name + time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: AppTypography.headingSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${meal.mealType} • ${meal.time}',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),

            // Calories
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  meal.calories.toString(),
                  style: AppTypography.headingSmall.copyWith(
                    color: AppColors.limeAccent,
                  ),
                ),
                Text(
                  AppStrings.nutritionKcal,
                  style: AppTypography.label.copyWith(fontSize: 9),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddMealCard extends StatelessWidget {
  final String label;
  final String time;

  const _AddMealCard({required this.label, required this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          borderRadius: AppRadius.xxlAll,
          border: Border.all(
            color: AppColors.limeAccent.withValues(alpha: 0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.limeAccentDim,
                borderRadius: AppRadius.mdAll,
              ),
              child: const Icon(
                Icons.add,
                color: AppColors.limeAccent,
                size: 22,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.headingSmall.copyWith(
                      color: AppColors.limeAccent,
                    ),
                  ),
                  Text(
                    '${AppStrings.nutritionScheduleFor} $time',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
