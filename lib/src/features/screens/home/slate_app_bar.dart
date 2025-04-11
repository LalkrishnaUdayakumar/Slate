import 'package:flutter/material.dart';
import 'package:slate/src/core/constants/app_colors.dart';
import 'package:slate/src/core/constants/app_images.dart';

class SlateAppBar extends StatelessWidget {
  final VoidCallback? onAlertPressed;
  final VoidCallback? onMenuPressed;
  const SlateAppBar({super.key, this.onAlertPressed, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final avatarRadius = screenWidth * 0.07;
    final iconCircleRadius = screenWidth * 0.06;
    final iconSize = screenWidth * 0.06;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.01,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundImage: AssetImage(AppImages.profile),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onAlertPressed,
              child: _buildCircleIcon(
                  Icons.notifications_none, iconCircleRadius, iconSize),
            ),
            SizedBox(width: screenWidth * 0.02),
            GestureDetector(
              onTap: onMenuPressed,
              child: _buildCircleIcon(Icons.menu, iconCircleRadius, iconSize),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon, double radius, double size) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.gray,
      child: Icon(
        icon,
        color: AppColors.textPrimary,
        size: size,
      ),
    );
  }
}


// TODo 
// make the image uploadable and save it