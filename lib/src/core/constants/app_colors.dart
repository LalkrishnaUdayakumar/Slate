import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Main colors
  static const Color green = Color(0xFF72FF2F);
  static const Color surface = Color(0xFF121212);
  static const Color gray = Color(0xFF2D2D2D);
  static const Color lightGray = Color(0xFFDADADA);
  static const Color pureWhite = Color(0xFFFFFFFF);

  // App background colors
  static const Color appBackground =
      Color(0xFF000000); // Main app background (darkest)
  static const Color upperCardBackground =
      Color(0xFF121212); // Card upper section (same as surface)
  static const Color lowerCardBackground =
      Color(0xFF1A1A1A); // Card lower section (slightly lighter)
  static const Color buttonBackground =
      Color(0xFF2D2D2D); // Button background (same as gray)

  // Main brand colors
  static const Color primaryTeal = Color(0xFF26A69A);
  static const Color accentCream = Color(0xFFF5F5DC);

  // Light theme colors
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color textDark = Color(0xFF212121);
  static const Color textLight = Color(0xFFE0E0E0);
  static const Color iconColor = Color(0xFF757575);
  static const Color dividerColor = Color(0xFFE0E0E0);

  // Dark theme colors
  static const Color backgroundDark = appBackground;
  static const Color surfaceDark = surface;
  static const Color iconColorDark = Color(0xFFBDBDBD);
  static const Color dividerColorDark = Color(0xFF424242);

  // Expense/Income highlight colors
  static const Color expenseRed = Color(0xFFFF5C5C); // Updated to match design
  static const Color incomeGreen = Color(0xFF81C784);

  // Status colors
  static const Color success = Color(0xFF66BB6A);
  static const Color warning = Color(0xFFFFB74D);
  static const Color error = Color(0xFFE57373);
  static const Color info = Color(0xFF64B5F6);

  // Base/Background Colors
  static const Color background = appBackground; // Updated to the darkest shade
  static const Color surfaceLight = surface;

  // Text Colors
  static const Color textPrimary = pureWhite;
  static const Color textSecondary = Color.fromARGB(255, 180, 179, 179);

  // Accent Colors
  static const Color primaryGreen = green;
  static const Color chatBubbleGreen = incomeGreen;
  static const Color purple = Color(0xFFFF7AD9);
  static const Color blue = Color(0xFF5B9EF5);
  static const Color orange = Color(0xFFFFA336);

  // UI Element Colors
  static const Color containerBackground = gray;
  static const Color negativeRed = Color(0xFFFF5C5C);

  // Chart Colors
  static const Color chartPurple = Color(0xFFD673FF);
  static const Color chartBlue = Color(0xFF73B3FF);

  static const Color positiveChangeColor = AppColors.green;
  static const Color negativeChangeColor = AppColors.negativeRed;
}
