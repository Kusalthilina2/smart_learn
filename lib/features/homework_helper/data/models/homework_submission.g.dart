// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeworkSubmissionImpl _$$HomeworkSubmissionImplFromJson(
  Map<String, dynamic> json,
) => _$HomeworkSubmissionImpl(
  id: json['id'] as String,
  storagePath: json['storagePath'] as String,
  hint: json['hint'] as String,
  submittedAtMs: (json['submittedAtMs'] as num).toInt(),
);

Map<String, dynamic> _$$HomeworkSubmissionImplToJson(
  _$HomeworkSubmissionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'storagePath': instance.storagePath,
  'hint': instance.hint,
  'submittedAtMs': instance.submittedAtMs,
};
