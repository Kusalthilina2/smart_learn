// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      emotionEnabled: json['emotionEnabled'] as bool,
      sensitivity: (json['sensitivity'] as num).toDouble(),
      parentGateEnabled: json['parentGateEnabled'] as bool,
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'emotionEnabled': instance.emotionEnabled,
      'sensitivity': instance.sensitivity,
      'parentGateEnabled': instance.parentGateEnabled,
    };
