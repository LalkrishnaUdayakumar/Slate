import 'package:hive_flutter/adapters.dart';

part 'income.g.dart';

@HiveType(typeId: 2)
class Income extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String accountType;

  @HiveField(3)
  String category;

  @HiveField(4)
  String fromWho;

  @HiveField(5)
  String description;

  Income({
    required this.date,
    required this.amount,
    required this.accountType,
    required this.category,
    required this.fromWho,
    required this.description,
  });
}
