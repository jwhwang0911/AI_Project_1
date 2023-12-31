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
    apiKey: 'AIzaSyC0JQ9Mke9v6GvMg9yS4O15MmdyOcnrSvc',
    appId: '1:563655127054:web:b0b6f182b72a2a95090c5f',
    messagingSenderId: '563655127054',
    projectId: 'readm-5e8a5',
    authDomain: 'readm-5e8a5.firebaseapp.com',
    storageBucket: 'readm-5e8a5.appspot.com',
    measurementId: 'G-NZM6VSCNRG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjFBDKD_NKAkmIf7IuozDgZJto-boHr9k',
    appId: '1:563655127054:android:5cc11de1a14aadd5090c5f',
    messagingSenderId: '563655127054',
    projectId: 'readm-5e8a5',
    storageBucket: 'readm-5e8a5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsnvRbtp3cO5iNnxjCt05a4IojtoXIrwc',
    appId: '1:563655127054:ios:993c78bb04f62997090c5f',
    messagingSenderId: '563655127054',
    projectId: 'readm-5e8a5',
    storageBucket: 'readm-5e8a5.appspot.com',
    iosBundleId: 'com.example.boosic',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAsnvRbtp3cO5iNnxjCt05a4IojtoXIrwc',
    appId: '1:563655127054:ios:7d1bb02fcfcc070c090c5f',
    messagingSenderId: '563655127054',
    projectId: 'readm-5e8a5',
    storageBucket: 'readm-5e8a5.appspot.com',
    iosBundleId: 'com.example.boosic.RunnerTests',
  );
}
