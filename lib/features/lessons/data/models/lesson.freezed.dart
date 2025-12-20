// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ContentBlock _$ContentBlockFromJson(Map<String, dynamic> json) {
  return _ContentBlock.fromJson(json);
}

/// @nodoc
mixin _$ContentBlock {
  String get type => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get mediaUrl => throw _privateConstructorUsedError;

  /// Serializes this ContentBlock to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentBlockCopyWith<ContentBlock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentBlockCopyWith<$Res> {
  factory $ContentBlockCopyWith(
    ContentBlock value,
    $Res Function(ContentBlock) then,
  ) = _$ContentBlockCopyWithImpl<$Res, ContentBlock>;
  @useResult
  $Res call({String type, String content, String? mediaUrl});
}

/// @nodoc
class _$ContentBlockCopyWithImpl<$Res, $Val extends ContentBlock>
    implements $ContentBlockCopyWith<$Res> {
  _$ContentBlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? content = null,
    Object? mediaUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            mediaUrl: freezed == mediaUrl
                ? _value.mediaUrl
                : mediaUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContentBlockImplCopyWith<$Res>
    implements $ContentBlockCopyWith<$Res> {
  factory _$$ContentBlockImplCopyWith(
    _$ContentBlockImpl value,
    $Res Function(_$ContentBlockImpl) then,
  ) = __$$ContentBlockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String content, String? mediaUrl});
}

/// @nodoc
class __$$ContentBlockImplCopyWithImpl<$Res>
    extends _$ContentBlockCopyWithImpl<$Res, _$ContentBlockImpl>
    implements _$$ContentBlockImplCopyWith<$Res> {
  __$$ContentBlockImplCopyWithImpl(
    _$ContentBlockImpl _value,
    $Res Function(_$ContentBlockImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? content = null,
    Object? mediaUrl = freezed,
  }) {
    return _then(
      _$ContentBlockImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        mediaUrl: freezed == mediaUrl
            ? _value.mediaUrl
            : mediaUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentBlockImpl implements _ContentBlock {
  const _$ContentBlockImpl({
    required this.type,
    required this.content,
    this.mediaUrl,
  });

  factory _$ContentBlockImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentBlockImplFromJson(json);

  @override
  final String type;
  @override
  final String content;
  @override
  final String? mediaUrl;

  @override
  String toString() {
    return 'ContentBlock(type: $type, content: $content, mediaUrl: $mediaUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentBlockImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.mediaUrl, mediaUrl) ||
                other.mediaUrl == mediaUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, content, mediaUrl);

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentBlockImplCopyWith<_$ContentBlockImpl> get copyWith =>
      __$$ContentBlockImplCopyWithImpl<_$ContentBlockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentBlockImplToJson(this);
  }
}

abstract class _ContentBlock implements ContentBlock {
  const factory _ContentBlock({
    required final String type,
    required final String content,
    final String? mediaUrl,
  }) = _$ContentBlockImpl;

  factory _ContentBlock.fromJson(Map<String, dynamic> json) =
      _$ContentBlockImpl.fromJson;

  @override
  String get type;
  @override
  String get content;
  @override
  String? get mediaUrl;

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentBlockImplCopyWith<_$ContentBlockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  return _Lesson.fromJson(json);
}

/// @nodoc
mixin _$Lesson {
  String get id => throw _privateConstructorUsedError;
  String get subjectId => throw _privateConstructorUsedError;
  int get grade => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<ContentBlock> get contentBlocks => throw _privateConstructorUsedError;
  int get views => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;

  /// Serializes this Lesson to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonCopyWith<Lesson> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonCopyWith<$Res> {
  factory $LessonCopyWith(Lesson value, $Res Function(Lesson) then) =
      _$LessonCopyWithImpl<$Res, Lesson>;
  @useResult
  $Res call({
    String id,
    String subjectId,
    int grade,
    String title,
    String description,
    List<ContentBlock> contentBlocks,
    int views,
    double rating,
  });
}

/// @nodoc
class _$LessonCopyWithImpl<$Res, $Val extends Lesson>
    implements $LessonCopyWith<$Res> {
  _$LessonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subjectId = null,
    Object? grade = null,
    Object? title = null,
    Object? description = null,
    Object? contentBlocks = null,
    Object? views = null,
    Object? rating = null,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            contentBlocks: null == contentBlocks
                ? _value.contentBlocks
                : contentBlocks // ignore: cast_nullable_to_non_nullable
                      as List<ContentBlock>,
            views: null == views
                ? _value.views
                : views // ignore: cast_nullable_to_non_nullable
                      as int,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LessonImplCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$$LessonImplCopyWith(
    _$LessonImpl value,
    $Res Function(_$LessonImpl) then,
  ) = __$$LessonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String subjectId,
    int grade,
    String title,
    String description,
    List<ContentBlock> contentBlocks,
    int views,
    double rating,
  });
}

