// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flashcard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Flashcard _$FlashcardFromJson(Map<String, dynamic> json) {
  return _Flashcard.fromJson(json);
}

/// @nodoc
mixin _$Flashcard {
  String get id => throw _privateConstructorUsedError;
  String get front => throw _privateConstructorUsedError;
  String get back => throw _privateConstructorUsedError;
  int get lastReviewedMs => throw _privateConstructorUsedError;
  int get nextReviewMs => throw _privateConstructorUsedError;
  int get repetitions => throw _privateConstructorUsedError;
  double get easeFactor => throw _privateConstructorUsedError;

  /// Serializes this Flashcard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlashcardCopyWith<Flashcard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlashcardCopyWith<$Res> {
  factory $FlashcardCopyWith(Flashcard value, $Res Function(Flashcard) then) =
      _$FlashcardCopyWithImpl<$Res, Flashcard>;
  @useResult
  $Res call({
    String id,
    String front,
    String back,
    int lastReviewedMs,
    int nextReviewMs,
    int repetitions,
    double easeFactor,
  });
}

/// @nodoc
class _$FlashcardCopyWithImpl<$Res, $Val extends Flashcard>
    implements $FlashcardCopyWith<$Res> {
  _$FlashcardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? front = null,
    Object? back = null,
    Object? lastReviewedMs = null,
    Object? nextReviewMs = null,
    Object? repetitions = null,
    Object? easeFactor = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            front: null == front
                ? _value.front
                : front // ignore: cast_nullable_to_non_nullable
                      as String,
            back: null == back
                ? _value.back
                : back // ignore: cast_nullable_to_non_nullable
                      as String,
            lastReviewedMs: null == lastReviewedMs
                ? _value.lastReviewedMs
                : lastReviewedMs // ignore: cast_nullable_to_non_nullable
                      as int,
            nextReviewMs: null == nextReviewMs
                ? _value.nextReviewMs
                : nextReviewMs // ignore: cast_nullable_to_non_nullable
                      as int,
            repetitions: null == repetitions
                ? _value.repetitions
                : repetitions // ignore: cast_nullable_to_non_nullable
                      as int,
            easeFactor: null == easeFactor
                ? _value.easeFactor
                : easeFactor // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FlashcardImplCopyWith<$Res>
    implements $FlashcardCopyWith<$Res> {
  factory _$$FlashcardImplCopyWith(
    _$FlashcardImpl value,
    $Res Function(_$FlashcardImpl) then,
  ) = __$$FlashcardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String front,
    String back,
    int lastReviewedMs,
    int nextReviewMs,
    int repetitions,
    double easeFactor,
  });
}

