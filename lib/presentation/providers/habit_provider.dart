import 'package:flutter/material.dart';
import 'package:habit_tracker/data/models/habit.dart';
import 'package:habit_tracker/data/services/habit_database_service.dart';
import 'package:uuid/uuid.dart';
import 'package:habit_tracker/data/services/notification_service.dart';
import 'package:habit_tracker/data/models/frequency_type.dart';
import 'package:habit_tracker/data/models/category.dart'; // <-- 1. استيراد جديد

class HabitProvider with ChangeNotifier {
  final HabitDatabaseService _dbService = HabitDatabaseService();
  final Uuid _uuid = const Uuid();
  final NotificationService _notificationService = NotificationService();
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  List<Habit> _habits = [];

  Map<String, List<String>> _completions = {};

  List<Habit> get habits => _habits;

  Map<String, List<String>> get completions => _completions;

  HabitProvider() {
    loadData();
  }

  void loadData() {
    _habits = _dbService.getAllHabits();
    _completions = _dbService.getAllCompletions();
    _categories = _dbService.getAllCategories(); // <-- أضف هذا السطر
    
    if (_categories.isEmpty) {
      _createDefaultCategory();
    }
  }

  Future<void> addHabit(
    String name,
    int iconCodePoint,
    int colorValue,
    bool reminderEnabled,
    String? reminderTime, 
    FrequencyType frequencyType, 
    List<int>? frequencyDays, 
    bool isChallenge, 
    int? challengeDuration, 
    String categoryId, 

  ) async {
    final newHabit = Habit(
      id: _uuid.v4(),
      name: name,
      iconCodePoint: iconCodePoint,
      colorValue: colorValue,
      createdAt: DateTime.now(),
      reminderEnabled: reminderEnabled,
      reminderTime: reminderTime,
      frequencyType: frequencyType, 
      frequencyDays: frequencyDays,
      isChallenge: isChallenge, 
      challengeDuration: challengeDuration, 
      categoryId: categoryId, 
   
    );

    await _dbService.addHabit(newHabit);
    _habits.add(newHabit);

    if (reminderEnabled && reminderTime != null) {
      final timeParts = reminderTime.split(':');
      final timeOfDay = TimeOfDay(
          hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));

      final notificationId = newHabit.id.hashCode;

      _notificationService.scheduleDailyNotification(
        id: notificationId,
        title: 'Habit Reminder: $name',
        body: "Don't forget to complete your habit today!",
        notificationTime: timeOfDay,
      );
    }

    notifyListeners();
  }

  Future<void> deleteHabit(Habit habit) async {
    await _dbService.deleteHabit(habit);
    _habits.removeWhere((h) => h.id == habit.id);

    final notificationId = habit.id.hashCode;
    await _notificationService.cancelNotification(notificationId);

    notifyListeners();
  }

  Future<void> toggleCompletion(String habitId, DateTime date) async {
    final dateKey = _getDateKey(date);
    final completionsForDay = List<String>.from(_completions[dateKey] ?? []);

    if (completionsForDay.contains(habitId)) {
      await _dbService.unmarkHabitCompleted(habitId, date);
      completionsForDay.remove(habitId);
    } else {
      await _dbService.markHabitCompleted(habitId, date);
      completionsForDay.add(habitId);
    }

    _completions[dateKey] = completionsForDay;
    notifyListeners();
  }

  bool isHabitCompleted(String habitId, DateTime date) {
    final dateKey = _getDateKey(date);
    return _completions[dateKey]?.contains(habitId) ?? false;
  }

  String _getDateKey(DateTime date) {
    return "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
  }

  int calculateCurrentStreak(String habitId) {
    int currentStreak = 0;
    DateTime today = DateTime.now();
    DateTime dateToCheck = DateTime(today.year, today.month, today.day);

    while (isHabitCompleted(habitId, dateToCheck)) {
      currentStreak++;
      dateToCheck = dateToCheck.subtract(const Duration(days: 1));
    }
    return currentStreak;
  }

  int calculateLongestStreak(String habitId) {
    int longestStreak = 0;
    int currentStreak = 0;

    final habit = _habits.firstWhere((h) => h.id == habitId);
    DateTime startDate = habit.createdAt;
    DateTime today = DateTime.now();

    for (var date = startDate;
        date.isBefore(today.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      if (isHabitCompleted(habitId, date)) {
        currentStreak++;
      } else {
        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
        }
        currentStreak = 0;
      }
    }

    if (currentStreak > longestStreak) {
      longestStreak = currentStreak;
    }

    return longestStreak;
  }

  Future<void> updateHabit(Habit habitToUpdate) async {
    await _dbService.updateHabit(habitToUpdate);

    final index = _habits.indexWhere((h) => h.id == habitToUpdate.id);
    if (index != -1) {
      _habits[index] = habitToUpdate;
      notifyListeners(); 
    }
  }

  bool isHabitActiveToday(Habit habit) {
    final today = DateTime.now();
    final dayOfWeek = today.weekday;

    if (habit.frequencyType == FrequencyType.daily) {
      return true;
    } else if (habit.frequencyType == FrequencyType.specificDays) {
      return habit.frequencyDays?.contains(dayOfWeek) ?? false;
    }
    return false;
  }

  double calculateChallengeProgress(Habit habit) {
    if (!habit.isChallenge ||
        habit.challengeDuration == null ||
        habit.challengeDuration == 0) {
      return 0.0;
    }

    int completionCount = 0;
    _completions.forEach((dateKey, habitIds) {
      if (habitIds.contains(habit.id)) {
        completionCount++;
      }
    });

    double progress = completionCount / habit.challengeDuration!;

    return progress > 1.0 ? 1.0 : progress;
  }

  int get completedHabitsTodayCount {
    final today = DateTime.now();
    int count = 0;
    for (var habit in habitsForToday) {
      if (isHabitCompleted(habit.id, today)) {
        count++;
      }
    }
    return count;
  }

  double get dailyProgressPercentage {
    final totalHabits = habitsForToday.length;
    if (totalHabits == 0) {
      return 0.0;
    }
    return completedHabitsTodayCount / totalHabits;
  }

  List<Habit> get habitsForToday {
    final today = DateTime.now();
    final dayOfWeek = today.weekday;

    return _habits.where((habit) {
      if (habit.frequencyType == FrequencyType.daily) {
        return true;
      } else if (habit.frequencyType == FrequencyType.specificDays) {
        return habit.frequencyDays?.contains(dayOfWeek) ?? false;
      }
      return false;
    }).toList();
  }


  
  Future<void> addCategory(String name, int colorValue) async {
    final newCategory = Category(
      id: _uuid.v4(),
      name: name,
      colorValue: colorValue,
    );
    await _dbService.addCategory(newCategory);
    _categories.add(newCategory);
    notifyListeners();
  }

