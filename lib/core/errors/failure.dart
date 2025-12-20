import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.network(String message) = _NetworkFailure;
  const factory Failure.server(String message) = _ServerFailure;
  const factory Failure.auth(String message) = _AuthFailure;
  const factory Failure.storage(String message) = _StorageFailure;
  const factory Failure.sync(String message) = _SyncFailure;
  const factory Failure.unknown(String message) = _UnknownFailure;
}
