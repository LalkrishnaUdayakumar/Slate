// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IncomeAdapter extends TypeAdapter<Income> {
  @override
  final int typeId = 2;

  @override
  Income read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Income(
      date: fields[0] as DateTime,
      amount: fields[1] as double,
      accountType: fields[2] as String,
      category: fields[3] as String,
      fromWho: fields[4] as String,
      description: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Income obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.accountType)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.fromWho)
      ..writeByte(5)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
