// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Streak _$StreakFromJson(Map<String, dynamic> json) {
  return _Streak.fromJson(json);
}

/// @nodoc
mixin _$Streak {
  int get current => throw _privateConstructorUsedError;
  int get longest => throw _privateConstructorUsedError;
  int get lastActiveDate => throw _privateConstructorUsedError;

  /// Serializes this Streak to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Streak
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreakCopyWith<Streak> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreakCopyWith<$Res> {
  factory $StreakCopyWith(Streak value, $Res Function(Streak) then) =
      _$StreakCopyWithImpl<$Res, Streak>;
  @useResult
  $Res call({int current, int longest, int lastActiveDate});
}

/// @nodoc
class _$StreakCopyWithImpl<$Res, $Val extends Streak>
    implements $StreakCopyWith<$Res> {
  _$StreakCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Streak
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = null,
    Object? longest = null,
    Object? lastActiveDate = null,
  }) {
    return _then(
      _value.copyWith(
            current: null == current
                ? _value.current
                : current // ignore: cast_nullable_to_non_nullable
                      as int,
            longest: null == longest
                ? _value.longest
                : longest // ignore: cast_nullable_to_non_nullable
                      as int,
            lastActiveDate: null == lastActiveDate
                ? _value.lastActiveDate
                : lastActiveDate // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StreakImplCopyWith<$Res> implements $StreakCopyWith<$Res> {
  factory _$$StreakImplCopyWith(
    _$StreakImpl value,
    $Res Function(_$StreakImpl) then,
  ) = __$$StreakImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int current, int longest, int lastActiveDate});
}

/// @nodoc
class __$$StreakImplCopyWithImpl<$Res>
    extends _$StreakCopyWithImpl<$Res, _$StreakImpl>
    implements _$$StreakImplCopyWith<$Res> {
  __$$StreakImplCopyWithImpl(
    _$StreakImpl _value,
    $Res Function(_$StreakImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Streak
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = null,
    Object? longest = null,
    Object? lastActiveDate = null,
  }) {
    return _then(
      _$StreakImpl(
        current: null == current
            ? _value.current
            : current // ignore: cast_nullable_to_non_nullable
                  as int,
        longest: null == longest
            ? _value.longest
            : longest // ignore: cast_nullable_to_non_nullable
                  as int,
        lastActiveDate: null == lastActiveDate
            ? _value.lastActiveDate
            : lastActiveDate // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StreakImpl implements _Streak {
  const _$StreakImpl({
    required this.current,
    required this.longest,
    required this.lastActiveDate,
  });

  factory _$StreakImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreakImplFromJson(json);

  @override
  final int current;
  @override
  final int longest;
  @override
  final int lastActiveDate;

  @override
  String toString() {
    return 'Streak(current: $current, longest: $longest, lastActiveDate: $lastActiveDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreakImpl &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.longest, longest) || other.longest == longest) &&
            (identical(other.lastActiveDate, lastActiveDate) ||
                other.lastActiveDate == lastActiveDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, current, longest, lastActiveDate);

  /// Create a copy of Streak
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreakImplCopyWith<_$StreakImpl> get copyWith =>
      __$$StreakImplCopyWithImpl<_$StreakImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreakImplToJson(this);
  }
}

abstract class _Streak implements Streak {
  const factory _Streak({
    required final int current,
    required final int longest,
    required final int lastActiveDate,
  }) = _$StreakImpl;

  factory _Streak.fromJson(Map<String, dynamic> json) = _$StreakImpl.fromJson;

  @override
  int get current;
  @override
  int get longest;
  @override
  int get lastActiveDate;

  /// Create a copy of Streak
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreakImplCopyWith<_$StreakImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
