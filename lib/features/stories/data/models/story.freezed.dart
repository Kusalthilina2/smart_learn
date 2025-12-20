// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoryPage _$StoryPageFromJson(Map<String, dynamic> json) {
  return _StoryPage.fromJson(json);
}

/// @nodoc
mixin _$StoryPage {
  String get text => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get audioUrl => throw _privateConstructorUsedError;

  /// Serializes this StoryPage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryPageCopyWith<StoryPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryPageCopyWith<$Res> {
  factory $StoryPageCopyWith(StoryPage value, $Res Function(StoryPage) then) =
      _$StoryPageCopyWithImpl<$Res, StoryPage>;
  @useResult
  $Res call({String text, String? imageUrl, String? audioUrl});
}

/// @nodoc
class _$StoryPageCopyWithImpl<$Res, $Val extends StoryPage>
    implements $StoryPageCopyWith<$Res> {
  _$StoryPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? imageUrl = freezed,
    Object? audioUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            audioUrl: freezed == audioUrl
                ? _value.audioUrl
                : audioUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryPageImplCopyWith<$Res>
    implements $StoryPageCopyWith<$Res> {
  factory _$$StoryPageImplCopyWith(
    _$StoryPageImpl value,
    $Res Function(_$StoryPageImpl) then,
  ) = __$$StoryPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? imageUrl, String? audioUrl});
}

/// @nodoc
class __$$StoryPageImplCopyWithImpl<$Res>
    extends _$StoryPageCopyWithImpl<$Res, _$StoryPageImpl>
    implements _$$StoryPageImplCopyWith<$Res> {
  __$$StoryPageImplCopyWithImpl(
    _$StoryPageImpl _value,
    $Res Function(_$StoryPageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? imageUrl = freezed,
    Object? audioUrl = freezed,
  }) {
    return _then(
      _$StoryPageImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        audioUrl: freezed == audioUrl
            ? _value.audioUrl
            : audioUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryPageImpl implements _StoryPage {
  const _$StoryPageImpl({required this.text, this.imageUrl, this.audioUrl});

  factory _$StoryPageImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryPageImplFromJson(json);

  @override
  final String text;
  @override
  final String? imageUrl;
  @override
  final String? audioUrl;

  @override
  String toString() {
    return 'StoryPage(text: $text, imageUrl: $imageUrl, audioUrl: $audioUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryPageImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, imageUrl, audioUrl);

  /// Create a copy of StoryPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryPageImplCopyWith<_$StoryPageImpl> get copyWith =>
      __$$StoryPageImplCopyWithImpl<_$StoryPageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryPageImplToJson(this);
  }
}

abstract class _StoryPage implements StoryPage {
  const factory _StoryPage({
    required final String text,
    final String? imageUrl,
    final String? audioUrl,
  }) = _$StoryPageImpl;

  factory _StoryPage.fromJson(Map<String, dynamic> json) =
      _$StoryPageImpl.fromJson;

  @override
  String get text;
  @override
  String? get imageUrl;
  @override
  String? get audioUrl;

  /// Create a copy of StoryPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryPageImplCopyWith<_$StoryPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Story _$StoryFromJson(Map<String, dynamic> json) {
  return _Story.fromJson(json);
}

/// @nodoc
mixin _$Story {
  String get id => throw _privateConstructorUsedError;
  String get subjectId => throw _privateConstructorUsedError;
  int get grade => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<StoryPage> get pages => throw _privateConstructorUsedError;

  /// Serializes this Story to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryCopyWith<Story> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryCopyWith<$Res> {
  factory $StoryCopyWith(Story value, $Res Function(Story) then) =
      _$StoryCopyWithImpl<$Res, Story>;
  @useResult
  $Res call({
    String id,
    String subjectId,
    int grade,
    String title,
    List<StoryPage> pages,
  });
}

/// @nodoc
class _$StoryCopyWithImpl<$Res, $Val extends Story>
    implements $StoryCopyWith<$Res> {
  _$StoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subjectId = null,
    Object? grade = null,
    Object? title = null,
    Object? pages = null,
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
            pages: null == pages
                ? _value.pages
                : pages // ignore: cast_nullable_to_non_nullable
                      as List<StoryPage>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryImplCopyWith<$Res> implements $StoryCopyWith<$Res> {
  factory _$$StoryImplCopyWith(
    _$StoryImpl value,
    $Res Function(_$StoryImpl) then,
  ) = __$$StoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String subjectId,
    int grade,
    String title,
    List<StoryPage> pages,
  });
}

/// @nodoc
class __$$StoryImplCopyWithImpl<$Res>
    extends _$StoryCopyWithImpl<$Res, _$StoryImpl>
    implements _$$StoryImplCopyWith<$Res> {
  __$$StoryImplCopyWithImpl(
    _$StoryImpl _value,
    $Res Function(_$StoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subjectId = null,
    Object? grade = null,
    Object? title = null,
    Object? pages = null,
  }) {
    return _then(
      _$StoryImpl(
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
        pages: null == pages
            ? _value._pages
            : pages // ignore: cast_nullable_to_non_nullable
                  as List<StoryPage>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryImpl implements _Story {
  const _$StoryImpl({
    required this.id,
    required this.subjectId,
    required this.grade,
    required this.title,
    required final List<StoryPage> pages,
  }) : _pages = pages;

  factory _$StoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryImplFromJson(json);

  @override
  final String id;
  @override
  final String subjectId;
  @override
  final int grade;
  @override
  final String title;
  final List<StoryPage> _pages;
  @override
  List<StoryPage> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  @override
  String toString() {
    return 'Story(id: $id, subjectId: $subjectId, grade: $grade, title: $title, pages: $pages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._pages, _pages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    subjectId,
    grade,
    title,
    const DeepCollectionEquality().hash(_pages),
  );

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryImplCopyWith<_$StoryImpl> get copyWith =>
      __$$StoryImplCopyWithImpl<_$StoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryImplToJson(this);
  }
}

abstract class _Story implements Story {
  const factory _Story({
    required final String id,
    required final String subjectId,
    required final int grade,
    required final String title,
    required final List<StoryPage> pages,
  }) = _$StoryImpl;

  factory _Story.fromJson(Map<String, dynamic> json) = _$StoryImpl.fromJson;

  @override
  String get id;
  @override
  String get subjectId;
  @override
  int get grade;
  @override
  String get title;
  @override
  List<StoryPage> get pages;

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryImplCopyWith<_$StoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
