import 'package:hive_flutter/adapters.dart';

part 'expense.g.dart';

@HiveType(typeId: 1)
class Expense extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String accountType;

  @HiveField(3)
  String category;

  @HiveField(4)
  String toWho;

  @HiveField(5)
  String description;

  Expense({
    required this.date,
    required this.amount,
    required this.accountType,
    required this.category,
    required this.toWho,
    required this.description,
  });
}
