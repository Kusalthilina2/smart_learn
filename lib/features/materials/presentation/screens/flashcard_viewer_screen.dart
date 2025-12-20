import 'package:flutter/material.dart';
import '../../../../core/widgets/gradient_background.dart';

class FlashcardViewerScreen extends StatefulWidget {
  final String title;
  final List<dynamic> cards;

  const FlashcardViewerScreen({
    super.key,
    required this.title,
    required this.cards,
  });

  @override
  State<FlashcardViewerScreen> createState() => _FlashcardViewerScreenState();
}

class _FlashcardViewerScreenState extends State<FlashcardViewerScreen> {
  int _currentCardIndex = 0;
  bool _showAnswer = false;

  void _flipCard() {
    setState(() => _showAnswer = !_showAnswer);
  }

  void _nextCard() {
    setState(() {
      if (_currentCardIndex < widget.cards.length - 1) {
        _currentCardIndex++;
        _showAnswer = false;
      }
    });
  }

  void _previousCard() {
    setState(() {
      if (_currentCardIndex > 0) {
        _currentCardIndex--;
        _showAnswer = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Center(
          child: Text('No cards available'),
        ),
      );
    }

    final card = widget.cards[_currentCardIndex];
    final front = card['front'] as String? ?? 'No question';
    final back = card['back'] as String? ?? 'No answer';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'Card ${_currentCardIndex + 1}/${widget.cards.length}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GestureDetector(
                  onTap: _flipCard,
                  child: Card(
                    elevation: 8,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _showAnswer ? back : front,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              _showAnswer ? 'Answer' : 'Question',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Tap to flip',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _currentCardIndex > 0 ? _previousCard : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _currentCardIndex < widget.cards.length - 1 ? _nextCard : null,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
