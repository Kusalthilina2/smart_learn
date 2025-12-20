import 'package:flutter/foundation.dart';

class Logger {
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[DEBUG] $message');
      if (error != null) print('[ERROR] $error');
      if (stackTrace != null) print('[STACK] $stackTrace');
    }
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[ERROR] $message');
      if (error != null) print('[ERROR] $error');
      if (stackTrace != null) print('[STACK] $stackTrace');
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      print('[INFO] $message');
    }
  }
}
