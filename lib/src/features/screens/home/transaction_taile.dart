import 'package:flutter/material.dart';
import 'package:slate/src/core/constants/app_colors.dart';
import 'package:slate/src/core/constants/app_text_styles.dart';

class TransactionTile extends StatelessWidget {
  final String imagePath; // Asset path
  final String title;
  final String date; // Format like '4 September'
  final String time; // Format like '03:30 pm'
  final String amount; // Preformatted string like '179'
  final bool isExpense; // To determine color of amount

  const TransactionTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.date,
    required this.time,
    required this.amount,
    this.isExpense = true,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final sizeFactor =
        (screenWidth * screenHeight) / (360 * 640); // baseline: 360x640
    final adaptiveFactor = sizeFactor.clamp(0.8, 1.2);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0 * adaptiveFactor,
        vertical: 1.0 * adaptiveFactor,
      ),
      child: Card(
        color: AppColors.surfaceLight,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.0 * adaptiveFactor,
            vertical: 8.0 * adaptiveFactor,
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              width: 48.0 * adaptiveFactor,
              height: 48.0 * adaptiveFactor,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            title,
            style: AppTextStyles.bodyLarge.copyWith(
              fontSize: 14.0 * adaptiveFactor,
            ),
          ),
          subtitle: Text(
            '$date  .  $time', // Date with two spaces between time
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10.0 * adaptiveFactor,
            ),
          ),
          trailing: Text(
            '₹$amount',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 10.0 * adaptiveFactor,
              fontWeight: FontWeight.bold,
              color: isExpense ? AppColors.expenseRed : AppColors.incomeGreen,
            ),
          ),
        ),
      ),
    );
  }
}
