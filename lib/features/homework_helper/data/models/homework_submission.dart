import 'package:freezed_annotation/freezed_annotation.dart';

part 'homework_submission.freezed.dart';
part 'homework_submission.g.dart';

@freezed
class HomeworkSubmission with _$HomeworkSubmission {
  const factory HomeworkSubmission({
    required String id,
    required String storagePath,
    required String hint,
    required int submittedAtMs,
  }) = _HomeworkSubmission;

  factory HomeworkSubmission.fromJson(Map<String, dynamic> json) =>
      _$HomeworkSubmissionFromJson(json);
}
