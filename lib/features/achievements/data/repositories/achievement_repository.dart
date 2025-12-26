import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/storage/hive_init.dart';
import '../../../../core/sync/outbox_operation.dart';
import '../../../../core/sync/outbox_repository.dart';
import '../../../../core/utils/time_utils.dart';
import '../../../../core/utils/uuid_generator.dart';
import '../../../../core/utils/logger.dart';
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

  AchievementRepository({required this.firestore, required this.outboxRepo});

  Box get _achievementsBox => Hive.box(HiveBoxes.achievements);

  /// Sync achievements from Firestore to local cache
  Future<void> syncAchievements(String uid) async {
    try {
      Logger.info('Syncing achievements from Firestore for user: $uid');

      final snapshot = await firestore
          .collection(FirestorePaths.userAchievements(uid))
          .get();

      if (snapshot.docs.isEmpty) {
        Logger.info('No achievements found in Firestore');
        return;
      }

      // Clear local cache before syncing
      await _achievementsBox.clear();

      // Store all achievements from Firestore to local cache
      for (final doc in snapshot.docs) {
        final data = doc.data();
        final achievement = Achievement.fromJson(data);
        await _achievementsBox.put(achievement.id, achievement.toJson());
      }

      Logger.info('Successfully synced ${snapshot.docs.length} achievements');
    } catch (e, st) {
      Logger.error('Failed to sync achievements', e, st);
    }
  }

  /// Watch achievements from Firestore in real-time
  Stream<List<Achievement>> watchAchievements(String uid) {
    return firestore
        .collection(FirestorePaths.userAchievements(uid))
        .orderBy('unlockedAtMs', descending: true)
        .snapshots()
        .map((snapshot) {
          // Update local cache with real-time data
          for (final doc in snapshot.docs) {
            final data = doc.data();
            _achievementsBox.put(doc.id, data);
          }

          return snapshot.docs
              .map((doc) => Achievement.fromJson(doc.data()))
              .toList();
        });
  }

  Future<void> unlockAchievement(
    String uid,
    String title,
    String description,
    String iconName,
  ) async {
    try {
      final achievement = Achievement(
        id: UuidGenerator.generate(),
        title: title,
        description: description,
        iconName: iconName,
        unlockedAtMs: TimeUtils.nowMs(),
      );

      Logger.info(
        'Attempting to unlock achievement: $title (iconName: $iconName)',
      );

      // Save to local cache
      await _achievementsBox.put(achievement.id, achievement.toJson());
      Logger.info('Saved achievement to local cache');

      // Try to save directly to Firestore
      try {
        final path = FirestorePaths.userAchievements(uid);
        Logger.info('Saving to Firestore path: $path/${achievement.id}');

        await firestore
            .collection(path)
            .doc(achievement.id)
            .set(achievement.toJson());

        Logger.info(
          'Achievement unlocked and saved to Firestore: ${achievement.title}',
        );
      } catch (e, st) {
        // If direct save fails, queue it for later sync
        Logger.error(
          'Failed to save achievement directly, queuing for sync',
          e,
          st,
        );
        await outboxRepo.addOperation(
          op: OutboxOpType.setDoc,
          path: '${FirestorePaths.userAchievements(uid)}/${achievement.id}',
          payload: achievement.toJson(),
        );
      }
    } catch (e, st) {
      Logger.error('Failed to unlock achievement', e, st);
    }
  }

  List<Achievement> getCachedAchievements() {
    return _achievementsBox.values
        .map((e) => Achievement.fromJson((e as Map).cast<String, dynamic>()))
        .toList()
      ..sort((a, b) => b.unlockedAtMs.compareTo(a.unlockedAtMs));
  }

  Future<void> checkAndUnlockAchievements(String uid) async {
    try {
      Logger.info('🎯 Analyzing student achievement progress...');

      // ========== PAGE 1: Learning Progress Analysis ==========
      final progressBox = Hive.box(HiveBoxes.userProgress);
      final completedLessons = progressBox.values
          .where((p) => (p as Map).cast<String, dynamic>()['completed'] == true)
          .length;

      final quizAttemptsBox = Hive.box(HiveBoxes.quizAttempts);
      final totalQuizzes = quizAttemptsBox.length;

      final activityBox = Hive.box(HiveBoxes.activityLog);
      final totalActivities = activityBox.length;

      Logger.info(
        '📊 Progress Report: Lessons: $completedLessons | Quizzes: $totalQuizzes | Activities: $totalActivities',
      );

      // ========== PAGE 2: Quiz Performance Achievements ==========
      Logger.info('📝 Analyzing quiz performance...');

      if (totalQuizzes >= 1 && !_hasAchievement('first_quiz')) {
        await unlockAchievement(
          uid,
          '🌟 Quiz Starter',
          'Completed your first quiz! Great beginning!',
          'first_quiz',
        );
      }

      if (totalQuizzes >= 3 && !_hasAchievement('quiz_enthusiast')) {
        await unlockAchievement(
          uid,
          '📚 Quiz Enthusiast',
          'Completed 3 quizzes - You love testing yourself!',
          'quiz_enthusiast',
        );
      }

      if (totalQuizzes >= 5 && !_hasAchievement('quiz_master')) {
        await unlockAchievement(
          uid,
          '🏆 Quiz Master',
          'Completed 5 quizzes - Impressive dedication!',
          'quiz_master',
        );
      }

      if (totalQuizzes >= 10 && !_hasAchievement('quiz_champion')) {
        await unlockAchievement(
          uid,
          '👑 Quiz Champion',
          'Completed 10 quizzes - You are unstoppable!',
          'quiz_champion',
        );
      }

      // ========== PAGE 3: Learning Journey Achievements ==========
      Logger.info('📖 Analyzing learning journey...');

      if (completedLessons >= 1 && !_hasAchievement('first_lesson')) {
        await unlockAchievement(
          uid,
          '🎓 Learning Begins',
          'Completed your first lesson!',
          'first_lesson',
        );
      }

      if (completedLessons >= 5 && !_hasAchievement('first_5')) {
        await unlockAchievement(
          uid,
          '⭐ First Steps',
          'Completed 5 lessons - Building strong foundations!',
          'first_5',
        );
      }

      if (completedLessons >= 10 && !_hasAchievement('first_10')) {
        await unlockAchievement(
          uid,
          '🌟 Learning Master',
          'Completed 10 lessons - Knowledge is power!',
          'first_10',
        );
      }

      if (completedLessons >= 25 && !_hasAchievement('knowledge_seeker')) {
        await unlockAchievement(
          uid,
          '📚 Knowledge Seeker',
          'Completed 25 lessons - Outstanding progress!',
          'knowledge_seeker',
        );
      }

      // ========== PAGE 4: Practice & Activity Achievements ==========
      Logger.info('💪 Analyzing practice activities...');

      if (totalActivities >= 5 && !_hasAchievement('practice_starter')) {
        await unlockAchievement(
          uid,
          '🎯 Practice Starter',
          'Completed 5 practice activities!',
          'practice_starter',
        );
      }

      if (totalActivities >= 15 && !_hasAchievement('dedicated_learner')) {
        await unlockAchievement(
          uid,
          '💎 Dedicated Learner',
          'Completed 15 activities - Great consistency!',
          'dedicated_learner',
        );
      }

      // ========== PAGE 5: Streak & Consistency Achievements ==========
      Logger.info('🔥 Analyzing learning consistency...');

      final streakBox = Hive.box(HiveBoxes.streaks);
      final streakData =
          streakBox.get('current_streak') as Map<String, dynamic>?;
      final currentStreak = streakData?['count'] as int? ?? 0;

      if (currentStreak >= 3 && !_hasAchievement('streak_3')) {
        await unlockAchievement(
          uid,
          '🔥 3-Day Streak',
          'Learning for 3 days in a row!',
          'streak_3',
        );
      }

      if (currentStreak >= 7 && !_hasAchievement('streak_7')) {
        await unlockAchievement(
          uid,
          '⚡ Week Warrior',
          '7-day learning streak - Amazing consistency!',
          'streak_7',
        );
      }

      if (currentStreak >= 14 && !_hasAchievement('streak_14')) {
        await unlockAchievement(
          uid,
          '🌟 Two-Week Hero',
          '14-day streak - You are on fire!',
          'streak_14',
        );
      }

      // ========== PAGE 6: Overall Excellence Achievements ==========
      Logger.info('🏅 Analyzing overall excellence...');

      final totalProgress = completedLessons + totalQuizzes + totalActivities;

      if (totalProgress >= 20 && !_hasAchievement('rising_star')) {
        await unlockAchievement(
          uid,
          '⭐ Rising Star',
          '20+ total activities - You shine bright!',
          'rising_star',
        );
      }

      if (totalProgress >= 50 && !_hasAchievement('super_student')) {
        await unlockAchievement(
          uid,
          '🚀 Super Student',
          '50+ total activities - Extraordinary achievement!',
          'super_student',
        );
      }

      if (totalProgress >= 100 && !_hasAchievement('learning_legend')) {
        await unlockAchievement(
          uid,
          '👑 Learning Legend',
          '100+ activities - You are a legend!',
          'learning_legend',
        );
      }

      Logger.info('✅ Achievement analysis complete!');
    } catch (e, st) {
      Logger.error('❌ Error during achievement analysis', e, st);
    }
  }

  bool _hasAchievement(String iconName) {
    return _achievementsBox.values.any(
      (a) => (a as Map).cast<String, dynamic>()['iconName'] == iconName,
    );
  }
}
