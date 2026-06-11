import 'package:flutter/material.dart';

class AppColors {
  static const bgPrimary = Color(0xFF07070C);
  static const bgCard = Color(0xFF0F0F16);
  static const bgCard2 = Color(0xFF13131C);

  static const purple = Color(0xFFA855F7);
  static const purpleLight = Color(0xFFC084FC);
  static const pink = Color(0xFFEC4899);
  static const pinkLight = Color(0xFFF472B6);
  static const blue = Color(0xFF3B82F6);
  static const cyan = Color(0xFF06B6D4);
  static const green = Color(0xFF10B981);
  static const orange = Color(0xFFF97316);
  static const red = Color(0xFFEF4444);

  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFF9CA3AF);
  static const textMuted = Color(0xFF6B7280);

  static const borderLight = Color(0x11FFFFFF);
  static const borderPurple = Color(0x22A855F7);
  static const borderPink = Color(0x22EC4899);
  static const borderBlue = Color(0x223B82F6);

  static LinearGradient get purplePinkGradient => const LinearGradient(
        colors: [purple, pink],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get blueCyanGradient => const LinearGradient(
        colors: [blue, cyan],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get orangeRedGradient => const LinearGradient(
        colors: [orange, red],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get greenEmeraldGradient => const LinearGradient(
        colors: [green, Color(0xFF059669)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get textGradient => const LinearGradient(
        colors: [Colors.white, Color(0xFFE9D5FF), Color(0xFFFCE7F3)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static BoxDecoration glassDecoration({
    required Color color,
    double opacity = 0.08,
    double borderOpacity = 0.15,
    double radius = 24,
  }) {
    return BoxDecoration(
      color: color.withOpacity(opacity),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: color.withOpacity(borderOpacity),
        width: 1.5,
      ),
    );
  }
}

class AppSizes {
  static double responsivePadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < 600) return 16;
    if (w < 1024) return 32;
    return 64;
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
}
