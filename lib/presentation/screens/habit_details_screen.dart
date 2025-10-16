import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:habit_tracker/data/models/habit.dart';
import 'package:habit_tracker/presentation/providers/habit_provider.dart';
import 'package:habit_tracker/presentation/providers/theme_provider.dart';
import 'package:habit_tracker/presentation/screens/add_edit_habit_screen.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:habit_tracker/l10n/app_localizations.dart';

class HabitDetailsScreen extends StatelessWidget {
  final Habit habit;
  const HabitDetailsScreen({super.key, required this.habit});

  List<dynamic> _getEventsForDay(DateTime day, HabitProvider provider) {
    if (provider.isHabitCompleted(habit.id, day)) {
      return [habit];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    final themeProvider = Provider.of<ThemeProvider>(context);
    final habitProvider = Provider.of<HabitProvider>(context);

    final currentStreak = habitProvider.calculateCurrentStreak(habit.id);
    final longestStreak = habitProvider.calculateLongestStreak(habit.id);

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(habit.name),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddEditHabitScreen(habit: habit)),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(l10n.confirmDeletion),
                    content: Text(l10n.deleteConfirmationMessage(habit.name)),
                    actions: [
                      TextButton(
                        child: Text(l10n.cancel),
                        onPressed: () => Navigator.of(ctx).pop(),
                      ),
                      TextButton(
                        child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
                        onPressed: () {
                          Provider.of<HabitProvider>(context, listen: false).deleteHabit(habit);
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildStatCard(l10n.currentStreak, currentStreak.toString(), Icons.star_rounded, context),
                  const SizedBox(width: 16),
                  _buildStatCard(l10n.longestStreak, longestStreak.toString(), Icons.emoji_events_rounded, context),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(l10n.completionHistory, context),
              
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2)),
                    ),
                    child: TableCalendar(
                      focusedDay: DateTime.now(),
                      firstDay: habit.createdAt,
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.teal),
                        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.teal),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
                        weekendStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: const TextStyle(color: Colors.teal),
                        weekendTextStyle: const TextStyle(color: Colors.teal),
                        outsideTextStyle: const TextStyle(color: Colors.teal),
                        todayDecoration: BoxDecoration(
                          color: Color(habit.colorValue).withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        markerDecoration: BoxDecoration(
                          color: Color(habit.colorValue),
                          shape: BoxShape.circle,
                        ),
                      ),
                      eventLoader: (day) => _getEventsForDay(day, habitProvider),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              
              _buildGlassCard(
                context: context,
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline_rounded, color: Color.fromARGB(255, 242, 255, 0)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "تذكر: المنتصر لا ينسحب، والمنسحب لا ينتصر.",
                        style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9), fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, BuildContext context) {
    return Expanded(child: _buildGlassCard(
      context: context,
      child: Column(
        children: [
          Icon(icon, size: 30, color: const Color.fromARGB(245, 238, 255, 0)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0))),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8))),
        ],
      ),
    ));
  }

  Widget _buildGlassCard({required BuildContext context, required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }
}