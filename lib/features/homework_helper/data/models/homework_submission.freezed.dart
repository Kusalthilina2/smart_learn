// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homework_submission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HomeworkSubmission _$HomeworkSubmissionFromJson(Map<String, dynamic> json) {
  return _HomeworkSubmission.fromJson(json);
}

/// @nodoc
mixin _$HomeworkSubmission {
  String get id => throw _privateConstructorUsedError;
  String get storagePath => throw _privateConstructorUsedError;
  String get hint => throw _privateConstructorUsedError;
  int get submittedAtMs => throw _privateConstructorUsedError;

  /// Serializes this HomeworkSubmission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeworkSubmission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeworkSubmissionCopyWith<HomeworkSubmission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeworkSubmissionCopyWith<$Res> {
  factory $HomeworkSubmissionCopyWith(
    HomeworkSubmission value,
    $Res Function(HomeworkSubmission) then,
  ) = _$HomeworkSubmissionCopyWithImpl<$Res, HomeworkSubmission>;
  @useResult
  $Res call({String id, String storagePath, String hint, int submittedAtMs});
}

/// @nodoc
class _$HomeworkSubmissionCopyWithImpl<$Res, $Val extends HomeworkSubmission>
    implements $HomeworkSubmissionCopyWith<$Res> {
  _$HomeworkSubmissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeworkSubmission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storagePath = null,
    Object? hint = null,
    Object? submittedAtMs = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            storagePath: null == storagePath
                ? _value.storagePath
                : storagePath // ignore: cast_nullable_to_non_nullable
                      as String,
            hint: null == hint
                ? _value.hint
                : hint // ignore: cast_nullable_to_non_nullable
                      as String,
            submittedAtMs: null == submittedAtMs
                ? _value.submittedAtMs
                : submittedAtMs // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeworkSubmissionImplCopyWith<$Res>
    implements $HomeworkSubmissionCopyWith<$Res> {
  factory _$$HomeworkSubmissionImplCopyWith(
    _$HomeworkSubmissionImpl value,
    $Res Function(_$HomeworkSubmissionImpl) then,
  ) = __$$HomeworkSubmissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String storagePath, String hint, int submittedAtMs});
}

/// @nodoc
class __$$HomeworkSubmissionImplCopyWithImpl<$Res>
    extends _$HomeworkSubmissionCopyWithImpl<$Res, _$HomeworkSubmissionImpl>
    implements _$$HomeworkSubmissionImplCopyWith<$Res> {
  __$$HomeworkSubmissionImplCopyWithImpl(
    _$HomeworkSubmissionImpl _value,
    $Res Function(_$HomeworkSubmissionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeworkSubmission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storagePath = null,
    Object? hint = null,
    Object? submittedAtMs = null,
  }) {
    return _then(
      _$HomeworkSubmissionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        storagePath: null == storagePath
            ? _value.storagePath
            : storagePath // ignore: cast_nullable_to_non_nullable
                  as String,
        hint: null == hint
            ? _value.hint
            : hint // ignore: cast_nullable_to_non_nullable
                  as String,
        submittedAtMs: null == submittedAtMs
            ? _value.submittedAtMs
            : submittedAtMs // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeworkSubmissionImpl implements _HomeworkSubmission {
  const _$HomeworkSubmissionImpl({
    required this.id,
    required this.storagePath,
    required this.hint,
    required this.submittedAtMs,
  });

  factory _$HomeworkSubmissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeworkSubmissionImplFromJson(json);

  @override
  final String id;
  @override
  final String storagePath;
  @override
  final String hint;
  @override
  final int submittedAtMs;

  @override
  String toString() {
    return 'HomeworkSubmission(id: $id, storagePath: $storagePath, hint: $hint, submittedAtMs: $submittedAtMs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeworkSubmissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storagePath, storagePath) ||
                other.storagePath == storagePath) &&
            (identical(other.hint, hint) || other.hint == hint) &&
            (identical(other.submittedAtMs, submittedAtMs) ||
                other.submittedAtMs == submittedAtMs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, storagePath, hint, submittedAtMs);

  /// Create a copy of HomeworkSubmission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeworkSubmissionImplCopyWith<_$HomeworkSubmissionImpl> get copyWith =>
      __$$HomeworkSubmissionImplCopyWithImpl<_$HomeworkSubmissionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeworkSubmissionImplToJson(this);
  }
}

abstract class _HomeworkSubmission implements HomeworkSubmission {
  const factory _HomeworkSubmission({
    required final String id,
    required final String storagePath,
    required final String hint,
    required final int submittedAtMs,
  }) = _$HomeworkSubmissionImpl;

  factory _HomeworkSubmission.fromJson(Map<String, dynamic> json) =
      _$HomeworkSubmissionImpl.fromJson;

  @override
  String get id;
  @override
  String get storagePath;
  @override
  String get hint;
  @override
  int get submittedAtMs;

  /// Create a copy of HomeworkSubmission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeworkSubmissionImplCopyWith<_$HomeworkSubmissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
