import 'package:flutter/material.dart';
import 'package:slate/src/core/constants/app_colors.dart';
import 'package:slate/src/core/constants/app_text_styles.dart';

enum SlateButtonType {
  primary,
  secondary,
  outline,
  custom,
}

class SlateButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final SlateButtonType type;
  final bool isFullWidth;
  final double height;
  final double? width;
  final double borderRadius;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const SlateButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = SlateButtonType.primary,
    this.isFullWidth = false,
    this.height = 48.0,
    this.width,
    this.borderRadius = 8.0,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    // Get adaptive factor for responsive sizing
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final sizeFactor = (screenWidth * screenHeight) / (360 * 640);
    final adaptiveFactor = sizeFactor.clamp(0.8, 1.2);

    // Configure colors based on button type
    Color bgColor;
    Color txtColor;
    Color bdColor;

    switch (type) {
      case SlateButtonType.primary:
        bgColor = backgroundColor ?? AppColors.green;
        txtColor = textColor ?? AppColors.appBackground;
        bdColor = borderColor ?? Colors.transparent;
        break;
      case SlateButtonType.secondary:
        bgColor = backgroundColor ?? AppColors.gray;
        txtColor = textColor ?? AppColors.textPrimary;
        bdColor = borderColor ?? Colors.transparent;
        break;
      case SlateButtonType.outline:
        bgColor = backgroundColor ?? Colors.transparent;
        txtColor = textColor ?? AppColors.green;
        bdColor = borderColor ?? AppColors.green;
        break;
      case SlateButtonType.custom:
        bgColor = backgroundColor ?? AppColors.green;
        txtColor = textColor ?? AppColors.textPrimary;
        bdColor = borderColor ?? Colors.transparent;
        break;
    }

    // Build the button
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height * adaptiveFactor,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: txtColor,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: 20.0 * adaptiveFactor,
            vertical: 12.0 * adaptiveFactor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: bdColor),
          ),
        ),
        child: Row(
          mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20.0 * adaptiveFactor),
              SizedBox(width: 8.0 * adaptiveFactor),
            ],
            Text(
              text,
              style: AppTextStyles.buttonText.copyWith(
                color: txtColor,
                fontSize: (fontSize ?? 16.0) * adaptiveFactor,
                fontWeight: fontWeight ?? FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// button use case example

/*
 SlateButton(
                  text: 'Primary Button',
                  onPressed: () {
                    print('Primary button pressed');
                  },
                ),
                const SizedBox(height: 16),
                
                // Secondary Button
                SlateButton(
                  text: 'Secondary Button',
                  type: SlateButtonType.secondary,
                  onPressed: () {
                    print('Secondary button pressed');
                  },
                ),
                const SizedBox(height: 16),
                
                // Outline Button
                SlateButton(
                  text: 'Outline Button',
                  type: SlateButtonType.outline,
                  onPressed: () {
                    print('Outline button pressed');
                  },
                ),
                const SizedBox(height: 30),
                
                const Text(
                  'Custom Sizes & Shapes',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                
                // Custom Height & Width Button
                SlateButton(
                  text: 'Custom Size',
                  height: 60.0,
                  width: 200.0,
                  onPressed: () {
                    print('Custom size button pressed');
                  },
                ),
                const SizedBox(height: 16),
                
                // Custom Border Radius Button
                SlateButton(
                  text: 'Rounded Button',
                  borderRadius: 25.0,
                  onPressed: () {
                    print('Rounded button pressed');
                  },
                ),
                const SizedBox(height: 16),
                
                // Full Width Button
                SlateButton(
                  text: 'Full Width Button',
                  isFullWidth: true,
                  onPressed: () {
                    print('Full width button pressed');
                  },
                ),
                const SizedBox(height: 30),
                
                const Text(
                  'Custom Colors & Styling',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                
                // Button with Icon
                SlateButton(
                  text: 'Button with Icon',
                  icon: Icons.add,
                  onPressed: () {
                    print('Icon button pressed');
                  },
                ),
                const SizedBox(height: 16),
                
                // Custom colors button
                SlateButton(
                  text: 'Custom Colors',
                  type: SlateButtonType.custom,
                  backgroundColor: Colors.purple,
                  textColor: Colors.white,
                  borderColor: Colors.purpleAccent,
                  onPressed: () {
                    print('Custom colors button pressed');
                  },
                ),
                const SizedBox(height: 16),
                
                // Custom text style button
                SlateButton(
                  text: 'Different Font Size',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  type: SlateButtonType.secondary,
                  onPressed: () {
                    print('Custom text style button pressed');
                  },
                ),
*/
