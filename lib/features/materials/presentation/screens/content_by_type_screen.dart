import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../../data/repositories/materials_repository.dart';
import 'quiz_detail_screen.dart';
import 'story_viewer_screen.dart';
import 'flashcard_viewer_screen.dart';

enum ContentType { lessons, quizzes, videos, stories, flashcards }

class ContentByTypeScreen extends ConsumerWidget {
  final ContentType contentType;

  const ContentByTypeScreen({super.key, required this.contentType});

  String get title {
    switch (contentType) {
      case ContentType.lessons:
        return 'Lessons';
      case ContentType.quizzes:
        return 'Quizzes';
      case ContentType.videos:
        return 'Videos';
      case ContentType.stories:
        return 'Stories';
      case ContentType.flashcards:
        return 'Flashcards';
    }
  }

  IconData get icon {
    switch (contentType) {
      case ContentType.lessons:
        return Icons.book;
      case ContentType.quizzes:
        return Icons.quiz;
      case ContentType.videos:
        return Icons.video_library;
      case ContentType.stories:
        return Icons.auto_stories;
      case ContentType.flashcards:
        return Icons.style;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authStateProvider).value;
    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Center(child: Text('Please sign in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder(
        stream: ref
            .read(authRepositoryProvider)
            .watchUserProfile(currentUser.uid),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!userSnapshot.hasData || userSnapshot.data == null) {
            return const Center(child: Text('User profile not found'));
          }

          final userProfile = userSnapshot.data!;
          final gradeId = 'grade_${userProfile.grade}';

          return StreamBuilder<List<Map<String, dynamic>>>(
            stream: ref
                .read(materialsRepositoryProvider)
                .watchSubjects(gradeId: gradeId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school, size: 80, color: Colors.grey),
                      const SizedBox(height: 24),
                      Text(
                        'No subjects available for $title',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              }

              final subjects = snapshot.data!;

              return GradientBackground(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    final subjectId = subject['id'] as String;
                    final name = subject['name'] as String? ?? 'Unknown Subject';
                    final description = subject['description'] as String? ?? '';

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(icon, color: Colors.white),
                        ),
                        title: Text(name),
                        subtitle: Text(description),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ContentListScreen(
                                contentType: contentType,
                                gradeId: gradeId,
                                subjectId: subjectId,
                                subjectName: name,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ContentListScreen extends ConsumerWidget {
  final ContentType contentType;
  final String gradeId;
  final String subjectId;
  final String subjectName;

  const ContentListScreen({
    super.key,
    required this.contentType,
    required this.gradeId,
    required this.subjectId,
    required this.subjectName,
  });

  String get title {
    switch (contentType) {
      case ContentType.lessons:
        return 'Lessons';
      case ContentType.quizzes:
        return 'Quizzes';
      case ContentType.videos:
        return 'Videos';
      case ContentType.stories:
        return 'Stories';
      case ContentType.flashcards:
        return 'Flashcards';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subjectName - $title'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GradientBackground(
        child: _buildContentList(context, ref),
      ),
    );
  }

  Widget _buildContentList(BuildContext context, WidgetRef ref) {
    switch (contentType) {
      case ContentType.lessons:
        return _buildLessonsList(context, ref);
      case ContentType.quizzes:
        return _buildQuizzesList(context, ref);
      case ContentType.videos:
        return _buildVideosList(context, ref);
      case ContentType.stories:
        return _buildStoriesList(context, ref);
      case ContentType.flashcards:
        return _buildFlashcardsList(context, ref);
    }
  }

  Widget _buildLessonsList(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ref
          .read(materialsRepositoryProvider)
          .watchLessons(gradeId: gradeId, subjectId: subjectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No lessons available'));
        }

        final lessons = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: lessons.length,
          itemBuilder: (context, index) {
            final lesson = lessons[index];
            final title = lesson['title'] as String? ?? 'Untitled Lesson';
            final description = lesson['description'] as String? ?? '';

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.book, color: Colors.white),
                ),
                title: Text(title),
                subtitle: Text(description),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lesson viewer coming soon')),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildQuizzesList(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ref
          .read(materialsRepositoryProvider)
          .watchQuizzes(gradeId: gradeId, subjectId: subjectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No quizzes available'));
        }

        final quizzes = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            final quiz = quizzes[index];
            final title = quiz['title'] as String? ?? 'Untitled Quiz';
            final questions = quiz['questions'] as List<dynamic>? ?? [];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.quiz, color: Colors.white),
                ),
                title: Text(title),
                subtitle: Text('${questions.length} questions'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizDetailScreen(
                        gradeId: gradeId,
                        subjectId: subjectId,
                        quizId: quiz['id'] as String,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildVideosList(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ref
          .read(materialsRepositoryProvider)
          .watchVideos(gradeId: gradeId, subjectId: subjectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No videos available'));
        }

        final videos = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            final title = video['title'] as String? ?? 'Untitled Video';
            final youtubeUrl = video['youtubeUrl'] as String? ?? '';

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.play_arrow, color: Colors.white),
                ),
                title: Text(title),
                subtitle: const Text('Tap to watch'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  if (youtubeUrl.isNotEmpty) {
                    final uri = Uri.parse(youtubeUrl);
                    try {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStoriesList(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ref
          .read(materialsRepositoryProvider)
          .watchStories(gradeId: gradeId, subjectId: subjectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No stories available'));
        }

        final stories = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: stories.length,
          itemBuilder: (context, index) {
            final story = stories[index];
            final title = story['title'] as String? ?? 'Untitled Story';
            final pages = story['pages'] as List<dynamic>? ?? [];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.auto_stories, color: Colors.white),
                ),
                title: Text(title),
                subtitle: Text('${pages.length} pages'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StoryViewerScreen(
                        title: title,
                        pages: pages,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFlashcardsList(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ref
          .read(materialsRepositoryProvider)
          .watchFlashcardDecks(gradeId: gradeId, subjectId: subjectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No flashcards available'));
        }

        final decks = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: decks.length,
          itemBuilder: (context, index) {
            final deck = decks[index];
            final title = deck['title'] as String? ?? 'Untitled Deck';
            final cards = deck['cards'] as List<dynamic>? ?? [];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.style, color: Colors.white),
                ),
                title: Text(title),
                subtitle: Text('${cards.length} cards'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardViewerScreen(
                        title: title,
                        cards: cards,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
