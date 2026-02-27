import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/constants/app_strings.dart';
import '../providers/weight_provider.dart';

class WeightScreen extends StatelessWidget {
  const WeightScreen({super.key});

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
          AppStrings.weightTitle,
          style: AppTypography.label.copyWith(fontSize: 14, letterSpacing: 1.5),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<WeightProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.xl),

                // ── Hero Weight ─────────────────────────────────────────
                _WeightHero(provider: provider),

                const SizedBox(height: AppSpacing.sectionGap),

                // ── Chart ───────────────────────────────────────────────
                _WeightChartSection(provider: provider),

                const SizedBox(height: AppSpacing.sectionGap),

                // ── Week / Month Cards ───────────────────────────────────
                _WeekMonthCards(provider: provider),

                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Consumer<WeightProvider>(
        builder: (context, provider, _) => FloatingActionButton(
          backgroundColor: AppColors.limeAccent,
          foregroundColor: AppColors.backgroundDark,
          onPressed: () => _showLogWeightSheet(context, provider),
          child: const Icon(Icons.add, size: 28),
        ),
      ),
    );
  }

  void _showLogWeightSheet(BuildContext context, WeightProvider provider) {
    double selectedWeight = provider.currentWeight;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary,
                  borderRadius: AppRadius.pillAll,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                AppStrings.weightLogWeight,
                style: AppTypography.headingLarge,
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedWeight.toStringAsFixed(1),
                    style: AppTypography.displayHero,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    provider.unit,
                    style: AppTypography.headingMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Slider(
                value: selectedWeight,
                min: 40,
                max: 200,
                divisions: 1600,
                activeColor: AppColors.limeAccent,
                inactiveColor: AppColors.surfaceLighter,
                onChanged: (v) => setState(() => selectedWeight = v),
              ),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    provider.logWeight(selectedWeight);
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.weightLogWeight,
                    style: AppTypography.headingSmall.copyWith(
                      color: AppColors.backgroundDark,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Weight Hero ────────────────────────────────────────────────────────────────

class _WeightHero extends StatelessWidget {
  final WeightProvider provider;
  const _WeightHero({required this.provider});

  @override
  Widget build(BuildContext context) {
    final change = provider.monthlyChange;
    final isDown = change <= 0;

    return Column(
      children: [
        // Streak badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceLighter,
            borderRadius: AppRadius.pillAll,
            border: Border.all(color: AppColors.borderMedium),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔥', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(
                '${provider.streakDays} ${AppStrings.weightStreakSuffix}',
                style: AppTypography.label.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Big number
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              provider.currentWeight.toStringAsFixed(1),
              style: AppTypography.displayHero,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text(
                ' ${provider.unit}',
                style: AppTypography.headingMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),

        // Change
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${isDown ? '↓' : '↑'} ${change.abs().toStringAsFixed(1)} kg',
              style: AppTypography.headingSmall.copyWith(
                color: isDown ? AppColors.limeAccent : AppColors.warning,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(AppStrings.weightThisMonth, style: AppTypography.bodySmall),
          ],
        ),
      ],
    );
  }
}

// ── Weight Chart ───────────────────────────────────────────────────────────────

class _WeightChartSection extends StatelessWidget {
  final WeightProvider provider;
  const _WeightChartSection({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Period selector
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.weightProgress, style: AppTypography.label),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: AppRadius.lgAll,
                border: Border.all(color: AppColors.borderSubtle),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: WeightChartPeriod.values.map((p) {
                  final label = p == WeightChartPeriod.oneWeek
                      ? AppStrings.weightTab1W
                      : p == WeightChartPeriod.oneMonth
                      ? AppStrings.weightTab1M
                      : AppStrings.weightTab3M;
                  final isActive = provider.period == p;
                  return GestureDetector(
                    onTap: () => provider.setPeriod(p),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.surfaceLighter
                            : Colors.transparent,
                        borderRadius: AppRadius.mdAll,
                      ),
                      child: Text(
                        label,
                        style: AppTypography.label.copyWith(
                          color: isActive
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Chart card
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius: AppRadius.xxlAll,
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            child: _LineChart(provider: provider),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Stat cards
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: AppStrings.weightHighest,
                value: '${provider.highestWeight.toStringAsFixed(1)} kg',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _StatCard(
                label: AppStrings.weightLowest,
                value: '${provider.lowestWeight.toStringAsFixed(1)} kg',
                hasActiveDot: true,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _StatCard(
                label: AppStrings.weightChange,
                value: '${provider.monthlyChange.toStringAsFixed(1)} kg',
                isLime: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LineChart extends StatelessWidget {
  final WeightProvider provider;
  const _LineChart({required this.provider});

  @override
  Widget build(BuildContext context) {
    final entries = provider.chartEntries;
    if (entries.isEmpty) return const SizedBox();

    final minY =
        entries.map((e) => e.weight).reduce((a, b) => a < b ? a : b) - 1;
    final maxY =
        entries.map((e) => e.weight).reduce((a, b) => a > b ? a : b) + 1;
    final goalY = provider.goalWeight;

    final spots = entries
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.weight))
        .toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: AppColors.borderSubtle, strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                final idx = value.toInt();
                if (idx < 0 || idx >= days.length) return const SizedBox();
                return Text(days[idx], style: AppTypography.label);
              },
            ),
          ),
        ),
        minY: minY,
        maxY: maxY,
        // Goal line
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: goalY,
              color: AppColors.chartGoalLine,
              strokeWidth: 1,
              dashArray: [6, 4],
              label: HorizontalLineLabel(
                show: true,
                alignment: Alignment.topRight,
                style: AppTypography.label,
                labelResolver: (line) =>
                    '${AppStrings.weightGoalPrefix} ${goalY.toStringAsFixed(0)}kg',
              ),
            ),
          ],
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.4,
            color: AppColors.limeAccent,
            barWidth: 2.5,
            dotData: FlDotData(
              show: true,
              checkToShowDot: (spot, _) => spot == spots.last,
              getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                radius: 5,
                color: AppColors.surfaceDark,
                strokeWidth: 2.5,
                strokeColor: AppColors.limeAccent,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.chartFillTop, AppColors.chartFillBottom],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isLime;
  final bool hasActiveDot;

  const _StatCard({
    required this.label,
    required this.value,
    this.isLime = false,
    this.hasActiveDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Text(label, style: AppTypography.label),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isLime ? AppColors.limeAccent : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          if (hasActiveDot)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.limeAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: AppColors.limeGlow, blurRadius: 6),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Week/Month Cards ───────────────────────────────────────────────────────────

class _WeekMonthCards extends StatelessWidget {
  final WeightProvider provider;
  const _WeekMonthCards({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TrendCard(
            icon: Icons.trending_down,
            period: AppStrings.weightWeek,
            value: provider.weeklyChange,
            subtitle: AppStrings.weightBeatingAvg,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _TrendCard(
            icon: Icons.calendar_month_outlined,
            period: AppStrings.weightMonth,
            value: provider.monthlyChange,
            subtitle: AppStrings.weightOnTrack,
          ),
        ),
      ],
    );
  }
}

class _TrendCard extends StatelessWidget {
  final IconData icon;
  final String period;
  final double value;
  final String subtitle;

  const _TrendCard({
    required this.icon,
    required this.period,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: AppRadius.xxlAll,
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLighter,
                  borderRadius: AppRadius.mdAll,
                ),
                child: Icon(icon, color: AppColors.textSecondary, size: 20),
              ),
              const Spacer(),
              Text(period, style: AppTypography.label),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value.toStringAsFixed(1),
                style: AppTypography.headingLarge.copyWith(fontSize: 26),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(' kg', style: AppTypography.caption),
              ),
            ],
          ),
          Text(subtitle, style: AppTypography.caption),
        ],
      ),
    );
  }
}