/// @nodoc
class __$$LessonImplCopyWithImpl<$Res>
    extends _$LessonCopyWithImpl<$Res, _$LessonImpl>
    implements _$$LessonImplCopyWith<$Res> {
  __$$LessonImplCopyWithImpl(
    _$LessonImpl _value,
    $Res Function(_$LessonImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subjectId = null,
    Object? grade = null,
    Object? title = null,
    Object? description = null,
    Object? contentBlocks = null,
    Object? views = null,
    Object? rating = null,
  }) {
    return _then(
      _$LessonImpl(
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
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        contentBlocks: null == contentBlocks
            ? _value._contentBlocks
            : contentBlocks // ignore: cast_nullable_to_non_nullable
                  as List<ContentBlock>,
        views: null == views
            ? _value.views
            : views // ignore: cast_nullable_to_non_nullable
                  as int,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonImpl implements _Lesson {
  const _$LessonImpl({
    required this.id,
    required this.subjectId,
    required this.grade,
    required this.title,
    required this.description,
    required final List<ContentBlock> contentBlocks,
    required this.views,
    required this.rating,
  }) : _contentBlocks = contentBlocks;

  factory _$LessonImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonImplFromJson(json);

  @override
  final String id;
  @override
  final String subjectId;
  @override
  final int grade;
  @override
  final String title;
  @override
  final String description;
  final List<ContentBlock> _contentBlocks;
  @override
  List<ContentBlock> get contentBlocks {
    if (_contentBlocks is EqualUnmodifiableListView) return _contentBlocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contentBlocks);
  }

  @override
  final int views;
  @override
  final double rating;

  @override
  String toString() {
    return 'Lesson(id: $id, subjectId: $subjectId, grade: $grade, title: $title, description: $description, contentBlocks: $contentBlocks, views: $views, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._contentBlocks,
              _contentBlocks,
            ) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    subjectId,
    grade,
    title,
    description,
    const DeepCollectionEquality().hash(_contentBlocks),
    views,
    rating,
  );

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonImplCopyWith<_$LessonImpl> get copyWith =>
      __$$LessonImplCopyWithImpl<_$LessonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonImplToJson(this);
  }
}

abstract class _Lesson implements Lesson {
  const factory _Lesson({
    required final String id,
    required final String subjectId,
    required final int grade,
    required final String title,
    required final String description,
    required final List<ContentBlock> contentBlocks,
    required final int views,
    required final double rating,
  }) = _$LessonImpl;

  factory _Lesson.fromJson(Map<String, dynamic> json) = _$LessonImpl.fromJson;

  @override
  String get id;
  @override
  String get subjectId;
  @override
  int get grade;
  @override
  String get title;
  @override
  String get description;
  @override
  List<ContentBlock> get contentBlocks;
  @override
  int get views;
  @override
  double get rating;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonImplCopyWith<_$LessonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LessonProgress _$LessonProgressFromJson(Map<String, dynamic> json) {
  return _LessonProgress.fromJson(json);
}

/// @nodoc
mixin _$LessonProgress {
  String get lessonId => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  int get updatedAtMs => throw _privateConstructorUsedError;

  /// Serializes this LessonProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonProgressCopyWith<LessonProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonProgressCopyWith<$Res> {
  factory $LessonProgressCopyWith(
    LessonProgress value,
    $Res Function(LessonProgress) then,
  ) = _$LessonProgressCopyWithImpl<$Res, LessonProgress>;
  @useResult
  $Res call({String lessonId, bool completed, int updatedAtMs});
}

/// @nodoc
class _$LessonProgressCopyWithImpl<$Res, $Val extends LessonProgress>
    implements $LessonProgressCopyWith<$Res> {
  _$LessonProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessonId = null,
    Object? completed = null,
    Object? updatedAtMs = null,
  }) {
    return _then(
      _value.copyWith(
            lessonId: null == lessonId
                ? _value.lessonId
                : lessonId // ignore: cast_nullable_to_non_nullable
                      as String,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
            updatedAtMs: null == updatedAtMs
                ? _value.updatedAtMs
                : updatedAtMs // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LessonProgressImplCopyWith<$Res>
    implements $LessonProgressCopyWith<$Res> {
  factory _$$LessonProgressImplCopyWith(
    _$LessonProgressImpl value,
    $Res Function(_$LessonProgressImpl) then,
  ) = __$$LessonProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String lessonId, bool completed, int updatedAtMs});
}

/// @nodoc
class __$$LessonProgressImplCopyWithImpl<$Res>
    extends _$LessonProgressCopyWithImpl<$Res, _$LessonProgressImpl>
    implements _$$LessonProgressImplCopyWith<$Res> {
  __$$LessonProgressImplCopyWithImpl(
    _$LessonProgressImpl _value,
    $Res Function(_$LessonProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessonId = null,
    Object? completed = null,
    Object? updatedAtMs = null,
  }) {
    return _then(
      _$LessonProgressImpl(
        lessonId: null == lessonId
            ? _value.lessonId
            : lessonId // ignore: cast_nullable_to_non_nullable
                  as String,
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as bool,
        updatedAtMs: null == updatedAtMs
            ? _value.updatedAtMs
            : updatedAtMs // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonProgressImpl implements _LessonProgress {
  const _$LessonProgressImpl({
    required this.lessonId,
    required this.completed,
    required this.updatedAtMs,
  });

  factory _$LessonProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonProgressImplFromJson(json);

  @override
  final String lessonId;
  @override
  final bool completed;
  @override
  final int updatedAtMs;

  @override
  String toString() {
    return 'LessonProgress(lessonId: $lessonId, completed: $completed, updatedAtMs: $updatedAtMs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonProgressImpl &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.updatedAtMs, updatedAtMs) ||
                other.updatedAtMs == updatedAtMs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, lessonId, completed, updatedAtMs);

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonProgressImplCopyWith<_$LessonProgressImpl> get copyWith =>
      __$$LessonProgressImplCopyWithImpl<_$LessonProgressImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonProgressImplToJson(this);
  }
}

abstract class _LessonProgress implements LessonProgress {
  const factory _LessonProgress({
    required final String lessonId,
    required final bool completed,
    required final int updatedAtMs,
  }) = _$LessonProgressImpl;

  factory _LessonProgress.fromJson(Map<String, dynamic> json) =
      _$LessonProgressImpl.fromJson;

  @override
  String get lessonId;
  @override
  bool get completed;
  @override
  int get updatedAtMs;

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonProgressImplCopyWith<_$LessonProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
