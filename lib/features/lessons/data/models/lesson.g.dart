// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentBlockImpl _$$ContentBlockImplFromJson(Map<String, dynamic> json) =>
    _$ContentBlockImpl(
      type: json['type'] as String,
      content: json['content'] as String,
      mediaUrl: json['mediaUrl'] as String?,
    );

Map<String, dynamic> _$$ContentBlockImplToJson(_$ContentBlockImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'content': instance.content,
      'mediaUrl': instance.mediaUrl,
    };

_$LessonImpl _$$LessonImplFromJson(Map<String, dynamic> json) => _$LessonImpl(
  id: json['id'] as String,
  subjectId: json['subjectId'] as String,
  grade: (json['grade'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  contentBlocks: (json['contentBlocks'] as List<dynamic>)
      .map((e) => ContentBlock.fromJson(e as Map<String, dynamic>))
      .toList(),
  views: (json['views'] as num).toInt(),
  rating: (json['rating'] as num).toDouble(),
);

Map<String, dynamic> _$$LessonImplToJson(_$LessonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subjectId': instance.subjectId,
      'grade': instance.grade,
      'title': instance.title,
      'description': instance.description,
      'contentBlocks': instance.contentBlocks,
      'views': instance.views,
      'rating': instance.rating,
    };

_$LessonProgressImpl _$$LessonProgressImplFromJson(Map<String, dynamic> json) =>
    _$LessonProgressImpl(
      lessonId: json['lessonId'] as String,
      completed: json['completed'] as bool,
      updatedAtMs: (json['updatedAtMs'] as num).toInt(),
    );

Map<String, dynamic> _$$LessonProgressImplToJson(
  _$LessonProgressImpl instance,
) => <String, dynamic>{
  'lessonId': instance.lessonId,
  'completed': instance.completed,
  'updatedAtMs': instance.updatedAtMs,
};
