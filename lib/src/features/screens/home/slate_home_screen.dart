import 'package:flutter/material.dart';
import 'package:slate/src/core/constants/app_colors.dart';
import 'package:slate/src/core/constants/app_images.dart';
import 'package:slate/src/features/components/slate_buttons.dart';
import 'package:slate/src/features/screens/home/account_card.dart';
import 'package:slate/src/features/screens/home/add_expense.dart';
import 'package:slate/src/features/screens/home/transaction_taile.dart';
import 'package:slate/src/features/screens/slate_style_guide.dart';

import 'slate_app_bar.dart';

class SlateHomeScreen extends StatefulWidget {
  const SlateHomeScreen({super.key});

  @override
  State<SlateHomeScreen> createState() => _SlateHomeScreenState();
}

class _SlateHomeScreenState extends State<SlateHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final sizeFactor =
        (screenWidth * screenHeight) / (360 * 640); // baseline: 360x640
    final adaptiveFactor = sizeFactor.clamp(0.8, 1.2);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SlateAppBar(
              onAlertPressed: () {
                Navigator.push(
                  context,
                  // MaterialPageRoute(builder: (context) => SlateStyleGuide()),
                  MaterialPageRoute(builder: (context) => ExpenseApp()),
                );
              },
            ),
            // Without dropdown
            AccountsCard(
              balanceAmount: '₹45,678.90',
              balanceChangePercentage: 2.5,
              todayExpenseAmount: '- ₹1,234.56',
              todayExpensePercentage: -3.2,
              weeklyExpenseAmount: '- ₹6,789.12',
              weeklyExpensePercentage: 1.8,
              dropdownItems: ['All account', 'Savings', 'Checking'],
              onDropdownChanged: (value) {},
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0 * adaptiveFactor,
                      vertical: 10.0 * adaptiveFactor,
                    ),
                    child: SlateButton(
                      borderColor: AppColors.green,
                      textColor: AppColors.pureWhite,
                      text: 'add expense',
                      fontSize: 12,
                      icon: Icons.add_box,
                      type: SlateButtonType.outline,
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0 * adaptiveFactor,
                      vertical: 10.0 * adaptiveFactor,
                    ),
                    child: SlateButton(
                      borderColor: AppColors.chartBlue,
                      textColor: AppColors.chartBlue,
                      text: 'add',
                      icon: Icons.add_box,
                      type: SlateButtonType.outline,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0 * adaptiveFactor,
                  vertical: 10.0 * adaptiveFactor,
                ),
                child: Text(
                  'Recent Transactions',
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TransactionTile(
                      imagePath: AppImages.profile,
                      title: 'Shopping',
                      date: '4 September',
                      time: '03:30 pm',
                      amount: '179',
                      isExpense: true,
                    ),
                    TransactionTile(
                      imagePath: AppImages.chaya,
                      title: 'Shopping',
                      date: '4 September',
                      time: '03:30 pm',
                      amount: '179',
                      isExpense: true,
                    ),
                    TransactionTile(
                      imagePath: AppImages.bike,
                      title: 'Shopping',
                      date: '4 September',
                      time: '03:30 pm',
                      amount: '179',
                      isExpense: true,
                    ),
                    TransactionTile(
                      imagePath: AppImages.petrol,
                      title: 'Shopping',
                      date: '4 September',
                      time: '03:30 pm',
                      amount: '179',
                      isExpense: true,
                    ),
                    TransactionTile(
                      imagePath: AppImages.profile,
                      title: 'Shopping',
                      date: '4 September',
                      time: '03:30 pm',
                      amount: '179',
                      isExpense: true,
                    ),
                    TransactionTile(
                      imagePath: AppImages.profile,
                      title: 'Shopping',
                      date: '4 September',
                      time: '03:30 pm',
                      amount: '179',
                      isExpense: true,
                    ),
                    TransactionTile(
                      imagePath: AppImages.profile,
                      title: 'Shopping',
                      date: '4 September',
                      time: '03:30 pm',
                      amount: '179',
                      isExpense: true,
                    ),
                    TransactionTile(
                      imagePath: AppImages.profile,
                      title: 'Shopping',
                      date: '4 September',
                      time: '03:30 pm',
                      amount: '179',
                      isExpense: true,
                    ),
                    TransactionTile(
                      imagePath: AppImages.profile,
                      title: 'Shopping',
                      date: '4 September',
                      time: '03:30 pm',
                      amount: '179',
                      isExpense: true,
                    ),
                    TransactionTile(
                      imagePath: AppImages.profile,
                      title: 'Shopping',
                      date: '4 September',
                      time: '03:30 pm',
                      amount: '179',
                      isExpense: true,
                    ),
                    TransactionTile(
                      imagePath: AppImages.profile,
                      title: 'Shopping',
                      date: '4 September',
                      time: '03:30 pm',
                      amount: '179',
                      isExpense: true,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