Future<void> deleteCategory(Category category) async {
  if (category.id == 'general') {
    return;
  }
  _habits.removeWhere((habit) => habit.categoryId == category.id);
  await _dbService.deleteCategory(category);
  _categories.removeWhere((c) => c.id == category.id);
  notifyListeners();
}

  void _createDefaultCategory() async {
    final defaultCategory = Category(
      id: 'general', 
      name: 'General',
      colorValue: Colors.grey.value,
    );
    await _dbService.addCategory(defaultCategory);
    _categories.add(defaultCategory);
    notifyListeners();
  }



  Map<Category, List<Habit>> get groupedHabits {
    final Map<Category, List<Habit>> map = {};
    for (var category in _categories) {
      map[category] = [];
    }
    for (var habit in _habits) {
      final category = _categories.firstWhere(
        (c) => c.id == habit.categoryId,
        orElse: () => _categories.first, 
      );
      map[category]?.add(habit);
    }
    return map;
  }

  Future<void> updateCategory(Category category, String newName, int newColorValue) async {
  category.name = newName;
  category.colorValue = newColorValue;
  await _dbService.updateCategory(category);
  notifyListeners();
}


Map<DateTime, int> get heatmapDataset {
  final Map<DateTime, int> dataset = {};
  _completions.forEach((dateKey, habitIds) {
    final year = int.parse(dateKey.substring(0, 4));
    final month = int.parse(dateKey.substring(4, 6));
    final day = int.parse(dateKey.substring(6, 8));
    final date = DateTime(year, month, day);

    dataset[date] = habitIds.length;
  });
  return dataset;
}

int get totalCompletions {
  int count = 0;
  _completions.forEach((_, habitIds) {
    count += habitIds.length;
  });
  return count;
}

Map<int, double> get weeklyBarChartDataset {
  final Map<int, int> dailyCounts = {}; 
  final Map<int, int> dayOccurrences = {};

  _completions.forEach((dateKey, habitIds) {
    final year = int.parse(dateKey.substring(0, 4));
    final month = int.parse(dateKey.substring(4, 6));
    final day = int.parse(dateKey.substring(6, 8));
    final date = DateTime(year, month, day);
    final dayOfWeek = date.weekday;

    dailyCounts[dayOfWeek] = (dailyCounts[dayOfWeek] ?? 0) + habitIds.length;
    dayOccurrences[dayOfWeek] = (dayOccurrences[dayOfWeek] ?? 0) + 1;
  });
  
  final Map<int, double> averages = {};
  for (int i = 1; i <= 7; i++) {
    if (dailyCounts.containsKey(i)) {
      averages[i] = dailyCounts[i]! / dayOccurrences[i]!;
    } else {
      averages[i] = 0.0;
    }
  }
  return averages;
}


}

