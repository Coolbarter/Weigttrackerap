import 'package:flutter/material.dart';

/// Spacing scale used across the app.
abstract class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 48.0;
  static const double massive = 64.0;

  static const double screenHorizontal = 20.0;
  static const double screenVertical = 16.0;
  static const double bottomNavHeight = 80.0;
  static const double captureButtonHeight = 72.0;
  static const double statCardPadding = 16.0;
  static const double cardPadding = 20.0;
  static const double sectionGap = 24.0;
  static const double itemGap = 12.0;
}

/// Shared shadow presets.
abstract class AppShadows {
  static List<BoxShadow> get limeGlow => const [
    BoxShadow(color: Color(0x66D4FF4E), blurRadius: 20, spreadRadius: 0),
  ];

  static List<BoxShadow> get limeSoft => const [
    BoxShadow(color: Color(0x33D4FF4E), blurRadius: 12, spreadRadius: 0),
  ];

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
}
