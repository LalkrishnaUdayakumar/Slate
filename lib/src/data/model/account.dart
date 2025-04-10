import 'package:hive_flutter/adapters.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double currentBalance;

  @HiveField(2)
  double total;

  @HiveField(3)
  double used;

  @HiveField(4)
  double isAdd;

  Account({
    required this.name,
    required this.currentBalance,
    required this.total,
    required this.used,
    required this.isAdd,
  });
}
