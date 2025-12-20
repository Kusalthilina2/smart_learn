import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/materials/presentation/screens/subjects_list_screen.dart';
import '../../features/materials/presentation/screens/content_by_type_screen.dart';
import '../../features/stories/presentation/screens/story_reader_screen.dart';
import '../../features/flashcards/presentation/screens/flashcard_screen.dart';
import '../../features/achievements/presentation/screens/achievements_screen.dart';
import '../../features/streaks/presentation/screens/streaks_screen.dart';
import '../../features/parent_dashboard/presentation/screens/parent_dashboard_screen.dart';
import '../../features/voice_practice/presentation/screens/voice_practice_screen.dart';
import '../../features/homework_helper/presentation/screens/homework_helper_screen.dart';
import '../../features/emotion_detector/presentation/screens/emotion_detector_screen.dart';
import '../../features/admin/presentation/screens/admin_login_screen.dart';
import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/admin/presentation/screens/admin_subjects_screen.dart';
import '../../features/admin/presentation/screens/admin_lessons_screen.dart';
import '../../features/admin/presentation/screens/admin_quizzes_screen.dart';
import '../../features/admin/presentation/screens/admin_stories_screen.dart';
import '../../features/admin/presentation/screens/admin_flashcards_screen.dart';
import '../../features/admin/presentation/screens/admin_videos_screen.dart';
import '../../features/auth/data/repositories/auth_repository.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/signin',
    redirect: (context, state) {
      final isAuthenticated = authState.value != null;
      final isAuthRoute =
          state.matchedLocation == '/signin' || state.matchedLocation == '/signup';

      if (!isAuthenticated && !isAuthRoute) {
        return '/signin';
      }

      if (isAuthenticated && isAuthRoute) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/subjects',
        builder: (context, state) => const SubjectsListScreen(),
      ),
      GoRoute(
        path: '/lessons',
        builder: (context, state) => const ContentByTypeScreen(
          contentType: ContentType.lessons,
        ),
      ),
      GoRoute(
        path: '/quizzes',
        builder: (context, state) => const ContentByTypeScreen(
          contentType: ContentType.quizzes,
        ),
      ),
      GoRoute(
        path: '/videos',
        builder: (context, state) => const ContentByTypeScreen(
          contentType: ContentType.videos,
        ),
      ),
      GoRoute(
        path: '/stories-list',
        builder: (context, state) => const ContentByTypeScreen(
          contentType: ContentType.stories,
        ),
      ),
      GoRoute(
        path: '/flashcards-list',
        builder: (context, state) => const ContentByTypeScreen(
          contentType: ContentType.flashcards,
        ),
      ),
      GoRoute(
        path: '/story/:storyId',
        builder: (context, state) {
          final storyId = state.pathParameters['storyId']!;
          return StoryReaderScreen(storyId: storyId);
        },
      ),
      GoRoute(
        path: '/flashcards',
        builder: (context, state) => const FlashcardScreen(),
      ),
      GoRoute(
        path: '/achievements',
        builder: (context, state) => const AchievementsScreen(),
      ),
      GoRoute(
        path: '/streaks',
        builder: (context, state) => const StreaksScreen(),
      ),
      GoRoute(
        path: '/parent-dashboard',
        builder: (context, state) => const ParentDashboardScreen(),
      ),
      GoRoute(
        path: '/voice-practice',
        builder: (context, state) => const VoicePracticeScreen(),
      ),
      GoRoute(
        path: '/homework-helper',
        builder: (context, state) => const HomeworkHelperScreen(),
      ),
      GoRoute(
        path: '/emotion-detector',
        builder: (context, state) => const EmotionDetectorScreen(),
      ),
      GoRoute(
        path: '/admin/login',
        builder: (context, state) => const AdminLoginScreen(),
      ),
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/admin/subjects',
        builder: (context, state) => const AdminSubjectsScreen(),
      ),
      GoRoute(
        path: '/admin/lessons',
        builder: (context, state) => const AdminLessonsScreen(),
      ),
      GoRoute(
        path: '/admin/quizzes',
        builder: (context, state) => const AdminQuizzesScreen(),
      ),
      GoRoute(
        path: '/admin/stories',
        builder: (context, state) => const AdminStoriesScreen(),
      ),
      GoRoute(
        path: '/admin/flashcards',
        builder: (context, state) => const AdminFlashcardsScreen(),
      ),
      GoRoute(
        path: '/admin/videos',
        builder: (context, state) => const AdminVideosScreen(),
      ),
    ],
  );
});