/// @nodoc
class __$$FlashcardImplCopyWithImpl<$Res>
    extends _$FlashcardCopyWithImpl<$Res, _$FlashcardImpl>
    implements _$$FlashcardImplCopyWith<$Res> {
  __$$FlashcardImplCopyWithImpl(
    _$FlashcardImpl _value,
    $Res Function(_$FlashcardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? front = null,
    Object? back = null,
    Object? lastReviewedMs = null,
    Object? nextReviewMs = null,
    Object? repetitions = null,
    Object? easeFactor = null,
  }) {
    return _then(
      _$FlashcardImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        front: null == front
            ? _value.front
            : front // ignore: cast_nullable_to_non_nullable
                  as String,
        back: null == back
            ? _value.back
            : back // ignore: cast_nullable_to_non_nullable
                  as String,
        lastReviewedMs: null == lastReviewedMs
            ? _value.lastReviewedMs
            : lastReviewedMs // ignore: cast_nullable_to_non_nullable
                  as int,
        nextReviewMs: null == nextReviewMs
            ? _value.nextReviewMs
            : nextReviewMs // ignore: cast_nullable_to_non_nullable
                  as int,
        repetitions: null == repetitions
            ? _value.repetitions
            : repetitions // ignore: cast_nullable_to_non_nullable
                  as int,
        easeFactor: null == easeFactor
            ? _value.easeFactor
            : easeFactor // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FlashcardImpl implements _Flashcard {
  const _$FlashcardImpl({
    required this.id,
    required this.front,
    required this.back,
    required this.lastReviewedMs,
    required this.nextReviewMs,
    required this.repetitions,
    required this.easeFactor,
  });

  factory _$FlashcardImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlashcardImplFromJson(json);

  @override
  final String id;
  @override
  final String front;
  @override
  final String back;
  @override
  final int lastReviewedMs;
  @override
  final int nextReviewMs;
  @override
  final int repetitions;
  @override
  final double easeFactor;

  @override
  String toString() {
    return 'Flashcard(id: $id, front: $front, back: $back, lastReviewedMs: $lastReviewedMs, nextReviewMs: $nextReviewMs, repetitions: $repetitions, easeFactor: $easeFactor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlashcardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.front, front) || other.front == front) &&
            (identical(other.back, back) || other.back == back) &&
            (identical(other.lastReviewedMs, lastReviewedMs) ||
                other.lastReviewedMs == lastReviewedMs) &&
            (identical(other.nextReviewMs, nextReviewMs) ||
                other.nextReviewMs == nextReviewMs) &&
            (identical(other.repetitions, repetitions) ||
                other.repetitions == repetitions) &&
            (identical(other.easeFactor, easeFactor) ||
                other.easeFactor == easeFactor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    front,
    back,
    lastReviewedMs,
    nextReviewMs,
    repetitions,
    easeFactor,
  );

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlashcardImplCopyWith<_$FlashcardImpl> get copyWith =>
      __$$FlashcardImplCopyWithImpl<_$FlashcardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlashcardImplToJson(this);
  }
}

abstract class _Flashcard implements Flashcard {
  const factory _Flashcard({
    required final String id,
    required final String front,
    required final String back,
    required final int lastReviewedMs,
    required final int nextReviewMs,
    required final int repetitions,
    required final double easeFactor,
  }) = _$FlashcardImpl;

  factory _Flashcard.fromJson(Map<String, dynamic> json) =
      _$FlashcardImpl.fromJson;

  @override
  String get id;
  @override
  String get front;
  @override
  String get back;
  @override
  int get lastReviewedMs;
  @override
  int get nextReviewMs;
  @override
  int get repetitions;
  @override
  double get easeFactor;

  /// Create a copy of Flashcard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlashcardImplCopyWith<_$FlashcardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FlashcardDeck _$FlashcardDeckFromJson(Map<String, dynamic> json) {
  return _FlashcardDeck.fromJson(json);
}

/// @nodoc
mixin _$FlashcardDeck {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get subjectId => throw _privateConstructorUsedError;
  int get grade => throw _privateConstructorUsedError;
  List<Flashcard> get cards => throw _privateConstructorUsedError;
  bool get isCustom => throw _privateConstructorUsedError;

  /// Serializes this FlashcardDeck to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlashcardDeck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlashcardDeckCopyWith<FlashcardDeck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlashcardDeckCopyWith<$Res> {
  factory $FlashcardDeckCopyWith(
    FlashcardDeck value,
    $Res Function(FlashcardDeck) then,
  ) = _$FlashcardDeckCopyWithImpl<$Res, FlashcardDeck>;
  @useResult
  $Res call({
    String id,
    String title,
    String? subjectId,
    int grade,
    List<Flashcard> cards,
    bool isCustom,
  });
}

/// @nodoc
class _$FlashcardDeckCopyWithImpl<$Res, $Val extends FlashcardDeck>
    implements $FlashcardDeckCopyWith<$Res> {
  _$FlashcardDeckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlashcardDeck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subjectId = freezed,
    Object? grade = null,
    Object? cards = null,
    Object? isCustom = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subjectId: freezed == subjectId
                ? _value.subjectId
                : subjectId // ignore: cast_nullable_to_non_nullable
                      as String?,
            grade: null == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int,
            cards: null == cards
                ? _value.cards
                : cards // ignore: cast_nullable_to_non_nullable
                      as List<Flashcard>,
            isCustom: null == isCustom
                ? _value.isCustom
                : isCustom // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FlashcardDeckImplCopyWith<$Res>
    implements $FlashcardDeckCopyWith<$Res> {
  factory _$$FlashcardDeckImplCopyWith(
    _$FlashcardDeckImpl value,
    $Res Function(_$FlashcardDeckImpl) then,
  ) = __$$FlashcardDeckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? subjectId,
    int grade,
    List<Flashcard> cards,
    bool isCustom,
  });
}

/// @nodoc
class __$$FlashcardDeckImplCopyWithImpl<$Res>
    extends _$FlashcardDeckCopyWithImpl<$Res, _$FlashcardDeckImpl>
    implements _$$FlashcardDeckImplCopyWith<$Res> {
  __$$FlashcardDeckImplCopyWithImpl(
    _$FlashcardDeckImpl _value,
    $Res Function(_$FlashcardDeckImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FlashcardDeck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subjectId = freezed,
    Object? grade = null,
    Object? cards = null,
    Object? isCustom = null,
  }) {
    return _then(
      _$FlashcardDeckImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subjectId: freezed == subjectId
            ? _value.subjectId
            : subjectId // ignore: cast_nullable_to_non_nullable
                  as String?,
        grade: null == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int,
        cards: null == cards
            ? _value._cards
            : cards // ignore: cast_nullable_to_non_nullable
                  as List<Flashcard>,
        isCustom: null == isCustom
            ? _value.isCustom
            : isCustom // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FlashcardDeckImpl implements _FlashcardDeck {
  const _$FlashcardDeckImpl({
    required this.id,
    required this.title,
    required this.subjectId,
    required this.grade,
    required final List<Flashcard> cards,
    required this.isCustom,
  }) : _cards = cards;

  factory _$FlashcardDeckImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlashcardDeckImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? subjectId;
  @override
  final int grade;
  final List<Flashcard> _cards;
  @override
  List<Flashcard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  final bool isCustom;

  @override
  String toString() {
    return 'FlashcardDeck(id: $id, title: $title, subjectId: $subjectId, grade: $grade, cards: $cards, isCustom: $isCustom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlashcardDeckImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    subjectId,
    grade,
    const DeepCollectionEquality().hash(_cards),
    isCustom,
  );

  /// Create a copy of FlashcardDeck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlashcardDeckImplCopyWith<_$FlashcardDeckImpl> get copyWith =>
      __$$FlashcardDeckImplCopyWithImpl<_$FlashcardDeckImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlashcardDeckImplToJson(this);
  }
}

abstract class _FlashcardDeck implements FlashcardDeck {
  const factory _FlashcardDeck({
    required final String id,
    required final String title,
    required final String? subjectId,
    required final int grade,
    required final List<Flashcard> cards,
    required final bool isCustom,
  }) = _$FlashcardDeckImpl;

  factory _FlashcardDeck.fromJson(Map<String, dynamic> json) =
      _$FlashcardDeckImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get subjectId;
  @override
  int get grade;
  @override
  List<Flashcard> get cards;
  @override
  bool get isCustom;

  /// Create a copy of FlashcardDeck
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlashcardDeckImplCopyWith<_$FlashcardDeckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
