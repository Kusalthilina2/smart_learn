// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryPageImpl _$$StoryPageImplFromJson(Map<String, dynamic> json) =>
    _$StoryPageImpl(
      text: json['text'] as String,
      imageUrl: json['imageUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
    );

Map<String, dynamic> _$$StoryPageImplToJson(_$StoryPageImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'imageUrl': instance.imageUrl,
      'audioUrl': instance.audioUrl,
    };

_$StoryImpl _$$StoryImplFromJson(Map<String, dynamic> json) => _$StoryImpl(
  id: json['id'] as String,
  subjectId: json['subjectId'] as String,
  grade: (json['grade'] as num).toInt(),
  title: json['title'] as String,
  pages: (json['pages'] as List<dynamic>)
      .map((e) => StoryPage.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$StoryImplToJson(_$StoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subjectId': instance.subjectId,
      'grade': instance.grade,
      'title': instance.title,
      'pages': instance.pages,
    };
