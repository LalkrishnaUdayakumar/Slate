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
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final sizeFactor = (screenWidth * screenHeight) / (360 * 640);
    final adaptiveFactor = sizeFactor.clamp(0.8, 1.2);
    final responsivePadding = padding ?? EdgeInsets.all(16.0 * adaptiveFactor);
    final outerPadding = EdgeInsets.symmetric(
        horizontal: 6.0 * adaptiveFactor, vertical: 12.0 * adaptiveFactor);
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
                _buildHeader(context, adaptiveFactor, currentDropdownValue),
                SizedBox(height: 16.0 * adaptiveFactor),
                _buildBalance(context, adaptiveFactor),
                SizedBox(height: 20.0 * adaptiveFactor),
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
            child: _buildExpenseSection(context, adaptiveFactor),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double adaptiveFactor,
      String? currentDropdownValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            balanceTitle,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 14.0 * adaptiveFactor,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        if (showDropdown && dropdownItems.isNotEmpty)
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentDropdownValue,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textSecondary,
                size: 20.0 * adaptiveFactor,
              ),
              items: dropdownItems.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12.0 * adaptiveFactor,
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

  Widget _buildBalance(BuildContext context, double adaptiveFactor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            balanceAmount,
            style: AppTextStyles.currencyLarge.copyWith(
              fontSize: 24.0 * adaptiveFactor,
            ),
          ),
        ),
        SizedBox(width: 8.0 * adaptiveFactor),
        _buildChangePercentage(context, adaptiveFactor),
      ],
    );
  }

  Widget _buildChangePercentage(BuildContext context, double adaptiveFactor) {
    final isPositive = balanceChangePercentage >= 0;
    final color = isPositive
        ? AppColors.positiveChangeColor
        : AppColors.negativeChangeColor;
    final icon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;
    final prefix = isPositive ? '+' : '';

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.0 * adaptiveFactor,
        vertical: 2.0 * adaptiveFactor,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.0 * adaptiveFactor, color: color),
          SizedBox(width: 3.0 * adaptiveFactor),
          Text(
            '$prefix${balanceChangePercentage.toStringAsFixed(2)}%',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10.0 * adaptiveFactor,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseSection(BuildContext context, double adaptiveFactor) {
    return Row(
      children: [
        Expanded(
          child: _buildExpenseItem(
            context: context,
            title: 'Today\'s Expense',
            amount: todayExpenseAmount,
            percentage: todayExpensePercentage,
            adaptiveFactor: adaptiveFactor,
          ),
        ),
        SizedBox(width: 24.0 * adaptiveFactor),
        Expanded(
          child: _buildExpenseItem(
            context: context,
            title: 'Weekly Expense',
            amount: weeklyExpenseAmount,
            percentage: weeklyExpensePercentage,
            adaptiveFactor: adaptiveFactor,
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseItem({
    required BuildContext context,
    required String title,
    required String amount,
    required double percentage,
    required double adaptiveFactor,
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
            fontSize: 11.0 * adaptiveFactor,
          ),
        ),
        SizedBox(height: 6.0 * adaptiveFactor),
        Row(
          children: [
            Text(
              amount,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14.0 * adaptiveFactor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 4.0 * adaptiveFactor),
            Row(
              children: [
                Icon(icon, size: 10.0 * adaptiveFactor, color: color),
                SizedBox(width: 1.0),
                Text(
                  '${percentage.abs().toStringAsFixed(1)}%',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 9.0 * adaptiveFactor,
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
