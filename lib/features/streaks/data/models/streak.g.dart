// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StreakImpl _$$StreakImplFromJson(Map<String, dynamic> json) => _$StreakImpl(
  current: (json['current'] as num).toInt(),
  longest: (json['longest'] as num).toInt(),
  lastActiveDate: (json['lastActiveDate'] as num).toInt(),
);

Map<String, dynamic> _$$StreakImplToJson(_$StreakImpl instance) =>
    <String, dynamic>{
      'current': instance.current,
      'longest': instance.longest,
      'lastActiveDate': instance.lastActiveDate,
    };
