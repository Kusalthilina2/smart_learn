import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/utils/levenshtein.dart';

class VoicePracticeScreen extends StatefulWidget {
  const VoicePracticeScreen({super.key});

  @override
  State<VoicePracticeScreen> createState() => _VoicePracticeScreenState();
}

class _VoicePracticeScreenState extends State<VoicePracticeScreen> {
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  String _spokenText = '';
  double? _score;

  final List<String> _phrases = [
    'The quick brown fox jumps over the lazy dog',
    'Reading helps us learn new things',
    'Mathematics is fun and interesting',
    'Science explores the world around us',
  ];

  String _currentPhrase = '';
  int _phraseIndex = 0;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _currentPhrase = _phrases[0];
  }

  Future<void> _initSpeech() async {
    await _speech.initialize();
  }

  Future<void> _startListening() async {
    setState(() {
      _isListening = true;
      _spokenText = '';
      _score = null;
    });

    await _speech.listen(
      onResult: (result) {
        setState(() {
          _spokenText = result.recognizedWords;
        });
      },
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
      _score = Levenshtein.similarity(_currentPhrase, _spokenText);
    });
  }

  void _nextPhrase() {
    setState(() {
      _phraseIndex = (_phraseIndex + 1) % _phrases.length;
      _currentPhrase = _phrases[_phraseIndex];
      _spokenText = '';
      _score = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Practice'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Read this phrase aloud:',
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(_currentPhrase,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(height: 32),
              if (_spokenText.isNotEmpty) ...[
                const Text('You said:', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text(_spokenText,
                    style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                const SizedBox(height: 16),
              ],
              if (_score != null) ...[
                Text('Accuracy: ${(_score! * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _score! > 0.8
                          ? Colors.green
                          : _score! > 0.6
                              ? Colors.orange
                              : Colors.red,
                    )),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _nextPhrase,
                  child: const Text('Next Phrase'),
                ),
              ] else ...[
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _isListening ? _stopListening : _startListening,
                  icon: Icon(_isListening ? Icons.stop : Icons.mic),
                  label: Text(_isListening ? 'Stop Recording' : 'Start Recording'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
