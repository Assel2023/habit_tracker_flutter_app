import 'package:hive/hive.dart';
import 'frequency_type.dart'; 
part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int iconCodePoint;

  @HiveField(3)
  late int colorValue;

  @HiveField(4)
  late DateTime createdAt;

  @HiveField(5)
  bool reminderEnabled; 
  @HiveField(6)
  late String? reminderTime; 

  @HiveField(7)
  late FrequencyType frequencyType;

  @HiveField(8)
  late List<int>? frequencyDays;

  @HiveField(9)
  bool isChallenge;

  @HiveField(10)
  int? challengeDuration;

  @HiveField(11)
  late String categoryId; 



  Habit({
    required this.id,
    required this.name,
    required this.iconCodePoint,
    required this.colorValue,
    required this.createdAt,
    required this.categoryId,
    this.reminderEnabled = false, 
    this.reminderTime, 
    this.frequencyType = FrequencyType.daily,
    this.frequencyDays,
    this.isChallenge = false, 
    this.challengeDuration,
    

  });
}
