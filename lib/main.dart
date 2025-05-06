import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:slate/src/core/theme/app_theme.dart';
import 'package:slate/src/data/model/account.dart';
import 'package:slate/src/data/model/expense.dart';
import 'package:slate/src/data/model/income.dart';
import 'package:slate/src/provider/account_provider.dart';
import 'package:slate/src/provider/expense_provider.dart';
import 'package:slate/src/provider/income_provider.dart';
import 'package:slate/src/routes/app_pages.dart';
import 'package:slate/src/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(IncomeAdapter());

  await Hive.openBox<Account>('accounts');
  await Hive.openBox<Expense>('expenses');
  await Hive.openBox<Income>('incomes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => IncomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Slate',
        theme: AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppRoutes.home,
        routes: AppPages.routes,
      ),
    );
  }
}
