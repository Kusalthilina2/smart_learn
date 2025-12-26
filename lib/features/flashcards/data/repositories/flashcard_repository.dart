import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../../core/storage/hive_init.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/time_utils.dart';
import '../models/flashcard.dart';

final flashcardRepositoryProvider = Provider<FlashcardRepository>((ref) {
  return FlashcardRepository(firestore: FirebaseFirestore.instance);
});

class FlashcardRepository {
  final FirebaseFirestore firestore;
  FlashcardRepository({required this.firestore});

  Box get _cacheBox => Hive.box(HiveBoxes.cachePublicDecks);

  Future<List<FlashcardDeck>> fetchDecks() async {
    try {
      final snapshot = await firestore
          .collection('public_flashcard_decks')
          .get();

      final decks = snapshot.docs
          .map((doc) => FlashcardDeck.fromJson({...doc.data(), 'id': doc.id}))
          .toList();

      for (final deck in decks) {
        await _cacheBox.put(deck.id, deck.toJson());
      }
      return decks;
    } catch (e) {
      Logger.error('Failed to fetch decks', e);
      return getCachedDecks();
    }
  }

  List<FlashcardDeck> getCachedDecks() {
    return _cacheBox.values
        .map((e) => FlashcardDeck.fromJson((e as Map).cast<String, dynamic>()))
        .toList();
  }

  FlashcardDeck updateCardReview(FlashcardDeck deck, String cardId, int quality) {
    final now = TimeUtils.nowMs();
    final updatedCards = deck.cards.map((card) {
      if (card.id != cardId) return card;

      int interval;
      double easeFactor = card.easeFactor;

      if (quality >= 3) {
        if (card.repetitions == 0) {
          interval = 1;
        } else if (card.repetitions == 1) {
          interval = 6;
        } else {
          interval = (card.repetitions * easeFactor).round();
        }
        easeFactor = easeFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
        if (easeFactor < 1.3) easeFactor = 1.3;

        return card.copyWith(
          lastReviewedMs: now,
          nextReviewMs: now + (interval * 86400000),
          repetitions: card.repetitions + 1,
          easeFactor: easeFactor,
        );
      } else {
        return card.copyWith(
          lastReviewedMs: now,
          nextReviewMs: now + 600000,
          repetitions: 0,
          easeFactor: easeFactor,
        );
      }
    }).toList();

    return deck.copyWith(cards: updatedCards);
  }
}
