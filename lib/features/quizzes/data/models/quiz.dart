import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

@freezed
class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required String question,
    required List<String> options,
    required int correctIndex,
  }) = _QuizQuestion;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionFromJson(json);
}

@freezed
class Quiz with _$Quiz {
  const factory Quiz({
    required String id,
    required String subjectId,
    required int grade,
    required String title,
    required List<QuizQuestion> questions,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}

@freezed
class QuizAttempt with _$QuizAttempt {
  const factory QuizAttempt({
    required String id,
    required String quizId,
    required int score,
    required int totalQuestions,
    required int attemptedAtMs,
  }) = _QuizAttempt;

  factory QuizAttempt.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptFromJson(json);
}
