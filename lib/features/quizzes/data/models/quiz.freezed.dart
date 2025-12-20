// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuizQuestion _$QuizQuestionFromJson(Map<String, dynamic> json) {
  return _QuizQuestion.fromJson(json);
}

/// @nodoc
mixin _$QuizQuestion {
  String get question => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  int get correctIndex => throw _privateConstructorUsedError;

  /// Serializes this QuizQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizQuestionCopyWith<QuizQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizQuestionCopyWith<$Res> {
  factory $QuizQuestionCopyWith(
    QuizQuestion value,
    $Res Function(QuizQuestion) then,
  ) = _$QuizQuestionCopyWithImpl<$Res, QuizQuestion>;
  @useResult
  $Res call({String question, List<String> options, int correctIndex});
}

/// @nodoc
class _$QuizQuestionCopyWithImpl<$Res, $Val extends QuizQuestion>
    implements $QuizQuestionCopyWith<$Res> {
  _$QuizQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? options = null,
    Object? correctIndex = null,
  }) {
    return _then(
      _value.copyWith(
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            correctIndex: null == correctIndex
                ? _value.correctIndex
                : correctIndex // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuizQuestionImplCopyWith<$Res>
    implements $QuizQuestionCopyWith<$Res> {
  factory _$$QuizQuestionImplCopyWith(
    _$QuizQuestionImpl value,
    $Res Function(_$QuizQuestionImpl) then,
  ) = __$$QuizQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String question, List<String> options, int correctIndex});
}

/// @nodoc
class __$$QuizQuestionImplCopyWithImpl<$Res>
    extends _$QuizQuestionCopyWithImpl<$Res, _$QuizQuestionImpl>
    implements _$$QuizQuestionImplCopyWith<$Res> {
  __$$QuizQuestionImplCopyWithImpl(
    _$QuizQuestionImpl _value,
    $Res Function(_$QuizQuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? options = null,
    Object? correctIndex = null,
  }) {
    return _then(
      _$QuizQuestionImpl(
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        correctIndex: null == correctIndex
            ? _value.correctIndex
            : correctIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizQuestionImpl implements _QuizQuestion {
  const _$QuizQuestionImpl({
    required this.question,
    required final List<String> options,
    required this.correctIndex,
  }) : _options = options;

  factory _$QuizQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizQuestionImplFromJson(json);

  @override
  final String question;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final int correctIndex;

  @override
  String toString() {
    return 'QuizQuestion(question: $question, options: $options, correctIndex: $correctIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizQuestionImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.correctIndex, correctIndex) ||
                other.correctIndex == correctIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    question,
    const DeepCollectionEquality().hash(_options),
    correctIndex,
  );

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizQuestionImplCopyWith<_$QuizQuestionImpl> get copyWith =>
      __$$QuizQuestionImplCopyWithImpl<_$QuizQuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizQuestionImplToJson(this);
  }
}

abstract class _QuizQuestion implements QuizQuestion {
  const factory _QuizQuestion({
    required final String question,
    required final List<String> options,
    required final int correctIndex,
  }) = _$QuizQuestionImpl;

  factory _QuizQuestion.fromJson(Map<String, dynamic> json) =
      _$QuizQuestionImpl.fromJson;

  @override
  String get question;
  @override
  List<String> get options;
  @override
  int get correctIndex;

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizQuestionImplCopyWith<_$QuizQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Quiz _$QuizFromJson(Map<String, dynamic> json) {
  return _Quiz.fromJson(json);
}

/// @nodoc
mixin _$Quiz {
  String get id => throw _privateConstructorUsedError;
  String get subjectId => throw _privateConstructorUsedError;
  int get grade => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<QuizQuestion> get questions => throw _privateConstructorUsedError;

  /// Serializes this Quiz to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizCopyWith<Quiz> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizCopyWith<$Res> {
  factory $QuizCopyWith(Quiz value, $Res Function(Quiz) then) =
      _$QuizCopyWithImpl<$Res, Quiz>;
  @useResult
  $Res call({
    String id,
    String subjectId,
    int grade,
    String title,
    List<QuizQuestion> questions,
  });
}

/// @nodoc
class _$QuizCopyWithImpl<$Res, $Val extends Quiz>
    implements $QuizCopyWith<$Res> {
  _$QuizCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subjectId = null,
    Object? grade = null,
    Object? title = null,
    Object? questions = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            subjectId: null == subjectId
                ? _value.subjectId
                : subjectId // ignore: cast_nullable_to_non_nullable
                      as String,
            grade: null == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<QuizQuestion>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuizImplCopyWith<$Res> implements $QuizCopyWith<$Res> {
  factory _$$QuizImplCopyWith(
    _$QuizImpl value,
    $Res Function(_$QuizImpl) then,
  ) = __$$QuizImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String subjectId,
    int grade,
    String title,
    List<QuizQuestion> questions,
  });
}

/// @nodoc
class __$$QuizImplCopyWithImpl<$Res>
    extends _$QuizCopyWithImpl<$Res, _$QuizImpl>
    implements _$$QuizImplCopyWith<$Res> {
  __$$QuizImplCopyWithImpl(_$QuizImpl _value, $Res Function(_$QuizImpl) _then)
    : super(_value, _then);

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subjectId = null,
    Object? grade = null,
    Object? title = null,
    Object? questions = null,
  }) {
    return _then(
      _$QuizImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        subjectId: null == subjectId
            ? _value.subjectId
            : subjectId // ignore: cast_nullable_to_non_nullable
                  as String,
        grade: null == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<QuizQuestion>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizImpl implements _Quiz {
  const _$QuizImpl({
    required this.id,
    required this.subjectId,
    required this.grade,
    required this.title,
    required final List<QuizQuestion> questions,
  }) : _questions = questions;

  factory _$QuizImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizImplFromJson(json);

  @override
  final String id;
  @override
  final String subjectId;
  @override
  final int grade;
  @override
  final String title;
  final List<QuizQuestion> _questions;
  @override
  List<QuizQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  String toString() {
    return 'Quiz(id: $id, subjectId: $subjectId, grade: $grade, title: $title, questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    subjectId,
    grade,
    title,
    const DeepCollectionEquality().hash(_questions),
  );

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizImplCopyWith<_$QuizImpl> get copyWith =>
      __$$QuizImplCopyWithImpl<_$QuizImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizImplToJson(this);
  }
}

abstract class _Quiz implements Quiz {
  const factory _Quiz({
    required final String id,
    required final String subjectId,
    required final int grade,
    required final String title,
    required final List<QuizQuestion> questions,
  }) = _$QuizImpl;

  factory _Quiz.fromJson(Map<String, dynamic> json) = _$QuizImpl.fromJson;

  @override
  String get id;
  @override
  String get subjectId;
  @override
  int get grade;
  @override
  String get title;
  @override
  List<QuizQuestion> get questions;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizImplCopyWith<_$QuizImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuizAttempt _$QuizAttemptFromJson(Map<String, dynamic> json) {
  return _QuizAttempt.fromJson(json);
}

/// @nodoc
mixin _$QuizAttempt {
  String get id => throw _privateConstructorUsedError;
  String get quizId => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  int get attemptedAtMs => throw _privateConstructorUsedError;

  /// Serializes this QuizAttempt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizAttemptCopyWith<QuizAttempt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizAttemptCopyWith<$Res> {
  factory $QuizAttemptCopyWith(
    QuizAttempt value,
    $Res Function(QuizAttempt) then,
  ) = _$QuizAttemptCopyWithImpl<$Res, QuizAttempt>;
  @useResult
  $Res call({
    String id,
    String quizId,
    int score,
    int totalQuestions,
    int attemptedAtMs,
  });
}

/// @nodoc
class _$QuizAttemptCopyWithImpl<$Res, $Val extends QuizAttempt>
    implements $QuizAttemptCopyWith<$Res> {
  _$QuizAttemptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quizId = null,
    Object? score = null,
    Object? totalQuestions = null,
    Object? attemptedAtMs = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            quizId: null == quizId
                ? _value.quizId
                : quizId // ignore: cast_nullable_to_non_nullable
                      as String,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            totalQuestions: null == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            attemptedAtMs: null == attemptedAtMs
                ? _value.attemptedAtMs
                : attemptedAtMs // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuizAttemptImplCopyWith<$Res>
    implements $QuizAttemptCopyWith<$Res> {
  factory _$$QuizAttemptImplCopyWith(
    _$QuizAttemptImpl value,
    $Res Function(_$QuizAttemptImpl) then,
  ) = __$$QuizAttemptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String quizId,
    int score,
    int totalQuestions,
    int attemptedAtMs,
  });
}

/// @nodoc
class __$$QuizAttemptImplCopyWithImpl<$Res>
    extends _$QuizAttemptCopyWithImpl<$Res, _$QuizAttemptImpl>
    implements _$$QuizAttemptImplCopyWith<$Res> {
  __$$QuizAttemptImplCopyWithImpl(
    _$QuizAttemptImpl _value,
    $Res Function(_$QuizAttemptImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quizId = null,
    Object? score = null,
    Object? totalQuestions = null,
    Object? attemptedAtMs = null,
  }) {
    return _then(
      _$QuizAttemptImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        quizId: null == quizId
            ? _value.quizId
            : quizId // ignore: cast_nullable_to_non_nullable
                  as String,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        totalQuestions: null == totalQuestions
            ? _value.totalQuestions
            : totalQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        attemptedAtMs: null == attemptedAtMs
            ? _value.attemptedAtMs
            : attemptedAtMs // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizAttemptImpl implements _QuizAttempt {
  const _$QuizAttemptImpl({
    required this.id,
    required this.quizId,
    required this.score,
    required this.totalQuestions,
    required this.attemptedAtMs,
  });

  factory _$QuizAttemptImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizAttemptImplFromJson(json);

  @override
  final String id;
  @override
  final String quizId;
  @override
  final int score;
  @override
  final int totalQuestions;
  @override
  final int attemptedAtMs;

  @override
  String toString() {
    return 'QuizAttempt(id: $id, quizId: $quizId, score: $score, totalQuestions: $totalQuestions, attemptedAtMs: $attemptedAtMs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizAttemptImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.quizId, quizId) || other.quizId == quizId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.attemptedAtMs, attemptedAtMs) ||
                other.attemptedAtMs == attemptedAtMs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    quizId,
    score,
    totalQuestions,
    attemptedAtMs,
  );

  /// Create a copy of QuizAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizAttemptImplCopyWith<_$QuizAttemptImpl> get copyWith =>
      __$$QuizAttemptImplCopyWithImpl<_$QuizAttemptImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizAttemptImplToJson(this);
  }
}

abstract class _QuizAttempt implements QuizAttempt {
  const factory _QuizAttempt({
    required final String id,
    required final String quizId,
    required final int score,
    required final int totalQuestions,
    required final int attemptedAtMs,
  }) = _$QuizAttemptImpl;

  factory _QuizAttempt.fromJson(Map<String, dynamic> json) =
      _$QuizAttemptImpl.fromJson;

  @override
  String get id;
  @override
  String get quizId;
  @override
  int get score;
  @override
  int get totalQuestions;
  @override
  int get attemptedAtMs;

  /// Create a copy of QuizAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizAttemptImplCopyWith<_$QuizAttemptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
