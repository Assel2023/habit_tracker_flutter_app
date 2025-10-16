import 'package:hive/hive.dart';

part 'frequency_type.g.dart'; 

@HiveType(typeId: 1)
enum FrequencyType {
  @HiveField(0)
  daily,

  @HiveField(1)
  specificDays,
}