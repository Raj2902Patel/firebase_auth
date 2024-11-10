// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAnMZZlhHa72z9u45XOcdyB2BsRyWAMaAc',
    appId: '1:888583132149:web:4fb0430f55a9dc091dc6bc',
    messagingSenderId: '888583132149',
    projectId: 'fir-firebase-92ac9',
    authDomain: 'fir-firebase-92ac9.firebaseapp.com',
    storageBucket: 'fir-firebase-92ac9.firebasestorage.app',
    measurementId: 'G-9T4K7XWJ3C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAz5QTDBBreboYwzyQUbRMIulh_QcrQTbE',
    appId: '1:888583132149:android:9e8c5e1a9b2573ed1dc6bc',
    messagingSenderId: '888583132149',
    projectId: 'fir-firebase-92ac9',
    storageBucket: 'fir-firebase-92ac9.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUlagCqrxlVRZJXuMkeJVhbbfMFJuCgGg',
    appId: '1:888583132149:ios:597c54ef2fe7db291dc6bc',
    messagingSenderId: '888583132149',
    projectId: 'fir-firebase-92ac9',
    storageBucket: 'fir-firebase-92ac9.firebasestorage.app',
    iosBundleId: 'com.example.demoFirebase',
  );
}