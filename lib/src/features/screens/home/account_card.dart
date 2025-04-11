// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:slate/src/core/constants/app_colors.dart';
import 'package:slate/src/core/constants/app_text_styles.dart';

class AccountsCard extends StatelessWidget {
  static const double _defaultBorderRadius = 25.0;
  static const List<String> _defaultDropdownItems = ['All account'];

  // Required and optional parameters
  final String balanceAmount;
  final String balanceTitle;
  final double balanceChangePercentage;
  final String todayExpenseAmount;
  final double todayExpensePercentage;
  final String weeklyExpenseAmount;
  final double weeklyExpensePercentage;
  final bool showDropdown;
  final String? dropdownValue;
  final List<String> dropdownItems;
  final Function(String?)? onDropdownChanged;
  final EdgeInsets? padding;

  const AccountsCard({
    super.key,
    required this.balanceAmount,
    this.balanceTitle = 'Total Balance',
    this.balanceChangePercentage = 0.0,
    this.todayExpenseAmount = '- ₹0',
    this.todayExpensePercentage = 0.0,
    this.weeklyExpenseAmount = '- ₹0',
    this.weeklyExpensePercentage = 0.0,
    this.showDropdown = true,
    this.dropdownValue,
    this.dropdownItems = _defaultDropdownItems,
    this.onDropdownChanged,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsivePadding = padding ?? EdgeInsets.all(screenWidth * 0.06);
    final outerPadding = EdgeInsets.symmetric(
        horizontal: screenWidth * 0.015, vertical: screenWidth * 0.030);
    final currentDropdownValue = dropdownValue ??
        (dropdownItems.isNotEmpty ? dropdownItems.first : null);

    return Padding(
      padding: outerPadding,
      child: Column(
        children: [
          // Upper Card
          Container(
            padding: responsivePadding,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_defaultBorderRadius),
                topRight: Radius.circular(_defaultBorderRadius),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(screenWidth, currentDropdownValue),
                SizedBox(height: screenWidth * 0.05),
                _buildBalance(screenWidth),
              ],
            ),
          ),

          // Lower Card
          Container(
            padding: responsivePadding,
            decoration: BoxDecoration(
              color: AppColors.lowerCardBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(_defaultBorderRadius),
                bottomRight: Radius.circular(_defaultBorderRadius),
              ),
            ),
            child: _buildExpenseSection(screenWidth),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double screenWidth, String? currentDropdownValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            balanceTitle,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: screenWidth * 0.04,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        if (showDropdown && dropdownItems.isNotEmpty)
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentDropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary),
              items: dropdownItems.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: screenWidth * 0.035,
                      color: AppColors.textPrimary,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onDropdownChanged,
              dropdownColor: AppColors.containerBackground,
              isDense: true,
            ),
          ),
      ],
    );
  }

  Widget _buildBalance(double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            balanceAmount,
            style: AppTextStyles.currencyLarge.copyWith(
              fontSize: screenWidth * 0.090,
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
        _buildChangePercentage(screenWidth),
      ],
    );
  }

  Widget _buildChangePercentage(double screenWidth) {
    final isPositive = balanceChangePercentage >= 0;
    final color = isPositive
        ? AppColors.positiveChangeColor
        : AppColors.negativeChangeColor;
    final icon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;
    final prefix = isPositive ? '+' : '';

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.015,
        vertical: screenWidth * 0.005,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: screenWidth * 0.03, color: color),
          SizedBox(width: screenWidth * 0.01),
          Text(
            '$prefix${balanceChangePercentage.toStringAsFixed(2)}%',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: screenWidth * 0.03,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseSection(double screenWidth) {
    return Row(
      children: [
        Expanded(
          child: _buildExpenseItem(
            title: 'Today\'s Expense',
            amount: todayExpenseAmount,
            percentage: todayExpensePercentage,
            screenWidth: screenWidth,
          ),
        ),
        SizedBox(width: screenWidth * 0.08),
        Expanded(
          child: _buildExpenseItem(
            title: 'Weekly Expense',
            amount: weeklyExpenseAmount,
            percentage: weeklyExpensePercentage,
            screenWidth: screenWidth,
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseItem({
    required String title,
    required String amount,
    required double percentage,
    required double screenWidth,
  }) {
    final isPositive = percentage >= 0;
    final color = isPositive
        ? AppColors.positiveChangeColor
        : AppColors.negativeChangeColor;
    final icon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: screenWidth * 0.03,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Row(
          children: [
            Text(
              amount,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: screenWidth * 0.015),
            Row(
              children: [
                Icon(icon, size: screenWidth * 0.025, color: color),
                SizedBox(width: 1.0),
                Text(
                  '${percentage.abs().toStringAsFixed(1)}%',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: screenWidth * 0.025,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
