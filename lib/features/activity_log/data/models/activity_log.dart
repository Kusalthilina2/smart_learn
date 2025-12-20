import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_log.freezed.dart';
part 'activity_log.g.dart';

@freezed
class ActivityLog with _$ActivityLog {
  const factory ActivityLog({
    required String id,
    required String activityType,
    required String description,
    required int timestampMs,
    Map<String, dynamic>? metadata,
  }) = _ActivityLog;

  factory ActivityLog.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogFromJson(json);
}
