import 'package:flutter/material.dart';

/// All color constants for the FORM fitness app.
/// NO hardcoded colors anywhere else in the codebase — always use this file.
abstract class AppColors {
  // ── Brand ──────────────────────────────────────────────────────────────────
  static const Color limeAccent = Color(0xFFD4FF4E);
  static const Color limeAccentDim = Color(0x26D4FF4E); // 15% opacity
  static const Color limeGlow = Color(0x66D4FF4E); // 40% opacity for shadows

  // ── Backgrounds ────────────────────────────────────────────────────────────
  static const Color backgroundDark = Color(0xFF0F0F13);
  static const Color surfaceDark = Color(0xFF1C1C23);
  static const Color surfaceLighter = Color(0xFF2A2A32);

  // ── Text ───────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8E8E99);
  static const Color textMuted = Color(0xFF55555F);

  // ── Semantic ───────────────────────────────────────────────────────────────
  static const Color success = Color(0xFFD4FF4E);
  static const Color warning = Color(0xFFF5A623);
  static const Color error = Color(0xFFFF453A);
  static const Color errorMuted = Color(0x1AFF453A);

  // ── Borders ────────────────────────────────────────────────────────────────
  static const Color borderSubtle = Color(0x0DFFFFFF); // 5% white
  static const Color borderMedium = Color(0x1AFFFFFF); // 10% white

  // ── Chart ──────────────────────────────────────────────────────────────────
  static const Color chartLine = limeAccent;
  static const Color chartFillTop = Color(0x26D4FF4E);
  static const Color chartFillBottom = Color(0x00D4FF4E);
  static const Color chartGoalLine = Color(0x33FFFFFF);

  // ── Overlay ────────────────────────────────────────────────────────────────
  static const Color overlayDark = Color(
    0xCC000000,
  ); // 80% black for photo overlays
  static const Color overlayMedium = Color(0x66000000);

  // ── Transparent ────────────────────────────────────────────────────────────
  static const Color transparent = Colors.transparent;
}
