// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outbox_operation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OutboxOperation _$OutboxOperationFromJson(Map<String, dynamic> json) {
  return _OutboxOperation.fromJson(json);
}

/// @nodoc
mixin _$OutboxOperation {
  String get id => throw _privateConstructorUsedError;
  int get createdAtMs => throw _privateConstructorUsedError;
  OutboxOpType get op => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _payloadFromJson)
  Map<String, dynamic> get payload => throw _privateConstructorUsedError;
  OutboxStatus get status => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;
  String? get lastError => throw _privateConstructorUsedError;

  /// Serializes this OutboxOperation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OutboxOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OutboxOperationCopyWith<OutboxOperation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutboxOperationCopyWith<$Res> {
  factory $OutboxOperationCopyWith(
    OutboxOperation value,
    $Res Function(OutboxOperation) then,
  ) = _$OutboxOperationCopyWithImpl<$Res, OutboxOperation>;
  @useResult
  $Res call({
    String id,
    int createdAtMs,
    OutboxOpType op,
    String path,
    @JsonKey(fromJson: _payloadFromJson) Map<String, dynamic> payload,
    OutboxStatus status,
    int retryCount,
    String? lastError,
  });
}

/// @nodoc
class _$OutboxOperationCopyWithImpl<$Res, $Val extends OutboxOperation>
    implements $OutboxOperationCopyWith<$Res> {
  _$OutboxOperationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutboxOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAtMs = null,
    Object? op = null,
    Object? path = null,
    Object? payload = null,
    Object? status = null,
    Object? retryCount = null,
    Object? lastError = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAtMs: null == createdAtMs
                ? _value.createdAtMs
                : createdAtMs // ignore: cast_nullable_to_non_nullable
                      as int,
            op: null == op
                ? _value.op
                : op // ignore: cast_nullable_to_non_nullable
                      as OutboxOpType,
            path: null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String,
            payload: null == payload
                ? _value.payload
                : payload // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as OutboxStatus,
            retryCount: null == retryCount
                ? _value.retryCount
                : retryCount // ignore: cast_nullable_to_non_nullable
                      as int,
            lastError: freezed == lastError
                ? _value.lastError
                : lastError // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OutboxOperationImplCopyWith<$Res>
    implements $OutboxOperationCopyWith<$Res> {
  factory _$$OutboxOperationImplCopyWith(
    _$OutboxOperationImpl value,
    $Res Function(_$OutboxOperationImpl) then,
  ) = __$$OutboxOperationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int createdAtMs,
    OutboxOpType op,
    String path,
    @JsonKey(fromJson: _payloadFromJson) Map<String, dynamic> payload,
    OutboxStatus status,
    int retryCount,
    String? lastError,
  });
}

/// @nodoc
class __$$OutboxOperationImplCopyWithImpl<$Res>
    extends _$OutboxOperationCopyWithImpl<$Res, _$OutboxOperationImpl>
    implements _$$OutboxOperationImplCopyWith<$Res> {
  __$$OutboxOperationImplCopyWithImpl(
    _$OutboxOperationImpl _value,
    $Res Function(_$OutboxOperationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboxOperation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAtMs = null,
    Object? op = null,
    Object? path = null,
    Object? payload = null,
    Object? status = null,
    Object? retryCount = null,
    Object? lastError = freezed,
  }) {
    return _then(
      _$OutboxOperationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAtMs: null == createdAtMs
            ? _value.createdAtMs
            : createdAtMs // ignore: cast_nullable_to_non_nullable
                  as int,
        op: null == op
            ? _value.op
            : op // ignore: cast_nullable_to_non_nullable
                  as OutboxOpType,
        path: null == path
            ? _value.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        payload: null == payload
            ? _value._payload
            : payload // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as OutboxStatus,
        retryCount: null == retryCount
            ? _value.retryCount
            : retryCount // ignore: cast_nullable_to_non_nullable
                  as int,
        lastError: freezed == lastError
            ? _value.lastError
            : lastError // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OutboxOperationImpl implements _OutboxOperation {
  const _$OutboxOperationImpl({
    required this.id,
    required this.createdAtMs,
    required this.op,
    required this.path,
    @JsonKey(fromJson: _payloadFromJson)
    required final Map<String, dynamic> payload,
    required this.status,
    required this.retryCount,
    this.lastError,
  }) : _payload = payload;

  factory _$OutboxOperationImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutboxOperationImplFromJson(json);

  @override
  final String id;
  @override
  final int createdAtMs;
  @override
  final OutboxOpType op;
  @override
  final String path;
  final Map<String, dynamic> _payload;
  @override
  @JsonKey(fromJson: _payloadFromJson)
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @override
  final OutboxStatus status;
  @override
  final int retryCount;
  @override
  final String? lastError;

  @override
  String toString() {
    return 'OutboxOperation(id: $id, createdAtMs: $createdAtMs, op: $op, path: $path, payload: $payload, status: $status, retryCount: $retryCount, lastError: $lastError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboxOperationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAtMs, createdAtMs) ||
                other.createdAtMs == createdAtMs) &&
            (identical(other.op, op) || other.op == op) &&
            (identical(other.path, path) || other.path == path) &&
            const DeepCollectionEquality().equals(other._payload, _payload) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount) &&
            (identical(other.lastError, lastError) ||
                other.lastError == lastError));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    createdAtMs,
    op,
    path,
    const DeepCollectionEquality().hash(_payload),
    status,
    retryCount,
    lastError,
  );

  /// Create a copy of OutboxOperation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutboxOperationImplCopyWith<_$OutboxOperationImpl> get copyWith =>
      __$$OutboxOperationImplCopyWithImpl<_$OutboxOperationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OutboxOperationImplToJson(this);
  }
}

abstract class _OutboxOperation implements OutboxOperation {
  const factory _OutboxOperation({
    required final String id,
    required final int createdAtMs,
    required final OutboxOpType op,
    required final String path,
    @JsonKey(fromJson: _payloadFromJson)
    required final Map<String, dynamic> payload,
    required final OutboxStatus status,
    required final int retryCount,
    final String? lastError,
  }) = _$OutboxOperationImpl;

  factory _OutboxOperation.fromJson(Map<String, dynamic> json) =
      _$OutboxOperationImpl.fromJson;

  @override
  String get id;
  @override
  int get createdAtMs;
  @override
  OutboxOpType get op;
  @override
  String get path;
  @override
  @JsonKey(fromJson: _payloadFromJson)
  Map<String, dynamic> get payload;
  @override
  OutboxStatus get status;
  @override
  int get retryCount;
  @override
  String? get lastError;

  /// Create a copy of OutboxOperation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutboxOperationImplCopyWith<_$OutboxOperationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
