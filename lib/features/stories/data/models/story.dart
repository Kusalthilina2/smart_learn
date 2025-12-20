import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.freezed.dart';
part 'story.g.dart';

@freezed
class StoryPage with _$StoryPage {
  const factory StoryPage({
    required String text,
    String? imageUrl,
    String? audioUrl,
  }) = _StoryPage;

  factory StoryPage.fromJson(Map<String, dynamic> json) =>
      _$StoryPageFromJson(json);
}

@freezed
class Story with _$Story {
  const factory Story({
    required String id,
    required String subjectId,
    required int grade,
    required String title,
    required List<StoryPage> pages,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}
