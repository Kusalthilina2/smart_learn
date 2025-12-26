import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/constants/colors.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../../data/repositories/achievement_repository.dart';

class AchievementsScreen extends ConsumerStatefulWidget {
  const AchievementsScreen({super.key});

  @override
  ConsumerState<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends ConsumerState<AchievementsScreen> {
  @override
  void initState() {
    super.initState();
    // Sync achievements when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUser = ref.read(authRepositoryProvider).currentUser;
      if (currentUser != null) {
        // First sync from Firestore
        ref
            .read(achievementRepositoryProvider)
            .syncAchievements(currentUser.uid);

        // Then check if any new achievements should be unlocked
        ref
            .read(achievementRepositoryProvider)
            .checkAndUnlockAchievements(currentUser.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authRepositoryProvider).currentUser;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Achievements'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const GradientBackground(
          child: Center(child: Text('Please sign in to view achievements')),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Check for new achievements',
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              await ref
                  .read(achievementRepositoryProvider)
                  .checkAndUnlockAchievements(currentUser.uid);
              if (mounted) {
                messenger.showSnackBar(
                  const SnackBar(content: Text('Checked for achievements')),
                );
              }
            },
          ),
        ],
      ),
      body: GradientBackground(
        child: StreamBuilder(
          stream: ref
              .watch(achievementRepositoryProvider)
              .watchAchievements(currentUser.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: ${snapshot.error}'),
                  ],
                ),
              );
            }

            final achievements = snapshot.data ?? [];

            if (achievements.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_outline, size: 80, color: Colors.grey),
                    SizedBox(height: 24),
                    Text(
                      'No achievements yet!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Keep learning to unlock them.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
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
                    title: Text(
                      achievement.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(achievement.description),
                    trailing: Text(
                      _formatDate(achievement.unlockedAtMs),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _formatDate(int timestampMs) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestampMs);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
