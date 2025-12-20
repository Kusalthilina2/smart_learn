import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/constants/colors.dart';
import '../../data/repositories/achievement_repository.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievements = ref.watch(achievementRepositoryProvider).getCachedAchievements();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GradientBackground(
        child: achievements.isEmpty
          ? const Center(child: Text('No achievements yet!\nKeep learning to unlock them.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.accentYellow,
                      child: const Icon(Icons.star, color: Colors.white),
                    ),
                    title: Text(achievement.title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(achievement.description),
                  ),
                );
              },
            ),
      ),
    );
  }
}
