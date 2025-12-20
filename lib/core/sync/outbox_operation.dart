import 'package:freezed_annotation/freezed_annotation.dart';

part 'outbox_operation.freezed.dart';
part 'outbox_operation.g.dart';

enum OutboxOpType {
  setDoc,
  updateDoc,
  addDoc,
  deleteDoc,
  uploadFileMeta,
}

enum OutboxStatus {
  pending,
  inflight,
  failed,
}

@freezed
class OutboxOperation with _$OutboxOperation {
  const factory OutboxOperation({
    required String id,
    required int createdAtMs,
    required OutboxOpType op,
    required String path,
    required Map<String, dynamic> payload,
    required OutboxStatus status,
    required int retryCount,
    String? lastError,
  }) = _OutboxOperation;

  factory OutboxOperation.fromJson(Map<String, dynamic> json) =>
      _$OutboxOperationFromJson(json);
}

Map<String, dynamic> _payloadFromJson(Object? json) {
  if (json == null) return {};
  if (json is Map<String, dynamic>) return json;
  if (json is Map) return json.cast<String, dynamic>();
  return {};
}
