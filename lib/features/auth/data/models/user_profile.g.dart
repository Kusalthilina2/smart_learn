// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      childName: json['childName'] as String,
      grade: (json['grade'] as num).toInt(),
      parentEmail: json['parentEmail'] as String,
      createdAt: (json['createdAt'] as num).toInt(),
      lastLoginAt: (json['lastLoginAt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'childName': instance.childName,
      'grade': instance.grade,
      'parentEmail': instance.parentEmail,
      'createdAt': instance.createdAt,
      'lastLoginAt': instance.lastLoginAt,
    };
