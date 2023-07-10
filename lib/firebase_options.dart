// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
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
    apiKey: 'AIzaSyB4F1iY70Jo9qs0BXDmPpAoK9lT5xNSmps',
    appId: '1:143000456157:web:0c9051393af193a8510434',
    messagingSenderId: '143000456157',
    projectId: 'taskify-app-1853c',
    authDomain: 'taskify-app-1853c.firebaseapp.com',
    storageBucket: 'taskify-app-1853c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-04-N9Wi3GpmuBz7dcrg5NxjYusG0VHs',
    appId: '1:143000456157:android:6d2b044c064c13a3510434',
    messagingSenderId: '143000456157',
    projectId: 'taskify-app-1853c',
    storageBucket: 'taskify-app-1853c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdSoIp0H9-umsTiJvTeN3o8VF1UdUbAqM',
    appId: '1:143000456157:ios:1f27d2433312e375510434',
    messagingSenderId: '143000456157',
    projectId: 'taskify-app-1853c',
    storageBucket: 'taskify-app-1853c.appspot.com',
    iosClientId: '143000456157-fc1rl7749iaga6knsoauoiv4vm1fu2ie.apps.googleusercontent.com',
    iosBundleId: 'com.example.taskify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdSoIp0H9-umsTiJvTeN3o8VF1UdUbAqM',
    appId: '1:143000456157:ios:1f27d2433312e375510434',
    messagingSenderId: '143000456157',
    projectId: 'taskify-app-1853c',
    storageBucket: 'taskify-app-1853c.appspot.com',
    iosClientId: '143000456157-fc1rl7749iaga6knsoauoiv4vm1fu2ie.apps.googleusercontent.com',
    iosBundleId: 'com.example.taskify',
  );
}
