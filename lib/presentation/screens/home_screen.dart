import 'dart:ui';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/data/models/category.dart';
import 'package:habit_tracker/presentation/providers/habit_provider.dart';
import 'package:habit_tracker/presentation/providers/theme_provider.dart';
import 'package:habit_tracker/presentation/screens/add_edit_habit_screen.dart';
import 'package:habit_tracker/presentation/screens/manage_categories_screen.dart';
import 'package:habit_tracker/presentation/widgets/habit_tile.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/presentation/screens/stats_screen.dart';
import 'package:habit_tracker/l10n/app_localizations.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ConfettiController _confettiController;
  bool _isCelebratedToday = false;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: themeProvider.isDarkMode
                ? [const Color(0xFF1D2671), const Color(0xFF2c3e50)]
                : [Colors.teal.shade100, Colors.purple.shade100],
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(l10n.myHabits),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.bar_chart_rounded),
                    tooltip: l10n.statistics,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const StatsScreen(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.category_outlined),
                    tooltip: l10n.manageCategories,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ManageCategoriesScreen(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return Icon(
                          themeProvider.isDarkMode
                              ? Icons.wb_sunny_rounded
                              : Icons.nightlight_round,
                        );
                      },
                    ),
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    },
                  ),
                ],
              ),
              body: Consumer<HabitProvider>(
                builder: (context, habitProvider, child) {
                  final progress = habitProvider.dailyProgressPercentage;
                  if (progress == 1.0 && !_isCelebratedToday) {
                    _confettiController.play();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          _isCelebratedToday = true;
                        });
                      }
                    });
                  } else if (progress < 1.0 && _isCelebratedToday) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          _isCelebratedToday = false;
                        });
                      }
                    });
                  }

                  if (habitProvider.habits.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.emoji_events_outlined,
                                size: 80, color: Colors.grey.shade400),
                            const SizedBox(height: 20),
                            const Text("تذكر دائمًا:",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 12),
                            Text("المنتصر لا ينسحب، والمنسحب لا ينتصر.",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade600,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 30),
                            const Text('اضغط على زر "+" لتبدأ رحلتك!',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    );
                  }

                  final groupedHabits = habitProvider.groupedHabits;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0.50),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.2)),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: CircularProgressIndicator(
                                      value:
                                          habitProvider.dailyProgressPercentage,
                                      strokeWidth: 8,
                                      backgroundColor:
                                          // ignore: deprecated_member_use
                                          const Color.fromARGB(255, 104, 82, 82)
                                              .withOpacity(0.3),
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.teal),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(l10n.yourDailyProgress,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface)),
                                        const SizedBox(height: 8),
                                        Text(
                                            l10n.habitsCompleted(
                                                habitProvider
                                                    .completedHabitsTodayCount,
                                                habitProvider
                                                    .habitsForToday.length),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade600)),
                                      ],
                                    ),
                                  ),
                                  Text(
                                      '${(habitProvider.dailyProgressPercentage * 100).toStringAsFixed(0)}%',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 100.0),
                          itemCount: groupedHabits.keys.length,
                          itemBuilder: (context, index) {
                            final category =
                                groupedHabits.keys.elementAt(index);
                            final habitsInCategory = groupedHabits[category]!;
                            if (habitsInCategory.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface
                                            .withOpacity(0.50),
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                    255, 0, 0, 0)
                                                .withOpacity(0.15)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            color: Color(category.colorValue)
                                                .withOpacity(0.1),
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 12, 16, 12),
                                            child: Text(
                                              category.id == 'general'
                                                  ? l10n.generalCategory
                                                      .toUpperCase()
                                                  : category.name.toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    Color(category.colorValue),
                                              ),
                                            ),
                                          ),
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: habitsInCategory.length,
                                            itemBuilder: (context, habitIndex) {
                                              final habit =
                                                  habitsInCategory[habitIndex];
                                              return HabitTile(habit: habit);
                                            },
                                            separatorBuilder:
                                                (context, index) => Divider(
                                              height: 1,
                                              thickness: 1,
                                              indent: 16,
                                              endIndent: 16,
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                          ),
                                        ],
                                      )),
                                ));
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddEditHabitScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
              gravity: 0.1,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
            ),
          ],
        ));
  }
}
