import 'package:habit_tracker/data/models/habit.dart';
import 'package:habit_tracker/data/models/category.dart'; 

import 'package:hive_flutter/hive_flutter.dart';

class HabitDatabaseService {

  final Box<Habit> _habitsBox = Hive.box<Habit>('habits');
  final Box _completionsBox = Hive.box('completions');
  final Box<Category> _categoriesBox = Hive.box<Category>('categories');

  List<Habit> getAllHabits() {
    return _habitsBox.values.toList();
  }

  Future<void> addHabit(Habit habit) async {
    await _habitsBox.put(habit.id, habit);
  }

  Future<void> updateHabit(Habit habit) async {
    await habit.save();
  }

  Future<void> deleteHabit(Habit habit) async {
    await habit.delete();
  }


  String _getDateKey(DateTime date) {
    return "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> markHabitCompleted(String habitId, DateTime date) async {
    final dateKey = _getDateKey(date);

    final List<String> completionsForDay =
        List<String>.from(_completionsBox.get(dateKey) ?? []);


    if (!completionsForDay.contains(habitId)) {
      completionsForDay.add(habitId);
      await _completionsBox.put(dateKey, completionsForDay);
    }
  }

  Future<void> unmarkHabitCompleted(String habitId, DateTime date) async {
    final dateKey = _getDateKey(date);
    final List<String> completionsForDay =
        List<String>.from(_completionsBox.get(dateKey) ?? []);

    if (completionsForDay.contains(habitId)) {
      completionsForDay.remove(habitId);
      await _completionsBox.put(dateKey, completionsForDay);
    }
  }

  Map<String, List<String>> getAllCompletions() {
    final Map<String, List<String>> allCompletions = {};
    for (var key in _completionsBox.keys) {
      allCompletions[key] = List<String>.from(_completionsBox.get(key));
    }
    return allCompletions;
  }


  List<Category> getAllCategories() {
    return _categoriesBox.values.toList();
  }

  Future<void> addCategory(Category category) async {
    await _categoriesBox.put(category.id, category);
  }

  Future<void> updateCategory(Category category) async {
    await category.save();
  }

  Future<void> deleteCategory(Category category) async {
    final habitsToDelete = _habitsBox.values.where((habit) => habit.categoryId == category.id);
    for (var habit in habitsToDelete) {
      await habit.delete();
    }
    await category.delete();
  }
}