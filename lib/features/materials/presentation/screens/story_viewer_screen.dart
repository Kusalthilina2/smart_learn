import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/widgets/gradient_background.dart';

class StoryViewerScreen extends StatefulWidget {
  final String title;
  final List<dynamic> pages;

  const StoryViewerScreen({
    super.key,
    required this.title,
    required this.pages,
  });

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen> {
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
      if (mounted) {
        setState(() => _isPlaying = false);
      }
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

  void _nextPage() {
    if (_currentPage < widget.pages.length - 1) {
      setState(() {
        _currentPage++;
        _isPlaying = false;
      });
      _tts.stop();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _isPlaying = false;
      });
      _tts.stop();
    }
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pages.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Center(
          child: Text('No pages available'),
        ),
      );
    }

    final page = widget.pages[_currentPage];
    final text = page['text'] as String? ?? 'No content';
    final imageUrl = page['imageUrl'] as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GradientBackground(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      'Page ${_currentPage + 1}/${widget.pages.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (imageUrl != null && imageUrl.trim().isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl.trim(),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.broken_image, size: 64, color: Colors.grey),
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
                      ),
                    const SizedBox(height: 24),
                    Text(
                      text,
                      style: const TextStyle(fontSize: 18, height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _currentPage > 0 ? _previousPage : null,
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 32,
                      ),
                      FloatingActionButton(
                        onPressed: () => _speak(text),
                        child: Icon(_isPlaying ? Icons.stop : Icons.volume_up),
                      ),
                      IconButton(
                        onPressed: _currentPage < widget.pages.length - 1 ? _nextPage : null,
                        icon: const Icon(Icons.arrow_forward),
                        iconSize: 32,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: ((_currentPage + 1) / widget.pages.length),
                    backgroundColor: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
