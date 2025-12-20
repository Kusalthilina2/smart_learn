import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/connectivity_service.dart';
import '../utils/logger.dart';
import 'outbox_operation.dart';
import 'outbox_repository.dart';

final syncEngineProvider = Provider<SyncEngine>((ref) {
  return SyncEngine(
    firestore: FirebaseFirestore.instance,
    storage: FirebaseStorage.instance,
    outboxRepo: OutboxRepository(),
    connectivityService: ref.watch(connectivityServiceProvider),
  );
});

class SyncEngine {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final OutboxRepository outboxRepo;
  final ConnectivityService connectivityService;

  StreamSubscription? _connectivitySub;
  bool _isFlushing = false;

  SyncEngine({
    required this.firestore,
    required this.storage,
    required this.outboxRepo,
    required this.connectivityService,
  });

  void startListening() {
    _connectivitySub = connectivityService.isOnlineStream.listen((isOnline) {
      if (isOnline && !_isFlushing) {
        flushOutbox();
      }
    });
  }

  void stopListening() {
    _connectivitySub?.cancel();
  }

  Future<void> flushOutbox() async {
    if (_isFlushing) return;
    _isFlushing = true;

    try {
      final operations = outboxRepo.getPendingOperations();
      Logger.info('Flushing ${operations.length} pending operations');

      for (final op in operations) {
        if (op.retryCount >= 5) {
          Logger.error('Max retries reached for operation ${op.id}');
          await outboxRepo.remove(op.id);
          continue;
        }

        try {
          await outboxRepo.markInflight(op.id);
          await _executeOperation(op);
          await outboxRepo.remove(op.id);
          Logger.info('Successfully executed operation ${op.id}');
        } catch (e, st) {
          Logger.error('Failed to execute operation ${op.id}', e, st);
          await outboxRepo.markFailed(op.id, e.toString());
          await Future.delayed(Duration(seconds: 2 << op.retryCount));
        }
      }
    } finally {
      _isFlushing = false;
    }
  }

  Future<void> _executeOperation(OutboxOperation op) async {
    switch (op.op) {
      case OutboxOpType.setDoc:
        await firestore.doc(op.path).set(op.payload);
        break;
      case OutboxOpType.updateDoc:
        await firestore.doc(op.path).update(op.payload);
        break;
      case OutboxOpType.addDoc:
        await firestore.collection(op.path).add(op.payload);
        break;
      case OutboxOpType.deleteDoc:
        await firestore.doc(op.path).delete();
        break;
      case OutboxOpType.uploadFileMeta:
        break;
    }
  }
}
