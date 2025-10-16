import 'package:flutter/material.dart';
import 'package:habit_tracker/data/models/habit.dart';
import 'package:habit_tracker/presentation/providers/habit_provider.dart';
import 'package:habit_tracker/presentation/providers/theme_provider.dart';
import 'package:habit_tracker/presentation/screens/home_screen.dart';
import 'package:habit_tracker/presentation/screens/onboarding_screen.dart';
import 'package:habit_tracker/presentation/theme/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/data/services/notification_service.dart';
import 'package:habit_tracker/data/models/frequency_type.dart';
import 'package:habit_tracker/data/models/category.dart';
import 'package:habit_tracker/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(FrequencyTypeAdapter());
  Hive.registerAdapter(CategoryAdapter());

  await Hive.openBox<Habit>('habits');
  await Hive.openBox('completions');
  await Hive.openBox('settings');
  await Hive.openBox<Category>('categories');

  final settingsBox = Hive.box('settings');
  final bool hasSeenOnboarding = settingsBox.get('hasSeenOnboarding', defaultValue: false);

  final NotificationService notificationService = NotificationService();
  await notificationService.init();
  await notificationService.requestPermissions();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HabitProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(hasSeenOnboarding: hasSeenOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;

  const MyApp({super.key, required this.hasSeenOnboarding});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Habit Tracker',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.currentThemeMode,
          
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          
          home: hasSeenOnboarding ? const HomeScreen() : const OnboardingScreen(),
          
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}