// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get myHabits => 'My Habits';

  @override
  String get yourDailyProgress => 'Your Daily Progress';

  @override
  String habitsCompleted(Object count, Object total) {
    return '$count of $total habits completed';
  }

  @override
  String get statistics => 'Statistics';

  @override
  String get manageCategories => 'Manage Categories';

  @override
  String get generalCategory => 'General';

  @override
  String get noHabitsYet => 'No habits yet.\nTap the \"+\" button to add one!';

  @override
  String days(Object daysString) {
    return 'Days: $daysString';
  }

  @override
  String progressComplete(Object progress) {
    return '$progress% complete';
  }

  @override
  String get addHabit => 'Add New Habit';

  @override
  String get editHabit => 'Edit Habit';

  @override
  String get habitName => 'Habit Name';

  @override
  String get enterHabitName => 'Please enter a habit name';

  @override
  String get category => 'Category';

  @override
  String get selectCategory => 'Please select a category';

  @override
  String get chooseAnIcon => 'Choose an Icon';

  @override
  String get chooseAColor => 'Choose a Color';

  @override
  String get advancedSettings => 'Advanced Settings';

  @override
  String get frequency => 'Frequency';

  @override
  String get daily => 'Daily';

  @override
  String get specificDays => 'Specific Days';

  @override
  String get selectAtLeastOneDay => 'Please select at least one day.';

  @override
  String get makeItAChallenge => 'Make it a Challenge';

  @override
  String get setADuration => 'Set a specific duration for this habit.';

  @override
  String get durationInDays => 'Duration (in days)';

  @override
  String get enterADuration => 'Please enter a duration';

  @override
  String get enterAValidNumber => 'Please enter a valid number';

  @override
  String daysSuffix(Object count) {
    return '$count days';
  }

  @override
  String get enableDailyReminder => 'Enable Daily Reminder';

  @override
  String get reminderTime => 'Reminder Time';

  @override
  String get selectTime => 'Select Time';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get saveHabit => 'Save Habit';

  @override
  String get save => 'Save';

  @override
  String get currentStreak => 'Current Streak';

  @override
  String get longestStreak => 'Longest Streak';

  @override
  String get completionHistory => 'Completion History';

  @override
  String get confirmDeletion => 'Confirm Deletion';

  @override
  String deleteConfirmationMessage(Object name) {
    return 'Are you sure you want to delete \"$name\"? This action cannot be undone.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get noCategoriesFound =>
      'No categories found. Add one to get started!';

  @override
  String get addCategory => 'Add Category';

  @override
  String get editCategory => 'Edit Category';

  @override
  String get categoryName => 'Category Name';

  @override
  String get enterACategoryName => 'Please enter a name';

  @override
  String get categoryColor => 'Category Color';

  @override
  String get pickAColor => 'Pick a color';

  @override
  String get done => 'DONE';

  @override
  String get yearlyHeatmap => 'Yearly Heatmap';

  @override
  String get totalCompletions => 'Total Completions';

  @override
  String get weeklyPerformance => 'Weekly Performance';

  @override
  String get onboarding1Title => 'Track Your Daily Goals';

  @override
  String get onboarding1Description =>
      'Turn your big goals into simple daily habits you can easily track.';

  @override
  String get onboarding2Title => 'Discover Your Patterns';

  @override
  String get onboarding2Description =>
      'Get valuable insights with interactive stats and charts that help you understand your strengths and weaknesses.';

  @override
  String get onboarding3Title => 'Design Your Better Journey';

  @override
  String get onboarding3Description =>
      'With advanced customization, you can build a habit system that fits your unique lifestyle and goals.';

  @override
  String get skip => 'SKIP';

  @override
  String get next => 'NEXT';
}
