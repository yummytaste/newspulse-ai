import 'package:flutter/material.dart';

class AppColors {
  // PRIMARY COLORS
  static const Color background = Color(0xFF050816);
  static const Color surface = Color(0xFF0B1023);

  // RED ACCENT
  static const Color primaryRed = Color(0xFFFF3131);
  static const Color glowRed = Color(0xFFFF5A5A);

  // TEXT
  static const Color white = Colors.white;
  static const Color lightText = Color(0xFFB8C1CC);

  // EXTRA
  static const Color cardBorder = Color(0xFF1A2035);
  static const Color darkBlue = Color(0xFF12192F);

  // GRADIENTS
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFFFF3131),
      Color(0xFFFF5A5A),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [
      Color(0xFF050816),
      Color(0xFF0B1023),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}