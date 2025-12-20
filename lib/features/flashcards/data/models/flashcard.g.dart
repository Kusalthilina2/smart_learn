// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FlashcardImpl _$$FlashcardImplFromJson(Map<String, dynamic> json) =>
    _$FlashcardImpl(
      id: json['id'] as String,
      front: json['front'] as String,
      back: json['back'] as String,
      lastReviewedMs: (json['lastReviewedMs'] as num).toInt(),
      nextReviewMs: (json['nextReviewMs'] as num).toInt(),
      repetitions: (json['repetitions'] as num).toInt(),
      easeFactor: (json['easeFactor'] as num).toDouble(),
    );

Map<String, dynamic> _$$FlashcardImplToJson(_$FlashcardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'front': instance.front,
      'back': instance.back,
      'lastReviewedMs': instance.lastReviewedMs,
      'nextReviewMs': instance.nextReviewMs,
      'repetitions': instance.repetitions,
      'easeFactor': instance.easeFactor,
    };

_$FlashcardDeckImpl _$$FlashcardDeckImplFromJson(Map<String, dynamic> json) =>
    _$FlashcardDeckImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subjectId: json['subjectId'] as String?,
      grade: (json['grade'] as num).toInt(),
      cards: (json['cards'] as List<dynamic>)
          .map((e) => Flashcard.fromJson(e as Map<String, dynamic>))
          .toList(),
      isCustom: json['isCustom'] as bool,
    );

Map<String, dynamic> _$$FlashcardDeckImplToJson(_$FlashcardDeckImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subjectId': instance.subjectId,
      'grade': instance.grade,
      'cards': instance.cards,
      'isCustom': instance.isCustom,
    };
