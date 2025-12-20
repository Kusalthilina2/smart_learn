import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/storage/hive_init.dart';
import '../../../../core/sync/outbox_operation.dart';
import '../../../../core/sync/outbox_repository.dart';
import '../../../../core/utils/time_utils.dart';
import '../models/streak.dart';

final streakRepositoryProvider = Provider<StreakRepository>((ref) {
  return StreakRepository(
    firestore: FirebaseFirestore.instance,
    outboxRepo: OutboxRepository(),
  );
});

class StreakRepository {
  final FirebaseFirestore firestore;
  final OutboxRepository outboxRepo;

  StreakRepository({
    required this.firestore,
    required this.outboxRepo,
  });

  Box get _streaksBox => Hive.box(HiveBoxes.streaks);

  Future<void> updateStreak(String uid) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

    Streak streak;
    final cached = _streaksBox.get('current');

    if (cached == null) {
      streak = Streak(current: 1, longest: 1, lastActiveDate: today);
    } else {
      final existing = Streak.fromJson((cached as Map).cast<String, dynamic>());
      final lastActiveDay = DateTime.fromMillisecondsSinceEpoch(existing.lastActiveDate);
      final daysSince = TimeUtils.daysBetween(lastActiveDay, now);

      if (daysSince == 0) {
        streak = existing;
      } else if (daysSince == 1) {
        final newCurrent = existing.current + 1;
        streak = Streak(
          current: newCurrent,
          longest: newCurrent > existing.longest ? newCurrent : existing.longest,
          lastActiveDate: today,
        );
      } else {
        streak = Streak(current: 1, longest: existing.longest, lastActiveDate: today);
      }
    }

    await _streaksBox.put('current', streak.toJson());

    await outboxRepo.addOperation(
      op: OutboxOpType.setDoc,
      path: FirestorePaths.userStreak(uid),
      payload: streak.toJson(),
    );
  }

  Streak? getCurrentStreak() {
    final cached = _streaksBox.get('current');
    if (cached == null) return null;
    return Streak.fromJson((cached as Map).cast<String, dynamic>());
  }
}
