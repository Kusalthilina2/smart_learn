import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../data/repositories/story_repository.dart';

final storyDetailProvider = FutureProvider.family<dynamic, String>((ref, storyId) async {
  return await ref.watch(storyRepositoryProvider).getStoryById(storyId);
});

class StoryReaderScreen extends ConsumerStatefulWidget {
  final String storyId;
  const StoryReaderScreen({super.key, required this.storyId});

  @override
  ConsumerState<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends ConsumerState<StoryReaderScreen> {
  final FlutterTts _tts = FlutterTts();
  int _currentPage = 0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() {
    _tts.setLanguage('en-GB');
    _tts.setSpeechRate(0.5);
    _tts.setCompletionHandler(() {
      setState(() => _isPlaying = false);
    });
  }

  Future<void> _speak(String text) async {
    if (_isPlaying) {
      await _tts.stop();
      setState(() => _isPlaying = false);
    } else {
      await _tts.speak(text);
      setState(() => _isPlaying = true);
    }
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storyAsync = ref.watch(storyDetailProvider(widget.storyId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Story'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GradientBackground(
        child: storyAsync.when(
          data: (story) {
            if (story == null) return const Center(child: Text('Story not found'));

            final page = story.pages[_currentPage];
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        if (page.imageUrl != null && page.imageUrl!.trim().isNotEmpty)
                          CachedNetworkImage(
                            imageUrl: page.imageUrl!.trim(),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              height: 200,
                              color: Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 200,
                              color: Colors.grey[300],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.broken_image, size: 64),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Failed to load image',
                                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Check URL format',
                                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(height: 24),
                        Text(page.text, style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _currentPage > 0
                          ? () => setState(() => _currentPage--)
                          : null,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Previous'),
                      ),
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                        iconSize: 48,
                        onPressed: () => _speak(page.text),
                      ),
                      ElevatedButton.icon(
                        onPressed: _currentPage < story.pages.length - 1
                          ? () => setState(() => _currentPage++)
                          : null,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Next'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}
