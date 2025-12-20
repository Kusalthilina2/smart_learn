import 'package:hive/hive.dart';
import '../storage/hive_init.dart';
import '../utils/uuid_generator.dart';
import '../utils/time_utils.dart';
import 'outbox_operation.dart';

class OutboxRepository {
  Box get _box => Hive.box(HiveBoxes.outbox);

  Future<void> addOperation({
    required OutboxOpType op,
    required String path,
    required Map<String, dynamic> payload,
  }) async {
    final operation = OutboxOperation(
      id: UuidGenerator.generate(),
      createdAtMs: TimeUtils.nowMs(),
      op: op,
      path: path,
      payload: payload,
      status: OutboxStatus.pending,
      retryCount: 0,
    );
    await _box.put(operation.id, operation.toJson());
  }

  List<OutboxOperation> getPendingOperations() {
    return _box.values
        .map((e) => OutboxOperation.fromJson((e as Map).cast<String, dynamic>()))
        .where((op) => op.status == OutboxStatus.pending)
        .toList()
      ..sort((a, b) => a.createdAtMs.compareTo(b.createdAtMs));
  }

  Future<void> markInflight(String id) async {
    final data = _box.get(id);
    if (data != null) {
      final op = OutboxOperation.fromJson((data as Map).cast<String, dynamic>());
      await _box.put(
        id,
        op.copyWith(status: OutboxStatus.inflight).toJson(),
      );
    }
  }

  Future<void> markFailed(String id, String error) async {
    final data = _box.get(id);
    if (data != null) {
      final op = OutboxOperation.fromJson((data as Map).cast<String, dynamic>());
      await _box.put(
        id,
        op
            .copyWith(
              status: OutboxStatus.failed,
              retryCount: op.retryCount + 1,
              lastError: error,
            )
            .toJson(),
      );
    }
  }

  Future<void> remove(String id) async {
    await _box.delete(id);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
