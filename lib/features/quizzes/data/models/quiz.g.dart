// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizQuestionImpl _$$QuizQuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuizQuestionImpl(
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      correctIndex: (json['correctIndex'] as num).toInt(),
    );

Map<String, dynamic> _$$QuizQuestionImplToJson(_$QuizQuestionImpl instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'correctIndex': instance.correctIndex,
    };

_$QuizImpl _$$QuizImplFromJson(Map<String, dynamic> json) => _$QuizImpl(
  id: json['id'] as String,
  subjectId: json['subjectId'] as String,
  grade: (json['grade'] as num).toInt(),
  title: json['title'] as String,
  questions: (json['questions'] as List<dynamic>)
      .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$QuizImplToJson(_$QuizImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subjectId': instance.subjectId,
      'grade': instance.grade,
      'title': instance.title,
      'questions': instance.questions,
    };

_$QuizAttemptImpl _$$QuizAttemptImplFromJson(Map<String, dynamic> json) =>
    _$QuizAttemptImpl(
      id: json['id'] as String,
      quizId: json['quizId'] as String,
      score: (json['score'] as num).toInt(),
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      attemptedAtMs: (json['attemptedAtMs'] as num).toInt(),
    );

Map<String, dynamic> _$$QuizAttemptImplToJson(_$QuizAttemptImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quizId': instance.quizId,
      'score': instance.score,
      'totalQuestions': instance.totalQuestions,
      'attemptedAtMs': instance.attemptedAtMs,
    };
