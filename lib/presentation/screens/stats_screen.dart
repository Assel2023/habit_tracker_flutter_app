import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/presentation/providers/habit_provider.dart';
import 'package:habit_tracker/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/l10n/app_localizations.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final themeProvider = Provider.of<ThemeProvider>(context);
    final habitProvider = Provider.of<HabitProvider>(context);

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
          title: Text(l10n.statistics),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(l10n.yearlyHeatmap, context),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.teal.withOpacity(0.2)),
                    ),
                    child: HeatMap(
                      datasets: habitProvider.heatmapDataset,
                      colorMode: ColorMode.color, 
                      showText: false,
                      scrollable: true,
                      colorsets: {
                        1: Colors.teal.withOpacity(0.2),
                        3: Colors.teal.withOpacity(0.4),
                        5: Colors.teal.withOpacity(0.6),
                        7: Colors.teal.withOpacity(0.8),
                        9: Colors.teal,
                      },
                      onClick: (date) {},
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  _buildStatCard(l10n.totalCompletions, habitProvider.totalCompletions.toString(), Icons.done_all_rounded, context),
                ],
              ),
              const SizedBox(height: 24),

              _buildSectionTitle(l10n.weeklyPerformance, context),
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: BarChart(
                        _buildWeeklyBarChartData(habitProvider.weeklyBarChartDataset, context),
                      ),
                    ),
                  ),
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
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, BuildContext context) {
    return Expanded(
      child: ClipRRect(
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
            child: Column(
              children: [
                Icon(icon, size: 30, color: Colors.teal),
                const SizedBox(height: 8),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0))),
                const SizedBox(height: 4),
                Text(title, style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BarChartData _buildWeeklyBarChartData(Map<int, double> dataset, BuildContext context) {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: dataset.values.isEmpty ? 1 : (dataset.values.reduce((a, b) => a > b ? a : b) * 1.2),
      barTouchData: BarTouchData(enabled: true),
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.teal);
              String text;
              switch (value.toInt()) {
                case 1: text = 'M'; break;
                case 2: text = 'T'; break;
                case 3: text = 'W'; break;
                case 4: text = 'T'; break;
                case 5: text = 'F'; break;
                case 6: text = 'S'; break;
                case 7: text = 'S'; break;
                default: text = ''; break;
              }
              return SideTitleWidget(axisSide: meta.axisSide, child: Text(text, style: style));
            },
            reservedSize: 28,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      barGroups: List.generate(7, (index) {
        final dayIndex = index + 1;
        return BarChartGroupData(
          x: dayIndex,
          barRods: [
            BarChartRodData(
              toY: dataset[dayIndex] ?? 0.0,
              color: Colors.teal,
              width: 16,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ],
        );
      }),
    );
  }
}