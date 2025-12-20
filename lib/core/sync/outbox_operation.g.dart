// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outbox_operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OutboxOperationImpl _$$OutboxOperationImplFromJson(
  Map<String, dynamic> json,
) => _$OutboxOperationImpl(
  id: json['id'] as String,
  createdAtMs: (json['createdAtMs'] as num).toInt(),
  op: $enumDecode(_$OutboxOpTypeEnumMap, json['op']),
  path: json['path'] as String,
  payload: _payloadFromJson(json['payload']),
  status: $enumDecode(_$OutboxStatusEnumMap, json['status']),
  retryCount: (json['retryCount'] as num).toInt(),
  lastError: json['lastError'] as String?,
);

Map<String, dynamic> _$$OutboxOperationImplToJson(
  _$OutboxOperationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAtMs': instance.createdAtMs,
  'op': _$OutboxOpTypeEnumMap[instance.op]!,
  'path': instance.path,
  'payload': instance.payload,
  'status': _$OutboxStatusEnumMap[instance.status]!,
  'retryCount': instance.retryCount,
  'lastError': instance.lastError,
};

const _$OutboxOpTypeEnumMap = {
  OutboxOpType.setDoc: 'setDoc',
  OutboxOpType.updateDoc: 'updateDoc',
  OutboxOpType.addDoc: 'addDoc',
  OutboxOpType.deleteDoc: 'deleteDoc',
  OutboxOpType.uploadFileMeta: 'uploadFileMeta',
};

const _$OutboxStatusEnumMap = {
  OutboxStatus.pending: 'pending',
  OutboxStatus.inflight: 'inflight',
  OutboxStatus.failed: 'failed',
};
