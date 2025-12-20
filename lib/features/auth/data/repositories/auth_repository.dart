import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/utils/time_utils.dart';
import '../../../../core/utils/logger.dart';
import '../models/user_profile.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  Stream<User?> get authStateChanges => auth.authStateChanges();

  User? get currentUser => auth.currentUser;

  Future<UserCredential> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> createUserProfile({
    required String uid,
    required String email,
    required String childName,
    required int grade,
    required String parentEmail,
  }) async {
    try {
      final profile = UserProfile(
        uid: uid,
        email: email,
        childName: childName,
        grade: grade,
        parentEmail: parentEmail,
        createdAt: TimeUtils.nowMs(),
        lastLoginAt: TimeUtils.nowMs(),
      );

      Logger.info('Creating user profile for $uid with email: $email');

      await firestore
          .doc(FirestorePaths.userDoc(uid))
          .set(profile.toJson(), SetOptions(merge: false));

      Logger.info('User profile created successfully for $uid');
    } catch (e) {
      Logger.error('Failed to create user profile for $uid', e);
      rethrow;
    }
  }

  Future<void> updateLastLogin(String uid) async {
    try {
      await firestore.doc(FirestorePaths.userDoc(uid)).update({
        'lastLoginAt': TimeUtils.nowMs(),
      });
      Logger.info('Updated last login for $uid');
    } catch (e) {
      Logger.error('Error updating last login', e);
    }
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    final doc = await firestore.doc(FirestorePaths.userDoc(uid)).get();
    if (!doc.exists) return null;
    return UserProfile.fromJson(doc.data()!);
  }

  Stream<UserProfile?> watchUserProfile(String uid) {
    return firestore
        .doc(FirestorePaths.userDoc(uid))
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      return UserProfile.fromJson(doc.data()!);
    });
  }

}
