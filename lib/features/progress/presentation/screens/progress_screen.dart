import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/constants/app_strings.dart';
import '../providers/progress_provider.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // ── Header ─────────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenHorizontal,
                      AppSpacing.xl,
                      AppSpacing.screenHorizontal,
                      AppSpacing.sm,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          AppStrings.progressTitle,
                          style: AppTypography.displayMedium,
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            color: AppColors.limeAccent,
                            size: 28,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Day Progress Card ──────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenHorizontal,
                    ),
                    child: Consumer<ProgressProvider>(
                      builder: (context, provider, _) =>
                          _DayProgressCard(provider: provider),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.sectionGap),
                ),

                // ── Latest Check-in ────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenHorizontal,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.progressLatestCheckin,
                          style: AppTypography.label,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Consumer<ProgressProvider>(
                          builder: (context, provider, _) =>
                              _HeroPhotoCard(photo: provider.latestPhoto),
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.sectionGap),
                ),

                // ── History ────────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenHorizontal,
                    ),
                    child: Row(
                      children: [
                        Text(
                          AppStrings.progressHistory,
                          style: AppTypography.label,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            AppStrings.progressViewAll,
                            style: AppTypography.labelLime,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.md),
                ),

                // ── Photo Grid ─────────────────────────────────────────────
                Consumer<ProgressProvider>(
                  builder: (context, provider, _) {
                    final historyPhotos = provider.photos.skip(1).toList();
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenHorizontal,
                      ),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                              _PhotoGridItem(photo: historyPhotos[index]),
                          childCount: historyPhotos.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: AppSpacing.md,
                              mainAxisSpacing: AppSpacing.md,
                              childAspectRatio: 0.6,
                            ),
                      ),
                    );
                  },
                ),

                // Bottom padding for FAB
                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            ),

            // ── Capture Today Button ───────────────────────────────────────
            Positioned(
              bottom: AppSpacing.xxl,
              left: AppSpacing.screenHorizontal,
              right: AppSpacing.screenHorizontal,
              child: _CaptureButton(),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Day Progress Card ──────────────────────────────────────────────────────────

class _DayProgressCard extends StatelessWidget {
  final ProgressProvider provider;

  const _DayProgressCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    final startDateStr = provider.startDate != null
        ? DateFormat('MMM d').format(provider.startDate!)
        : '—';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: AppRadius.xxxlAll,
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${AppStrings.progressDayPrefix} ${provider.currentDay}',
                style: AppTypography.displaySmall,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLighter,
                  borderRadius: AppRadius.pillAll,
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Text(
                  '${provider.photos.length} ${AppStrings.progressPhotosLogged}',
                  style: AppTypography.bodySmall,
                ),
              ),
            ],
          ),
          Text(
            '$startDateStr ${AppStrings.progressStart}',
            style: AppTypography.caption,
          ),
          const SizedBox(height: AppSpacing.md),
          // Progress bar
          ClipRRect(
            borderRadius: AppRadius.pillAll,
            child: LinearProgressIndicator(
              value: provider.goalProgress,
              backgroundColor: AppColors.surfaceLighter,
              valueColor: const AlwaysStoppedAnimation(AppColors.limeAccent),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(provider.goalProgress * 100).toInt()}${AppStrings.progressToGoal}',
              style: AppTypography.label,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Hero Photo Card ────────────────────────────────────────────────────────────

class _HeroPhotoCard extends StatelessWidget {
  final ProgressPhoto? photo;

  const _HeroPhotoCard({required this.photo});

  @override
  Widget build(BuildContext context) {
    final dateStr = photo != null
        ? DateFormat('MMMM d').format(photo!.date).toUpperCase()
        : DateFormat('MMMM d').format(DateTime.now()).toUpperCase();

    return ClipRRect(
      borderRadius: AppRadius.xxxlAll,
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Photo or placeholder
            photo != null
                ? Image.asset(
                    photo!.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceDark,
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.textSecondary,
                        size: 48,
                      ),
                    ),
                  )
                : Container(
                    color: AppColors.surfaceDark,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.limeAccent,
                          size: 48,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Tap below to capture today',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

            // Gradient overlay
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.overlayDark],
                  stops: [0.4, 1.0],
                ),
              ),
            ),

            // TODAY badge
            Positioned(
              top: AppSpacing.lg,
              right: AppSpacing.lg,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.limeAccent,
                  borderRadius: AppRadius.pillAll,
                ),
                child: Text(
                  AppStrings.progressToday,
                  style: AppTypography.label.copyWith(
                    color: AppColors.backgroundDark,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),

            // Date text
            Positioned(
              bottom: AppSpacing.xl,
              left: AppSpacing.xl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dateStr, style: AppTypography.displayMedium),
                  Text(
                    AppStrings.progressMorningCheck,
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

// ── Photo Grid Item ────────────────────────────────────────────────────────────

class _PhotoGridItem extends StatelessWidget {
  final ProgressPhoto photo;

  const _PhotoGridItem({required this.photo});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('MMM d').format(photo.date);
    final isOld = photo.dayNumber <= 10;

    return GestureDetector(
      onTap: () {
        // TODO: Navigate to comparison screen
      },
      child: ClipRRect(
        borderRadius: AppRadius.xxlAll,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image
            ColorFiltered(
              colorFilter: isOld
                  ? const ColorFilter.matrix([
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0.7,
                      0,
                    ])
                  : const ColorFilter.mode(Colors.transparent, BlendMode.color),
              child: Image.asset(
                photo.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: AppColors.surfaceDark),
              ),
            ),

            // Bottom gradient
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.overlayDark],
                  stops: [0.6, 1.0],
                ),
              ),
            ),

            // Day badge
            Positioned(
              top: AppSpacing.md,
              left: AppSpacing.md,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: isOld ? Colors.white : AppColors.limeAccent,
                  borderRadius: AppRadius.smAll,
                ),
                child: Text(
                  '${AppStrings.progressDayPrefix} ${photo.dayNumber}',
                  style: AppTypography.label.copyWith(
                    color: AppColors.backgroundDark,
                    fontSize: 9,
                  ),
                ),
              ),
            ),

            // Date at bottom
            Positioned(
              bottom: AppSpacing.md,
              left: 0,
              right: 0,
              child: Text(
                dateStr,
                textAlign: TextAlign.center,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textPrimary.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Capture Button ─────────────────────────────────────────────────────────────

class _CaptureButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picker = ImagePicker();
        final picked = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 90,
        );
        if (picked != null && context.mounted) {
          context.read<ProgressProvider>().addPhoto(picked.path);
        }
      },
      child: Container(
        height: AppSpacing.captureButtonHeight,
        decoration: BoxDecoration(
          color: AppColors.limeAccent,
          borderRadius: AppRadius.pillAll,
          boxShadow: [
            BoxShadow(
              color: AppColors.limeGlow,
              blurRadius: 30,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('📸', style: TextStyle(fontSize: 22)),
            const SizedBox(width: AppSpacing.md),
            Text(
              AppStrings.progressCaptureToday,
              style: const TextStyle(
                fontFamily: 'BebasNeue',
                fontSize: 22,
                letterSpacing: 1.5,
                color: AppColors.backgroundDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
