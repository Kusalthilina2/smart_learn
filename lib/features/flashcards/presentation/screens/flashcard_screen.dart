import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../data/models/flashcard.dart';
import '../../data/repositories/flashcard_repository.dart';

final flashcardsProvider = FutureProvider((ref) async {
  return await ref.watch(flashcardRepositoryProvider).fetchDecks();
});

class FlashcardScreen extends ConsumerStatefulWidget {
  const FlashcardScreen({super.key});

  @override
  ConsumerState<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends ConsumerState<FlashcardScreen> {
  int _currentCardIndex = 0;
  bool _showAnswer = false;
  FlashcardDeck? _currentDeck;

  void _flipCard() {
    setState(() => _showAnswer = !_showAnswer);
  }

  void _rateCard(int quality) {
    if (_currentDeck == null) return;

    final card = _currentDeck!.cards[_currentCardIndex];
    final updatedDeck = ref.read(flashcardRepositoryProvider)
        .updateCardReview(_currentDeck!, card.id, quality);

    setState(() {
      _currentDeck = updatedDeck;
      _showAnswer = false;
      if (_currentCardIndex < _currentDeck!.cards.length - 1) {
        _currentCardIndex++;
      } else {
        _currentCardIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final decksAsync = ref.watch(flashcardsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GradientBackground(
        child: decksAsync.when(
          data: (decks) {
            if (decks.isEmpty) {
              return const Center(child: Text('No flashcards available'));
            }

            _currentDeck ??= decks.first;
            final card = _currentDeck!.cards[_currentCardIndex];

            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text('Deck: ${_currentDeck!.title}',
                    style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 16),
                  Text('Card ${_currentCardIndex + 1}/${_currentDeck!.cards.length}'),
                  const SizedBox(height: 32),
                  Expanded(
                    child: GestureDetector(
                      onTap: _flipCard,
                      child: Card(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              _showAnswer ? card.back : card.front,
                              style: const TextStyle(fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (_showAnswer) ...[
                    const Text('How well did you know it?'),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => _rateCard(1),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: const Text('Hard'),
                        ),
                        ElevatedButton(
                          onPressed: () => _rateCard(3),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          child: const Text('Good'),
                        ),
                        ElevatedButton(
                          onPressed: () => _rateCard(5),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: const Text('Easy'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}
