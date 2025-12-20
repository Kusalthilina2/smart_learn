import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'core/storage/hive_init.dart';
import 'core/sync/sync_engine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  await HiveInit.initialize();

  final container = ProviderContainer();

  

  final syncEngine = container.read(syncEngineProvider);
  syncEngine.startListening();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const SmartLearnApp(),
    ),
  );
}
