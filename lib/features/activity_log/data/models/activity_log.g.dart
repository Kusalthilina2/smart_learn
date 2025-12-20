// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityLogImpl _$$ActivityLogImplFromJson(Map<String, dynamic> json) =>
    _$ActivityLogImpl(
      id: json['id'] as String,
      activityType: json['activityType'] as String,
      description: json['description'] as String,
      timestampMs: (json['timestampMs'] as num).toInt(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ActivityLogImplToJson(_$ActivityLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activityType': instance.activityType,
      'description': instance.description,
      'timestampMs': instance.timestampMs,
      'metadata': instance.metadata,
    };
