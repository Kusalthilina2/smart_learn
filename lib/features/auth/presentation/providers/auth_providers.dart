import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_profile.dart';
import '../../data/repositories/auth_repository.dart';

final currentUserProfileProvider = StreamProvider<UserProfile?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) {
      if (user == null) return Stream.value(null);
      return ref.watch(authRepositoryProvider).watchUserProfile(user.uid);
    },
    loading: () => Stream.value(null),
    error: (error, stackTrace) => Stream.value(null),
  );
});

final currentUserGradeProvider = Provider<String?>((ref) {
  final userProfile = ref.watch(currentUserProfileProvider).value;
  if (userProfile == null) return null;
  return 'grade_${userProfile.grade}';
});
