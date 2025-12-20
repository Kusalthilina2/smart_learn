import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

@freezed
class ContentBlock with _$ContentBlock {
  const factory ContentBlock({
    required String type,
    required String content,
    String? mediaUrl,
  }) = _ContentBlock;

  factory ContentBlock.fromJson(Map<String, dynamic> json) =>
      _$ContentBlockFromJson(json);
}

@freezed
class Lesson with _$Lesson {
  const factory Lesson({
    required String id,
    required String subjectId,
    required int grade,
    required String title,
    required String description,
    required List<ContentBlock> contentBlocks,
    required int views,
    required double rating,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) =>
      _$LessonFromJson(json);
}

@freezed
class LessonProgress with _$LessonProgress {
  const factory LessonProgress({
    required String lessonId,
    required bool completed,
    required int updatedAtMs,
  }) = _LessonProgress;

  factory LessonProgress.fromJson(Map<String, dynamic> json) =>
      _$LessonProgressFromJson(json);
}
