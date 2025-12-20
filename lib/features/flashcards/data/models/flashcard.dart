import 'package:freezed_annotation/freezed_annotation.dart';

part 'flashcard.freezed.dart';
part 'flashcard.g.dart';

@freezed
class Flashcard with _$Flashcard {
  const factory Flashcard({
    required String id,
    required String front,
    required String back,
    required int lastReviewedMs,
    required int nextReviewMs,
    required int repetitions,
    required double easeFactor,
  }) = _Flashcard;

  factory Flashcard.fromJson(Map<String, dynamic> json) =>
      _$FlashcardFromJson(json);
}

@freezed
class FlashcardDeck with _$FlashcardDeck {
  const factory FlashcardDeck({
    required String id,
    required String title,
    required String? subjectId,
    required int grade,
    required List<Flashcard> cards,
    required bool isCustom,
  }) = _FlashcardDeck;

  factory FlashcardDeck.fromJson(Map<String, dynamic> json) =>
      _$FlashcardDeckFromJson(json);
}
