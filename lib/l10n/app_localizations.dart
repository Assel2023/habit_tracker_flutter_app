import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @myHabits.
  ///
  /// In en, this message translates to:
  /// **'My Habits'**
  String get myHabits;

  /// No description provided for @yourDailyProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Daily Progress'**
  String get yourDailyProgress;

  /// No description provided for @habitsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{count} of {total} habits completed'**
  String habitsCompleted(Object count, Object total);

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @manageCategories.
  ///
  /// In en, this message translates to:
  /// **'Manage Categories'**
  String get manageCategories;

  /// No description provided for @generalCategory.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get generalCategory;

  /// No description provided for @noHabitsYet.
  ///
  /// In en, this message translates to:
  /// **'No habits yet.\nTap the \"+\" button to add one!'**
  String get noHabitsYet;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days: {daysString}'**
  String days(Object daysString);

  /// No description provided for @progressComplete.
  ///
  /// In en, this message translates to:
  /// **'{progress}% complete'**
  String progressComplete(Object progress);

  /// No description provided for @addHabit.
  ///
  /// In en, this message translates to:
  /// **'Add New Habit'**
  String get addHabit;

  /// No description provided for @editHabit.
  ///
  /// In en, this message translates to:
  /// **'Edit Habit'**
  String get editHabit;

  /// No description provided for @habitName.
  ///
  /// In en, this message translates to:
  /// **'Habit Name'**
  String get habitName;

  /// No description provided for @enterHabitName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a habit name'**
  String get enterHabitName;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get selectCategory;

  /// No description provided for @chooseAnIcon.
  ///
  /// In en, this message translates to:
  /// **'Choose an Icon'**
  String get chooseAnIcon;

  /// No description provided for @chooseAColor.
  ///
  /// In en, this message translates to:
  /// **'Choose a Color'**
  String get chooseAColor;

  /// No description provided for @advancedSettings.
  ///
  /// In en, this message translates to:
  /// **'Advanced Settings'**
  String get advancedSettings;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @specificDays.
  ///
  /// In en, this message translates to:
  /// **'Specific Days'**
  String get specificDays;

  /// No description provided for @selectAtLeastOneDay.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one day.'**
  String get selectAtLeastOneDay;

  /// No description provided for @makeItAChallenge.
  ///
  /// In en, this message translates to:
  /// **'Make it a Challenge'**
  String get makeItAChallenge;

  /// No description provided for @setADuration.
  ///
  /// In en, this message translates to:
  /// **'Set a specific duration for this habit.'**
  String get setADuration;

  /// No description provided for @durationInDays.
  ///
  /// In en, this message translates to:
  /// **'Duration (in days)'**
  String get durationInDays;

  /// No description provided for @enterADuration.
  ///
  /// In en, this message translates to:
  /// **'Please enter a duration'**
  String get enterADuration;

  /// No description provided for @enterAValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get enterAValidNumber;

  /// No description provided for @daysSuffix.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String daysSuffix(Object count);

  /// No description provided for @enableDailyReminder.
  ///
  /// In en, this message translates to:
  /// **'Enable Daily Reminder'**
  String get enableDailyReminder;

  /// No description provided for @reminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder Time'**
  String get reminderTime;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @saveHabit.
  ///
  /// In en, this message translates to:
  /// **'Save Habit'**
  String get saveHabit;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get currentStreak;

  /// No description provided for @longestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest Streak'**
  String get longestStreak;

  /// No description provided for @completionHistory.
  ///
  /// In en, this message translates to:
  /// **'Completion History'**
  String get completionHistory;

  /// No description provided for @confirmDeletion.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get confirmDeletion;

  /// No description provided for @deleteConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"? This action cannot be undone.'**
  String deleteConfirmationMessage(Object name);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @noCategoriesFound.
  ///
  /// In en, this message translates to:
  /// **'No categories found. Add one to get started!'**
  String get noCategoriesFound;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategory;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategory;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryName;

  /// No description provided for @enterACategoryName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get enterACategoryName;

  /// No description provided for @categoryColor.
  ///
  /// In en, this message translates to:
  /// **'Category Color'**
  String get categoryColor;

  /// No description provided for @pickAColor.
  ///
  /// In en, this message translates to:
  /// **'Pick a color'**
  String get pickAColor;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get done;

  /// No description provided for @yearlyHeatmap.
  ///
  /// In en, this message translates to:
  /// **'Yearly Heatmap'**
  String get yearlyHeatmap;

  /// No description provided for @totalCompletions.
  ///
  /// In en, this message translates to:
  /// **'Total Completions'**
  String get totalCompletions;

  /// No description provided for @weeklyPerformance.
  ///
  /// In en, this message translates to:
  /// **'Weekly Performance'**
  String get weeklyPerformance;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Track Your Daily Goals'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Description.
  ///
  /// In en, this message translates to:
  /// **'Turn your big goals into simple daily habits you can easily track.'**
  String get onboarding1Description;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Discover Your Patterns'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Description.
  ///
  /// In en, this message translates to:
  /// **'Get valuable insights with interactive stats and charts that help you understand your strengths and weaknesses.'**
  String get onboarding2Description;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Design Your Better Journey'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Description.
  ///
  /// In en, this message translates to:
  /// **'With advanced customization, you can build a habit system that fits your unique lifestyle and goals.'**
  String get onboarding3Description;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get next;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
