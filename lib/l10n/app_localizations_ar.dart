// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get myHabits => 'عاداتي';

  @override
  String get yourDailyProgress => 'تقدمك اليومي';

  @override
  String habitsCompleted(Object count, Object total) {
    return '$count من $total عادات مكتملة';
  }

  @override
  String get statistics => 'الإحصائيات';

  @override
  String get manageCategories => 'إدارة الفئات';

  @override
  String get generalCategory => 'عام';

  @override
  String get noHabitsYet =>
      'لا توجد عادات بعد.\nاضغط على زر \"+\" لإضافة واحدة!';

  @override
  String days(Object daysString) {
    return 'الأيام: $daysString';
  }

  @override
  String progressComplete(Object progress) {
    return '$progress% مكتمل';
  }

  @override
  String get addHabit => 'إضافة عادة جديدة';

  @override
  String get editHabit => 'تعديل العادة';

  @override
  String get habitName => 'اسم العادة';

  @override
  String get enterHabitName => 'الرجاء إدخال اسم للعادة';

  @override
  String get category => 'الفئة';

  @override
  String get selectCategory => 'الرجاء اختيار فئة';

  @override
  String get chooseAnIcon => 'اختر أيقونة';

  @override
  String get chooseAColor => 'اختر لونًا';

  @override
  String get advancedSettings => 'إعدادات متقدمة';

  @override
  String get frequency => 'التكرار';

  @override
  String get daily => 'يوميًا';

  @override
  String get specificDays => 'أيام محددة';

  @override
  String get selectAtLeastOneDay => 'الرجاء اختيار يوم واحد على الأقل.';

  @override
  String get makeItAChallenge => 'اجعلها تحديًا';

  @override
  String get setADuration => 'حدد مدة معينة لهذه العادة.';

  @override
  String get durationInDays => 'المدة (بالأيام)';

  @override
  String get enterADuration => 'الرجاء إدخال مدة';

  @override
  String get enterAValidNumber => 'الرجاء إدخال رقم صالح';

  @override
  String daysSuffix(Object count) {
    return '$count أيام';
  }

  @override
  String get enableDailyReminder => 'تفعيل التذكير اليومي';

  @override
  String get reminderTime => 'وقت التذكير';

  @override
  String get selectTime => 'اختر الوقت';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get saveHabit => 'حفظ العادة';

  @override
  String get save => 'حفظ';

  @override
  String get currentStreak => 'السلسلة الحالية';

  @override
  String get longestStreak => 'أطول سلسلة';

  @override
  String get completionHistory => 'سجل الإنجاز';

  @override
  String get confirmDeletion => 'تأكيد الحذف';

  @override
  String deleteConfirmationMessage(Object name) {
    return 'هل أنت متأكد أنك تريد حذف \"$name\"؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get noCategoriesFound => 'لا توجد فئات. أضف واحدة للبدء!';

  @override
  String get addCategory => 'إضافة فئة';

  @override
  String get editCategory => 'تعديل الفئة';

  @override
  String get categoryName => 'اسم الفئة';

  @override
  String get enterACategoryName => 'الرجاء إدخال اسم';

  @override
  String get categoryColor => 'لون الفئة';

  @override
  String get pickAColor => 'اختر لونًا';

  @override
  String get done => 'تم';

  @override
  String get yearlyHeatmap => 'الخريطة الحرارية السنوية';

  @override
  String get totalCompletions => 'إجمالي الإنجازات';

  @override
  String get weeklyPerformance => 'الأداء الأسبوعي';

  @override
  String get onboarding1Title => 'تتبع أهدافك اليومية';

  @override
  String get onboarding1Description =>
      'حوّل أهدافك الكبيرة إلى عادات يومية بسيطة يمكنك تتبعها بسهولة.';

  @override
  String get onboarding2Title => 'اكتشف أنماط سلوكك';

  @override
  String get onboarding2Description =>
      'احصل على رؤى قيمة من خلال إحصائيات تفاعلية ورسوم بيانية تساعدك على فهم نقاط قوتك وضعفك.';

  @override
  String get onboarding3Title => 'صمم رحلتك نحو الأفضل';

  @override
  String get onboarding3Description =>
      'مع ميزات التخصيص المتقدمة، يمكنك بناء نظام العادات الذي يناسب أسلوب حياتك وأهدافك الفريدة.';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';
}
