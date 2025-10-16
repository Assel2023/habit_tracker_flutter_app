import 'package:flutter/material.dart';
import 'package:habit_tracker/data/models/habit.dart';
import 'package:habit_tracker/presentation/providers/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/presentation/screens/habit_details_screen.dart';
import 'package:habit_tracker/data/models/frequency_type.dart';
import 'package:habit_tracker/l10n/app_localizations.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;

  const HabitTile({super.key, required this.habit});

  String _getDaysString(List<int> days) {
    final sortedDays = List<int>.from(days)..sort();
    const dayMap = {1: 'M', 2: 'T', 3: 'W', 4: 'T', 5: 'F', 6: 'S', 7: 'S'};
    return sortedDays.map((dayNum) => dayMap[dayNum]).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final habitProvider = Provider.of<HabitProvider>(context);
    final isCompletedToday =
        habitProvider.isHabitCompleted(habit.id, DateTime.now());
    final bool isActiveToday = habitProvider.isHabitActiveToday(habit);

    final double opacity =
        isActiveToday ? 1.0 : 0.6; 

    Widget? daysWidget;
    if (habit.frequencyType == FrequencyType.specificDays) {
      daysWidget = Text(l10n.days(_getDaysString(habit.frequencyDays ?? [])));
    }

    Widget? progressWidget;
    if (habit.isChallenge) {
      final progress = habitProvider.calculateChallengeProgress(habit);
      progressWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            color: Color(habit.colorValue),
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 4),
          Text(l10n.progressComplete((progress * 100).toStringAsFixed(0))),
        ],
      );
    }

    Widget? finalSubtitle;
    if (daysWidget != null || progressWidget != null) {
      finalSubtitle = Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (daysWidget != null) daysWidget,
            if (progressWidget != null) progressWidget,
          ],
        ),
      );
    }

    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Material(
          elevation: 0,
          color: Colors.transparent, 

          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Icon(
              IconData(
                habit.iconCodePoint,
                fontFamily: 'FontAwesomeSolid',
                fontPackage: 'font_awesome_flutter',
              ),
              color: Color(habit.colorValue),
              size: 30,
            ),
            title: Text(
              habit.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                decoration:
                    isCompletedToday ? TextDecoration.lineThrough : null,
                color: isCompletedToday ? Colors.grey : null,
              ),
            ),
            subtitle: finalSubtitle,
            trailing: IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: Icon(
                  isCompletedToday
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  key: ValueKey<bool>(isCompletedToday),
                  color:
                      isCompletedToday ? Color(habit.colorValue) : Colors.grey,
                  size: 30,
                ),
              ),
              onPressed: isActiveToday
                  ? () {
                      habitProvider.toggleCompletion(habit.id, DateTime.now());
                    }
                  : null,
            ),
            onTap: isActiveToday
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HabitDetailsScreen(habit: habit),
                      ),
                    );
                  }
                : null,
          ),
        ),
      ),
    );
  }
}
