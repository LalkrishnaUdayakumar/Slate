import 'package:flutter/material.dart';
import 'package:slate/src/core/constants/app_colors.dart';
import 'package:slate/src/features/screens/home/account_card.dart';
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
    List<String> accountTypes = [
      'All accounts',
      'Savings',
      'Checking',
      'Investments'
    ];

    String selectedAccount = 'All account';
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SlateAppBar(
              onAlertPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SlateStyleGuide()),
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
            )
          ],
        ),
      ),
    );
  }
}
