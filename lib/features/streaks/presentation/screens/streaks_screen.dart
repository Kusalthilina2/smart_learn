import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/storage/hive_init.dart';

class StreaksScreen extends ConsumerWidget {
  const StreaksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakBox = Hive.box(HiveBoxes.streaks);
    final streakData = streakBox.get('current');

    final currentStreak = streakData != null
        ? Map<String, dynamic>.from(streakData)['current'] ?? 0
        : 0;
    final longestStreak = streakData != null
        ? Map<String, dynamic>.from(streakData)['longest'] ?? 0
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Streak'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GradientBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.local_fire_department,
                    size: 120, color: Colors.orange),
                const SizedBox(height: 32),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        const Text('Current Streak',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Text('$currentStreak days',
                            style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                        const SizedBox(height: 32),
                        const Divider(),
                        const SizedBox(height: 16),
                        const Text('Longest Streak',
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('$longestStreak days',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Keep learning every day to maintain your streak!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
