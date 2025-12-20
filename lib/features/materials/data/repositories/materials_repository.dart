import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/logger.dart';

final materialsRepositoryProvider = Provider<MaterialsRepository>((ref) {
  return MaterialsRepository(firestore: FirebaseFirestore.instance);
});

/// Repository for fetching hierarchical materials (subjects, lessons, quizzes)
class MaterialsRepository {
  final FirebaseFirestore firestore;

  MaterialsRepository({required this.firestore});

  /// Watch all subjects for a specific grade
  /// Returns a Stream that updates when subjects change
  Stream<List<Map<String, dynamic>>> watchSubjects({
    required String gradeId,
    List<String>? selectedSubjectIds,
  }) {
    try {
      Query query = firestore
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .where('enabled', isEqualTo: true)
          .orderBy('sortOrder');

      // Optional: filter by specific subject IDs
      if (selectedSubjectIds != null && selectedSubjectIds.isNotEmpty) {
        // Firestore 'whereIn' limit is 10 items
        if (selectedSubjectIds.length <= 10) {
          query = query.where(FieldPath.documentId, whereIn: selectedSubjectIds);
        }
      }

      return query.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return <String, dynamic>{
            'id': doc.id,
            ...(doc.data() as Map<String, dynamic>),
          };
        }).toList();
      });
    } catch (e) {
      Logger.error('Error watching subjects for $gradeId', e);
      return Stream.value([]);
    }
  }

  /// Get subjects once (not a stream)
  Future<List<Map<String, dynamic>>> getSubjects({
    required String gradeId,
    List<String>? selectedSubjectIds,
  }) async {
    try {
      Query query = firestore
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .where('enabled', isEqualTo: true)
          .orderBy('sortOrder');

      if (selectedSubjectIds != null && selectedSubjectIds.isNotEmpty) {
        if (selectedSubjectIds.length <= 10) {
          query = query.where(FieldPath.documentId, whereIn: selectedSubjectIds);
        }
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) {
        return <String, dynamic>{
          'id': doc.id,
          ...(doc.data() as Map<String, dynamic>),
        };
      }).toList();
    } catch (e) {
      Logger.error('Error fetching subjects for $gradeId', e);
      return [];
    }
  }

  /// Watch lessons for a specific subject
  Stream<List<Map<String, dynamic>>> watchLessons({
    required String gradeId,
    required String subjectId,
  }) {
    try {
      return firestore
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(subjectId)
          .collection('lessons')
          .where('enabled', isEqualTo: true)
          .orderBy('createdAt')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data(),
          };
        }).toList();
      });
    } catch (e) {
      Logger.error('Error watching lessons for $gradeId/$subjectId', e);
      return Stream.value([]);
    }
  }

  /// Get a single lesson
  Future<Map<String, dynamic>?> getLesson({
    required String gradeId,
    required String subjectId,
    required String lessonId,
  }) async {
    try {
      final doc = await firestore
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(subjectId)
          .collection('lessons')
          .doc(lessonId)
          .get();

      if (!doc.exists) return null;

      return {
        'id': doc.id,
        ...?doc.data(),
      };
    } catch (e) {
      Logger.error('Error fetching lesson $lessonId', e);
      return null;
    }
  }

  /// Watch quizzes for a specific subject
  Stream<List<Map<String, dynamic>>> watchQuizzes({
    required String gradeId,
    required String subjectId,
  }) {
    try {
      return firestore
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(subjectId)
          .collection('quizzes')
          .where('enabled', isEqualTo: true)
          .orderBy('createdAt')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data(),
          };
        }).toList();
      });
    } catch (e) {
      Logger.error('Error watching quizzes for $gradeId/$subjectId', e);
      return Stream.value([]);
    }
  }

  /// Watch videos stream for a subject
  Stream<List<Map<String, dynamic>>> watchVideos({
    required String gradeId,
    required String subjectId,
  }) {
    try {
      return firestore
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(subjectId)
          .collection('videos')
          .where('enabled', isEqualTo: true)
          .orderBy('createdAt')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data(),
          };
        }).toList();
      });
    } catch (e) {
      Logger.error('Error watching videos for $gradeId/$subjectId', e);
      return Stream.value([]);
    }
  }

  /// Watch stories stream for a subject
  Stream<List<Map<String, dynamic>>> watchStories({
    required String gradeId,
    required String subjectId,
  }) {
    try {
      return firestore
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(subjectId)
          .collection('stories')
          .where('enabled', isEqualTo: true)
          .orderBy('createdAt')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data(),
          };
        }).toList();
      });
    } catch (e) {
      Logger.error('Error watching stories for $gradeId/$subjectId', e);
      return Stream.value([]);
    }
  }

  /// Watch flashcard decks stream for a subject
  Stream<List<Map<String, dynamic>>> watchFlashcardDecks({
    required String gradeId,
    required String subjectId,
  }) {
    try {
      return firestore
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(subjectId)
          .collection('flashcard_decks')
          .where('enabled', isEqualTo: true)
          .orderBy('createdAt')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data(),
          };
        }).toList();
      });
    } catch (e) {
      Logger.error('Error watching flashcard decks for $gradeId/$subjectId', e);
      return Stream.value([]);
    }
  }

  /// Get a single quiz
  Future<Map<String, dynamic>?> getQuiz({
    required String gradeId,
    required String subjectId,
    required String quizId,
  }) async {
    try {
      final doc = await firestore
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(subjectId)
          .collection('quizzes')
          .doc(quizId)
          .get();

      if (!doc.exists) return null;

      return {
        'id': doc.id,
        ...?doc.data(),
      };
    } catch (e) {
      Logger.error('Error fetching quiz $quizId', e);
      return null;
    }
  }

  /// Check if materials exist for a grade (diagnostic)
  Future<bool> hasSubjectsForGrade(String gradeId) async {
    try {
      final snapshot = await firestore
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .limit(1)
          .get();

      final exists = snapshot.docs.isNotEmpty;
      Logger.info('Grade $gradeId has subjects: $exists');
      return exists;
    } catch (e) {
      Logger.error('Error checking subjects for $gradeId', e);
      return false;
    }
  }
}
