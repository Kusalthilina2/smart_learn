import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../../core/storage/hive_init.dart';
import '../../../../core/utils/logger.dart';
import '../models/story.dart';

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepository(firestore: FirebaseFirestore.instance);
});

class StoryRepository {
  final FirebaseFirestore firestore;
  StoryRepository({required this.firestore});

  Box get _cacheBox => Hive.box(HiveBoxes.cachePublicStories);

  Future<List<Story>> fetchStoriesBySubject(String subjectId) async {
    try {
      final snapshot = await firestore
          .collection('public_stories')
          .where('subjectId', isEqualTo: subjectId)
          .get();

      final stories = snapshot.docs
          .map((doc) => Story.fromJson({...doc.data(), 'id': doc.id}))
          .toList();

      for (final story in stories) {
        await _cacheBox.put(story.id, story.toJson());
      }
      return stories;
    } catch (e) {
      Logger.error('Failed to fetch stories', e);
      return getCachedStories().where((s) => s.subjectId == subjectId).toList();
    }
  }

  List<Story> getCachedStories() {
    return _cacheBox.values
        .map((e) => Story.fromJson((e as Map).cast<String, dynamic>()))
        .toList();
  }

  Future<Story?> getStoryById(String storyId) async {
    final cached = _cacheBox.get(storyId);
    if (cached != null) {
      return Story.fromJson((cached as Map).cast<String, dynamic>());
    }

    try {
      final doc = await firestore
          .doc('public_stories/$storyId')
          .get();
      if (doc.exists) {
        final story = Story.fromJson({...doc.data()!, 'id': doc.id});
        await _cacheBox.put(storyId, story.toJson());
        return story;
      }
    } catch (e) {
      Logger.error('Failed to fetch story $storyId', e);
    }
    return null;
  }
}
