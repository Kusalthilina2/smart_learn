
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] 

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDmfn0gwkwSHecto3kz5jDAbj8x9Sdx8NQ',
    appId: '1:510969647172:web:48129ced78bcaacb1f6c11',
    messagingSenderId: '510969647172',
    projectId: 'smartlearn-build',
    authDomain: 'smartlearn-build.firebaseapp.com',
    storageBucket: 'smartlearn-build.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAcqg5fFqZpONW5A6482xxj9SA5HT5UFWE',
    appId: '1:510969647172:android:8e4319215593c2361f6c11',
    messagingSenderId: '510969647172',
    projectId: 'smartlearn-build',
    storageBucket: 'smartlearn-build.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEEmc632nU4T5qSJ35_ICCYFlCxQF591k',
    appId: '1:510969647172:ios:8004d3c86d98b8b21f6c11',
    messagingSenderId: '510969647172',
    projectId: 'smartlearn-build',
    storageBucket: 'smartlearn-build.firebasestorage.app',
    iosBundleId: 'com.example.smartlearn',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBEEmc632nU4T5qSJ35_ICCYFlCxQF591k',
    appId: '1:510969647172:ios:8004d3c86d98b8b21f6c11',
    messagingSenderId: '510969647172',
    projectId: 'smartlearn-build',
    storageBucket: 'smartlearn-build.firebasestorage.app',
    iosBundleId: 'com.example.smartlearn',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDmfn0gwkwSHecto3kz5jDAbj8x9Sdx8NQ',
    appId: '1:510969647172:web:4ca9872d44d698a61f6c11',
    messagingSenderId: '510969647172',
    projectId: 'smartlearn-build',
    authDomain: 'smartlearn-build.firebaseapp.com',
    storageBucket: 'smartlearn-build.firebasestorage.app',
  );
}
