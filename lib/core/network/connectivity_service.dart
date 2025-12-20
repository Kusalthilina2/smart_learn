import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final isOnlineProvider = StreamProvider<bool>((ref) {
  return ref.watch(connectivityServiceProvider).isOnlineStream;
});

class ConnectivityService {
  final _connectivity = Connectivity();
  final _controller = StreamController<bool>.broadcast();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((results) {
      final hasConnection = results.isNotEmpty &&
          results.any((result) => result != ConnectivityResult.none);
      _controller.add(hasConnection);
    });
    _checkInitial();
  }

  Future<void> _checkInitial() async {
    final results = await _connectivity.checkConnectivity();
    final hasConnection = results.isNotEmpty &&
        results.any((result) => result != ConnectivityResult.none);
    _controller.add(hasConnection);
  }

  Stream<bool> get isOnlineStream => _controller.stream;

  Future<bool> get isOnline async {
    final results = await _connectivity.checkConnectivity();
    return results.isNotEmpty &&
        results.any((result) => result != ConnectivityResult.none);
  }

  void dispose() {
    _controller.close();
  }
}
