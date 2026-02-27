import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/constants/app_strings.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          AppStrings.profileTitle,
          style: AppTypography.headingMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              AppStrings.profileEdit,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.limeAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, _) {
          final profile = provider.profile;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.xl),

                // ── Avatar ───────────────────────────────────────────────
                CircleAvatar(
                  radius: 44,
                  backgroundColor: AppColors.surfaceLighter,
                  backgroundImage: profile.avatarPath != null
                      ? AssetImage(profile.avatarPath!) as ImageProvider
                      : null,
                  child: profile.avatarPath == null
                      ? const Icon(
                          Icons.person,
                          color: AppColors.textSecondary,
                          size: 44,
                        )
                      : null,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(profile.name, style: AppTypography.headingLarge),
                Text(
                  '${AppStrings.profileMemberSince} ${profile.memberSince}',
                  style: AppTypography.caption,
                ),
                const SizedBox(height: AppSpacing.xxl),

                // ── Stats ────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontal,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          value: profile.photoCount.toString(),
                          label: AppStrings.profilePhotos,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _StatCard(
                          value: profile.daysLogged.toString(),
                          label: AppStrings.profileDays,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _StatCard(
                          value: '${profile.streakDays}',
                          label: AppStrings.profileStreak,
                          isHighlighted: true,
                          suffix: 'd',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // ── Share Button ─────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontal,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Generate share card
                      },
                      icon: const Icon(Icons.ios_share, size: 18),
                      label: Text(
                        AppStrings.profileShareJourney,
                        style: AppTypography.headingSmall.copyWith(
                          color: AppColors.backgroundDark,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sectionGap),

                // ── Settings Section ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontal,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.profileSettings,
                        style: AppTypography.label,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Group 1
                      _SettingsGroup(
                        children: [
                          _SettingsTile(
                            icon: Icons.schedule_outlined,
                            label: AppStrings.profileDailyReminder,
                            trailing: Text(
                              profile.reminderTime,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.limeAccent,
                              ),
                            ),
                            onTap: () {},
                          ),
                          _SettingsTile(
                            icon: Icons.scale_outlined,
                            label: AppStrings.profileWeightUnit,
                            trailing: Text(
                              profile.weightUnit,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.limeAccent,
                              ),
                            ),
                            onTap: () {},
                          ),
                          _SettingsTile(
                            icon: Icons.notifications_outlined,
                            label: AppStrings.profileNotifications,
                            trailing: Switch(
                              value: profile.notificationsEnabled,
                              onChanged: provider.toggleNotifications,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.md),

                      // Group 2
                      _SettingsGroup(
                        children: [
                          _SettingsTile(
                            icon: Icons.star_outline,
                            label: AppStrings.profileRateApp,
                            showChevron: true,
                            onTap: () {},
                          ),
                          _SettingsTile(
                            icon: Icons.restore_outlined,
                            label: AppStrings.profileRestorePurchase,
                            showChevron: true,
                            onTap: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      // Log Out
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            await provider.signOut();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.error,
                          ),
                          child: Text(
                            AppStrings.profileLogOut,
                            style: AppTypography.headingSmall.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ),

                      Center(
                        child: Text(
                          '${AppStrings.profileVersion} 2.4.0',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.massive),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Stat Card ──────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final bool isHighlighted;
  final String? suffix;

  const _StatCard({
    required this.value,
    required this.label,
    this.isHighlighted = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.statCardPadding,
        horizontal: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: AppTypography.displayLarge.copyWith(
                  color: isHighlighted
                      ? AppColors.limeAccent
                      : AppColors.textPrimary,
                ),
              ),
              if (suffix case final String suffixText) ...[
                const SizedBox(width: 4),
                Text(suffixText, style: const TextStyle(fontSize: 20)),
              ],
            ],
          ),
          Text(
            label,
            style: AppTypography.label.copyWith(
              color: isHighlighted
                  ? AppColors.limeAccent
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Settings Group ─────────────────────────────────────────────────────────────

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: AppRadius.xxlAll,
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: children
            .asMap()
            .entries
            .map(
              (e) => Column(
                children: [
                  e.value,
                  if (e.key < children.length - 1)
                    const Divider(height: 1, indent: 56),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    this.trailing,
    this.showChevron = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.xxlAll,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 22),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Text(label, style: AppTypography.bodyLarge)),
            ...[trailing].whereType<Widget>(),
            if (showChevron)
              const Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
