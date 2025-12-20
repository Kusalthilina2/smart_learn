import 'package:hive_flutter/hive_flutter.dart';
import '../utils/logger.dart';

class HiveBoxes {
  static const String cachePublicSubjects = 'cache_public_subjects';
  static const String cachePublicLessons = 'cache_public_lessons';
  static const String cachePublicQuizzes = 'cache_public_quizzes';
  static const String cachePublicStories = 'cache_public_stories';
  static const String cachePublicDecks = 'cache_public_decks';
  static const String userProgress = 'user_progress';
  static const String quizAttempts = 'quiz_attempts';
  static const String activityLog = 'activity_log';
  static const String streaks = 'streaks';
  static const String achievements = 'achievements';
  static const String settings = 'settings';
  static const String outbox = 'outbox';
}

class HiveInit {
  static Future<void> initialize() async {
    Logger.info('Initializing Hive...');
    await Hive.initFlutter();

    await Future.wait([
      Hive.openBox(HiveBoxes.cachePublicSubjects),
      Hive.openBox(HiveBoxes.cachePublicLessons),
      Hive.openBox(HiveBoxes.cachePublicQuizzes),
      Hive.openBox(HiveBoxes.cachePublicStories),
      Hive.openBox(HiveBoxes.cachePublicDecks),
      Hive.openBox(HiveBoxes.userProgress),
      Hive.openBox(HiveBoxes.quizAttempts),
      Hive.openBox(HiveBoxes.activityLog),
      Hive.openBox(HiveBoxes.streaks),
      Hive.openBox(HiveBoxes.achievements),
      Hive.openBox(HiveBoxes.settings),
      Hive.openBox(HiveBoxes.outbox),
    ]);

    Logger.info('Hive initialized successfully');
  }

  static Future<void> clearAll() async {
    await Future.wait([
      Hive.box(HiveBoxes.cachePublicSubjects).clear(),
      Hive.box(HiveBoxes.cachePublicLessons).clear(),
      Hive.box(HiveBoxes.cachePublicQuizzes).clear(),
      Hive.box(HiveBoxes.cachePublicStories).clear(),
      Hive.box(HiveBoxes.cachePublicDecks).clear(),
      Hive.box(HiveBoxes.userProgress).clear(),
      Hive.box(HiveBoxes.quizAttempts).clear(),
      Hive.box(HiveBoxes.activityLog).clear(),
      Hive.box(HiveBoxes.streaks).clear(),
      Hive.box(HiveBoxes.achievements).clear(),
      Hive.box(HiveBoxes.settings).clear(),
      Hive.box(HiveBoxes.outbox).clear(),
    ]);
  }
}
