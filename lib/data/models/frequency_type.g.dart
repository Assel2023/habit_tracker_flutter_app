part of 'frequency_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FrequencyTypeAdapter extends TypeAdapter<FrequencyType> {
  @override
  final int typeId = 1;

  @override
  FrequencyType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FrequencyType.daily;
      case 1:
        return FrequencyType.specificDays;
      default:
        return FrequencyType.daily;
    }
  }

  @override
  void write(BinaryWriter writer, FrequencyType obj) {
    switch (obj) {
      case FrequencyType.daily:
        writer.writeByte(0);
        break;
      case FrequencyType.specificDays:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrequencyTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
