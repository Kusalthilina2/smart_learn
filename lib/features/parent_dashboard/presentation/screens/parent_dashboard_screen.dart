import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/storage/hive_init.dart';
import '../../../../core/constants/colors.dart';

class ParentDashboardScreen extends ConsumerWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressBox = Hive.box(HiveBoxes.userProgress);
    final attemptsBox = Hive.box(HiveBoxes.quizAttempts);

    final completedLessons = progressBox.values
        .where((p) => (p as Map).cast<String, dynamic>()['completed'] == true)
        .length;

    final totalAttempts = attemptsBox.length;
    final avgScore = totalAttempts > 0
        ? attemptsBox.values
                .map((a) {
                  final data = (a as Map).cast<String, dynamic>();
                  return data['score'] / data['totalQuestions'];
                })
                .reduce((a, b) => a + b) /
            totalAttempts
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Learning Progress',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Text('Lessons Completed: $completedLessons',
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text('Quiz Attempts: $totalAttempts',
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text(
                          'Average Score: ${(avgScore * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Quiz Performance',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: totalAttempts > 0
                            ? BarChart(
                                BarChartData(
                                  alignment: BarChartAlignment.spaceEvenly,
                                  barGroups: List.generate(
                                      totalAttempts > 5 ? 5 : totalAttempts,
                                      (index) {
                                    final attempt = attemptsBox.getAt(index);
                                    final data =
                                        (attempt as Map).cast<String, dynamic>();
                                    final score = data['score'] /
                                        data['totalQuestions'] *
                                        100;
                                    return BarChartGroupData(
                                      x: index,
                                      barRods: [
                                        BarChartRodData(
                                          toY: score,
                                          color: AppColors.primaryBlue,
                                        )
                                      ],
                                    );
                                  }),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) =>
                                            Text('${value.toInt() + 1}'),
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: true),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(
                                child: Text('No quiz data yet')),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Recent Activity',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      ...attemptsBox.values.take(5).map((attempt) {
                        final data = (attempt as Map).cast<String, dynamic>();
                        return ListTile(
                          leading: const Icon(Icons.quiz),
                          title: Text('Quiz Attempt'),
                          subtitle: Text(
                              'Score: ${data['score']}/${data['totalQuestions']}'),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
