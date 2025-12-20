import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/storage/hive_init.dart';
import '../../../../core/sync/outbox_operation.dart';
import '../../../../core/sync/outbox_repository.dart';
import '../../../../core/utils/time_utils.dart';
import '../../../../core/utils/uuid_generator.dart';
import '../models/achievement.dart';

final achievementRepositoryProvider = Provider<AchievementRepository>((ref) {
  return AchievementRepository(
    firestore: FirebaseFirestore.instance,
    outboxRepo: OutboxRepository(),
  );
});

class AchievementRepository {
  final FirebaseFirestore firestore;
  final OutboxRepository outboxRepo;

  AchievementRepository({
    required this.firestore,
    required this.outboxRepo,
  });

  Box get _achievementsBox => Hive.box(HiveBoxes.achievements);

  Future<void> unlockAchievement(
    String uid,
    String title,
    String description,
    String iconName,
  ) async {
    final achievement = Achievement(
      id: UuidGenerator.generate(),
      title: title,
      description: description,
      iconName: iconName,
      unlockedAtMs: TimeUtils.nowMs(),
    );

    await _achievementsBox.put(achievement.id, achievement.toJson());

    await outboxRepo.addOperation(
      op: OutboxOpType.setDoc,
      path: '${FirestorePaths.userAchievements(uid)}/${achievement.id}',
      payload: achievement.toJson(),
    );
  }

  List<Achievement> getCachedAchievements() {
    return _achievementsBox.values
        .map((e) => Achievement.fromJson((e as Map).cast<String, dynamic>()))
        .toList()
      ..sort((a, b) => b.unlockedAtMs.compareTo(a.unlockedAtMs));
  }

  Future<void> checkAndUnlockAchievements(String uid) async {
    final progressBox = Hive.box(HiveBoxes.userProgress);
    final completedCount = progressBox.values
        .where((p) => (p as Map).cast<String, dynamic>()['completed'] == true)
        .length;

    if (completedCount >= 5 && !_hasAchievement('first_5')) {
      await unlockAchievement(
        uid, 'First Steps', 'Completed 5 lessons', 'star');
    }
    if (completedCount >= 10 && !_hasAchievement('first_10')) {
      await unlockAchievement(
        uid, 'Learning Master', 'Completed 10 lessons', 'trophy');
    }
  }

  bool _hasAchievement(String iconName) {
    return _achievementsBox.values.any(
      (a) => (a as Map).cast<String, dynamic>()['iconName'] == iconName);
  }
}
