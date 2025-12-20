import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/storage/hive_init.dart';
import '../../../../core/utils/time_utils.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../../../streaks/data/repositories/streak_repository.dart';
import '../../../achievements/data/repositories/achievement_repository.dart';
import '../../data/repositories/materials_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizDetailScreen extends ConsumerStatefulWidget {
  final String gradeId;
  final String subjectId;
  final String quizId;

  const QuizDetailScreen({
    super.key,
    required this.gradeId,
    required this.subjectId,
    required this.quizId,
  });

  @override
  ConsumerState<QuizDetailScreen> createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends ConsumerState<QuizDetailScreen> {
  int _currentQuestion = 0;
  final Map<int, int> _answers = {};
  bool _showResults = false;

  void _submitAnswer(int answerIndex) {
    setState(() {
      _answers[_currentQuestion] = answerIndex;
    });
  }

  void _nextQuestion(int totalQuestions) {
    if (_currentQuestion < totalQuestions - 1) {
      setState(() {
        _currentQuestion++;
      });
    } else {
      setState(() {
        _showResults = true;
      });
    }
  }

  int _calculateScore(Map<String, dynamic> quiz) {
    int score = 0;
    final questions = quiz['questions'] as List<dynamic>;

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i] as Map<String, dynamic>;
      final correctIndex = question['correctIndex'] as int;

      if (_answers[i] == correctIndex) {
        score++;
      }
    }
    return score;
  }

  Future<void> _submitQuiz(Map<String, dynamic> quiz) async {
    final user = ref.read(authStateProvider).value;
    if (user != null) {
      final score = _calculateScore(quiz);
      final questions = quiz['questions'] as List<dynamic>;
      final attemptedAtMs = TimeUtils.nowMs();

      // Save to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('quiz_attempts')
          .add({
        'quizId': widget.quizId,
        'subjectId': widget.subjectId,
        'gradeId': widget.gradeId,
        'score': score,
        'totalQuestions': questions.length,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Save to local Hive for Parent Dashboard
      final quizAttemptsBox = Hive.box(HiveBoxes.quizAttempts);
      final attemptId = '${widget.quizId}_$attemptedAtMs';
      await quizAttemptsBox.put(attemptId, {
        'id': attemptId,
        'quizId': widget.quizId,
        'subjectId': widget.subjectId,
        'gradeId': widget.gradeId,
        'score': score,
        'totalQuestions': questions.length,
        'attemptedAtMs': attemptedAtMs,
      });

      // Update streak
      final streakRepo = ref.read(streakRepositoryProvider);
      await streakRepo.updateStreak(user.uid);

      // Check and unlock achievements
      final achievementRepo = ref.read(achievementRepositoryProvider);
      await achievementRepo.checkAndUnlockAchievements(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: ref.read(materialsRepositoryProvider).getQuiz(
        gradeId: widget.gradeId,
        subjectId: widget.subjectId,
        quizId: widget.quizId,
      ),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.quiz),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: GradientBackground(
            child: _buildContent(snapshot),
          ),
        );
      },
    );
  }

  Widget _buildContent(AsyncSnapshot<Map<String, dynamic>?> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: ${snapshot.error}'),
          ],
        ),
      );
    }

    final quiz = snapshot.data;
    if (quiz == null) {
      return const Center(child: Text('Quiz not found'));
    }

    if (_showResults) {
      final score = _calculateScore(quiz);
      _submitQuiz(quiz);
      final questions = quiz['questions'] as List<dynamic>;

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Quiz Complete!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Text(
                'Score: $score/${questions.length}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              Text(
                '${((score / questions.length) * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Lessons'),
              ),
            ],
          ),
        ),
      );
    }

    final questions = quiz['questions'] as List<dynamic>;
    final question = questions[_currentQuestion] as Map<String, dynamic>;
    final options = question['options'] as List<dynamic>;
    final questionText = question['question'] as String;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${_currentQuestion + 1}/${questions.length}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Text(
            questionText,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          ...List.generate(options.length, (index) {
            final isSelected = _answers[_currentQuestion] == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.blue[700] : Colors.blue,
                    padding: const EdgeInsets.all(16),
                  ),
                  onPressed: () => _submitAnswer(index),
                  child: Text(
                    options[index] as String,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _answers.containsKey(_currentQuestion)
                  ? () => _nextQuestion(questions.length)
                  : null,
              child: Text(
                _currentQuestion < questions.length - 1
                    ? AppStrings.next
                    : AppStrings.submit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
