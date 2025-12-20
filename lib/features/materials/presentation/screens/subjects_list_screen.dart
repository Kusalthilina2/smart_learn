import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/utils/logger.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../../data/repositories/materials_repository.dart';
import 'quiz_detail_screen.dart';
import 'story_viewer_screen.dart';
import 'flashcard_viewer_screen.dart';

/// Example: Subjects List Screen with proper loading/empty states
class SubjectsListScreen extends ConsumerWidget {
  const SubjectsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get current user
    final currentUser = ref.watch(authRepositoryProvider).currentUser;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Subjects'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Center(child: Text('Please sign in first')),
      );
    }

    // Watch user profile to get gradeId
    return StreamBuilder(
      stream: ref
          .read(authRepositoryProvider)
          .watchUserProfile(currentUser.uid),
      builder: (context, userSnapshot) {
        // Loading user profile
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          Logger.info('[SubjectsListScreen] Loading user profile...');
          return Scaffold(
            appBar: AppBar(
              title: const Text('Subjects'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading your profile...'),
                ],
              ),
            ),
          );
        }

        // Error loading user profile
        if (userSnapshot.hasError) {
          Logger.error(
            '[SubjectsListScreen] Error loading user profile',
            userSnapshot.error,
          );
          return Scaffold(
            appBar: AppBar(
              title: const Text('Subjects'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${userSnapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Force refresh
                      (context as Element).markNeedsBuild();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // User profile not found
        if (!userSnapshot.hasData || userSnapshot.data == null) {
          Logger.error(
            '[SubjectsListScreen] User profile not found for ${currentUser.uid}',
          );
          return Scaffold(
            appBar: AppBar(
              title: const Text('Subjects'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning, size: 64, color: Colors.orange),
                  SizedBox(height: 16),
                  Text('User profile not found'),
                  Text('Please sign out and sign in again'),
                ],
              ),
            ),
          );
        }

        final userProfile = userSnapshot.data!;
        final gradeId =
            'grade_${userProfile.grade}'; // Convert grade 1 → "grade_1"

        Logger.info(
          '[SubjectsListScreen] User grade: ${userProfile.grade}, gradeId: $gradeId',
        );

        // Now watch subjects for this grade
        return StreamBuilder<List<Map<String, dynamic>>>(
          stream: ref
              .read(materialsRepositoryProvider)
              .watchSubjects(gradeId: gradeId),
          builder: (context, subjectsSnapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Year ${userProfile.grade} Subjects'),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                actions: [
                  // Debug button to check if subjects exist
                  IconButton(
                    icon: const Icon(Icons.bug_report),
                    onPressed: () async {
                      final hasSubjects = await ref
                          .read(materialsRepositoryProvider)
                          .hasSubjectsForGrade(gradeId);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              hasSubjects
                                  ? 'Subjects exist for $gradeId ✅'
                                  : 'No subjects found for $gradeId ❌',
                            ),
                            backgroundColor: hasSubjects
                                ? Colors.green
                                : Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              body: GradientBackground(
                child: _buildSubjectsList(context, subjectsSnapshot, gradeId),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSubjectsList(
    BuildContext context,
    AsyncSnapshot<List<Map<String, dynamic>>> snapshot,
    String gradeId,
  ) {
    // Still loading subjects
    if (snapshot.connectionState == ConnectionState.waiting) {
      Logger.info('[SubjectsListScreen] Loading subjects for $gradeId...');
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading subjects...'),
          ],
        ),
      );
    }

    // Error loading subjects
    if (snapshot.hasError) {
      Logger.error(
        '[SubjectsListScreen] Error loading subjects',
        snapshot.error,
      );
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Error loading subjects'),
            Text(
              '${snapshot.error}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final subjects = snapshot.data!;

    // Empty list - this is the "No subjects available" case
    if (subjects.isEmpty) {
      Logger.info('[SubjectsListScreen] Empty subject list for $gradeId');
      Logger.info('[SubjectsListScreen] Possible causes:');
      Logger.info(
        '  1. Seed not run yet (check logs for "Database seeding completed")',
      );
      Logger.info(
        '  2. Wrong gradeId format (should be "grade_1", "grade_2", etc.)',
      );
      Logger.info('  3. Firestore rules blocking read');
      Logger.info('  4. Network disconnected');

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 80, color: Colors.grey),
              const SizedBox(height: 24),
              const Text(
                'No subjects available yet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Looking for subjects in: $gradeId',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const Text(
                'Possible causes:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Database not seeded yet\n'
                '• Wrong grade configuration\n'
                '• Network connection issues\n'
                '• Firestore rules blocking access',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  // Force refresh
                  (context as Element).markNeedsBuild();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
              ),
            ],
          ),
        ),
      );
    }

    // Success - display subjects
    Logger.info(
      '[SubjectsListScreen] Loaded ${subjects.length} subjects for $gradeId',
    );

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        final subjectId = subject['id'] as String;
        final name = subject['name'] as String? ?? 'Unknown Subject';
        final description = subject['description'] as String? ?? '';
        final icon = _getIconData(subject['icon'] as String?);
        final colorValue = subject['color'] as String?;
        final color = colorValue != null
            ? Color(int.parse(colorValue))
            : Colors.blue;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              // Navigate to lessons for this subject
              Logger.info('[SubjectsListScreen] Tapped on $subjectId');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LessonsListScreen(
                    gradeId: gradeId,
                    subjectId: subjectId,
                    subjectName: name,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, size: 32, color: color),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getIconData(String? iconName) {
    switch (iconName) {
      case 'calculate':
        return Icons.calculate;
      case 'science':
        return Icons.science;
      case 'book':
        return Icons.book;
      case 'history_edu':
        return Icons.history_edu;
      default:
        return Icons.subject;
    }
  }
}

/// Lessons and Quizzes List Screen with Tabs
class LessonsListScreen extends ConsumerWidget {
  final String gradeId;
  final String subjectId;
  final String subjectName;

  const LessonsListScreen({
    super.key,
    required this.gradeId,
    required this.subjectId,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(subjectName),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.book), text: 'Lessons'),
              Tab(icon: Icon(Icons.quiz), text: 'Quizzes'),
              Tab(icon: Icon(Icons.video_library), text: 'Videos'),
              Tab(icon: Icon(Icons.auto_stories), text: 'Stories'),
              Tab(icon: Icon(Icons.style), text: 'Flashcards'),
            ],
          ),
        ),
        body: GradientBackground(
          child: TabBarView(
            children: [
              _LessonsTab(
                gradeId: gradeId,
                subjectId: subjectId,
                ref: ref,
              ),
              _QuizzesTab(
                gradeId: gradeId,
                subjectId: subjectId,
                ref: ref,
              ),
              _VideosTab(
                gradeId: gradeId,
                subjectId: subjectId,
                ref: ref,
              ),
              _StoriesTab(
                gradeId: gradeId,
                subjectId: subjectId,
                ref: ref,
              ),
              _FlashcardsTab(
                gradeId: gradeId,
                subjectId: subjectId,
                ref: ref,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LessonsTab extends StatelessWidget {
  final String gradeId;
  final String subjectId;
  final WidgetRef ref;

  const _LessonsTab({
    required this.gradeId,
    required this.subjectId,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ref
          .read(materialsRepositoryProvider)
          .watchLessons(gradeId: gradeId, subjectId: subjectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.book_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No lessons available yet'),
              ],
            ),
          );
        }

        final lessons = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: lessons.length,
          itemBuilder: (context, index) {
            final lesson = lessons[index];
            final title = lesson['title'] as String? ?? 'Untitled';
            final description = lesson['description'] as String? ?? '';
            final duration = lesson['duration'] as int? ?? 0;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.play_arrow)),
                title: Text(title),
                subtitle: Text(description),
                trailing: duration > 0 ? Text('$duration min') : null,
                onTap: () {
                  Logger.info('[LessonsListScreen] Tapped on ${lesson['id']}');
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _QuizzesTab extends StatelessWidget {
  final String gradeId;
  final String subjectId;
  final WidgetRef ref;

  const _QuizzesTab({
    required this.gradeId,
    required this.subjectId,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ref
          .read(materialsRepositoryProvider)
          .watchQuizzes(gradeId: gradeId, subjectId: subjectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.quiz_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No quizzes available yet'),
              ],
            ),
          );
        }

        final quizzes = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            final quiz = quizzes[index];
            final title = quiz['title'] as String? ?? 'Untitled Quiz';
            final description = quiz['description'] as String? ?? '';
            final questions = quiz['questions'] as List<dynamic>? ?? [];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.quiz, color: Colors.white),
                ),
                title: Text(title),
                subtitle: Text(
                  description.isNotEmpty
                      ? description
                      : '${questions.length} questions',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Logger.info('[QuizzesTab] Tapped on ${quiz['id']}');
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
}

class _VideosTab extends StatelessWidget {
  final String gradeId;
  final String subjectId;
  final WidgetRef ref;

  const _VideosTab({
    required this.gradeId,
    required this.subjectId,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ref
          .read(materialsRepositoryProvider)
          .watchVideos(gradeId: gradeId, subjectId: subjectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.video_library_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No videos available yet'),
              ],
            ),
          );
        }

        final videos = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            final title = video['title'] as String? ?? 'Untitled Video';
            final description = video['description'] as String? ?? '';
            final youtubeUrl = video['youtubeUrl'] as String? ?? '';

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.play_arrow, color: Colors.white),
                ),
                title: Text(title),
                subtitle: Text(
                  description.isNotEmpty ? description : 'Tap to watch',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  if (youtubeUrl.isNotEmpty) {
                    final uri = Uri.parse(youtubeUrl);
                    try {
                      final canLaunch = await canLaunchUrl(uri);
                      if (canLaunch) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cannot open YouTube link'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error opening video: $e'),
                            backgroundColor: Colors.red,
                          ),
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
}

class _StoriesTab extends StatelessWidget {
  final String gradeId;
  final String subjectId;
  final WidgetRef ref;

  const _StoriesTab({
    required this.gradeId,
    required this.subjectId,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ref
          .read(materialsRepositoryProvider)
          .watchStories(gradeId: gradeId, subjectId: subjectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.auto_stories_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No stories available yet'),
              ],
            ),
          );
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
}

class _FlashcardsTab extends StatelessWidget {
  final String gradeId;
  final String subjectId;
  final WidgetRef ref;

  const _FlashcardsTab({
    required this.gradeId,
    required this.subjectId,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ref
          .read(materialsRepositoryProvider)
          .watchFlashcardDecks(gradeId: gradeId, subjectId: subjectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.style_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No flashcards available yet'),
              ],
            ),
          );
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
