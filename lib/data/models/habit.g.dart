
part of 'habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 0;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit(
      id: fields[0] as String,
      name: fields[1] as String,
      iconCodePoint: fields[2] as int,
      colorValue: fields[3] as int,
      createdAt: fields[4] as DateTime,
      categoryId: fields[11] as String,
      reminderEnabled: fields[5] as bool,
      reminderTime: fields[6] as String?,
      frequencyType: fields[7] as FrequencyType,
      frequencyDays: (fields[8] as List?)?.cast<int>(),
      isChallenge: fields[9] as bool,
      challengeDuration: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.iconCodePoint)
      ..writeByte(3)
      ..write(obj.colorValue)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.reminderEnabled)
      ..writeByte(6)
      ..write(obj.reminderTime)
      ..writeByte(7)
      ..write(obj.frequencyType)
      ..writeByte(8)
      ..write(obj.frequencyDays)
      ..writeByte(9)
      ..write(obj.isChallenge)
      ..writeByte(10)
      ..write(obj.challengeDuration)
      ..writeByte(11)
      ..write(obj.categoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
