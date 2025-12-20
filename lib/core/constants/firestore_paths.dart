class FirestorePaths {
  @Deprecated('Use hierarchical structure: materials/{gradeId}/subjects')
  static const String publicSubjects = 'public_subjects';
  @Deprecated('Use hierarchical structure: materials/{gradeId}/subjects/{subjectId}/lessons')
  static const String publicLessons = 'public_lessons';
  @Deprecated('Use hierarchical structure: materials/{gradeId}/subjects/{subjectId}/quizzes')
  static const String publicQuizzes = 'public_quizzes';
  @Deprecated('Use hierarchical structure: materials/{gradeId}/subjects/{subjectId}/stories')
  static const String publicStories = 'public_stories';
  @Deprecated('Use hierarchical structure: materials/{gradeId}/subjects/{subjectId}/flashcard_decks')
  static const String publicFlashcardDecks = 'public_flashcard_decks';
  static const String publicMeta = 'public_meta';
  static const String users = 'users';

  static const String materials = 'materials';
  static const String meta = 'meta';

  static String materialsGrade(String gradeId) => 'materials/$gradeId';
  static String materialsSubjects(String gradeId) => 'materials/$gradeId/subjects';
  static String materialsSubject(String gradeId, String subjectId) =>
      'materials/$gradeId/subjects/$subjectId';
  static String materialsLessons(String gradeId, String subjectId) =>
      'materials/$gradeId/subjects/$subjectId/lessons';
  static String materialsLesson(String gradeId, String subjectId, String lessonId) =>
      'materials/$gradeId/subjects/$subjectId/lessons/$lessonId';
  static String materialsQuizzes(String gradeId, String subjectId) =>
      'materials/$gradeId/subjects/$subjectId/quizzes';
  static String materialsQuiz(String gradeId, String subjectId, String quizId) =>
      'materials/$gradeId/subjects/$subjectId/quizzes/$quizId';
  static String materialsStories(String gradeId, String subjectId) =>
      'materials/$gradeId/subjects/$subjectId/stories';
  static String materialsStory(String gradeId, String subjectId, String storyId) =>
      'materials/$gradeId/subjects/$subjectId/stories/$storyId';
  static String materialsFlashcardDecks(String gradeId, String subjectId) =>
      'materials/$gradeId/subjects/$subjectId/flashcard_decks';
  static String materialsFlashcardDeck(String gradeId, String subjectId, String deckId) =>
      'materials/$gradeId/subjects/$subjectId/flashcard_decks/$deckId';

  static String userDoc(String uid) => 'users/$uid';
  static String userProgress(String uid) => 'users/$uid/progress';
  static String userProgressDoc(String uid, String lessonId) =>
      'users/$uid/progress/$lessonId';
  static String userQuizAttempts(String uid) => 'users/$uid/quiz_attempts';
  static String userActivityLog(String uid) => 'users/$uid/activity_log';
  static String userCustomDecks(String uid) => 'users/$uid/custom_decks';
  static String userAchievements(String uid) => 'users/$uid/achievements';
  static String userSettings(String uid) => 'users/$uid/settings/app';
  static String userStreak(String uid) => 'users/$uid/streak/app';
  static String userHomeworkSubmissions(String uid) =>
      'users/$uid/homework_submissions';

  static const String seedDoc = 'meta/seed';
}
