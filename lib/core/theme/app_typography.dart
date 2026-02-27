import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract class AppTypography {
  static TextStyle get displayHero => GoogleFonts.bebasNeue(
    fontSize: 72,
    height: 1.0,
    letterSpacing: 2,
    color: AppColors.textPrimary,
  );

  static TextStyle get displayLarge => GoogleFonts.bebasNeue(
    fontSize: 48,
    height: 1.0,
    letterSpacing: 1.5,
    color: AppColors.textPrimary,
  );

  static TextStyle get displayMedium => GoogleFonts.bebasNeue(
    fontSize: 36,
    height: 1.1,
    letterSpacing: 1.5,
    color: AppColors.textPrimary,
  );

  static TextStyle get displaySmall => GoogleFonts.bebasNeue(
    fontSize: 24,
    height: 1.1,
    letterSpacing: 1,
    color: AppColors.limeAccent,
  );

  static TextStyle get headingLarge => GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static TextStyle get headingMedium => GoogleFonts.manrope(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  static TextStyle get headingSmall => GoogleFonts.manrope(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyLarge => GoogleFonts.manrope(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyMedium => GoogleFonts.manrope(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodySmall => GoogleFonts.manrope(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get label => GoogleFonts.manrope(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    letterSpacing: 1.2,
  );

  static TextStyle get labelLime => GoogleFonts.manrope(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.limeAccent,
    letterSpacing: 1.2,
  );

  static TextStyle get caption => GoogleFonts.manrope(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get calorieDisplay => GoogleFonts.manrope(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -1,
  );

  static TextStyle get calorieLabel => GoogleFonts.manrope(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.limeAccent,
    letterSpacing: 1.5,
  );
}
