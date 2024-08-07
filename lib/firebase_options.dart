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
    apiKey: 'AIzaSyABHFDa57ZQO3Cs4FE1vSY1QJBjLmB1oGQ',
    appId: '1:1049973497665:web:e7ada2004cdbc4a86a0bc0',
    messagingSenderId: '1049973497665',
    projectId: 'marathiaarti-125c8',
    authDomain: 'marathiaarti-125c8.firebaseapp.com',
    databaseURL: 'https://marathiaarti-125c8.firebaseio.com',
    storageBucket: 'marathiaarti-125c8.appspot.com',
    measurementId: 'G-DN6E44J47F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZtWYATFsJjlZ2DJamqcQ1l4Z-yjP_KCk',
    appId: '1:1049973497665:android:ed3b5b08ea4be918',
    messagingSenderId: '1049973497665',
    projectId: 'marathiaarti-125c8',
    databaseURL: 'https://marathiaarti-125c8.firebaseio.com',
    storageBucket: 'marathiaarti-125c8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6TBh5-nb_4xU0SI4w7qX09cLtO43D2Hw',
    appId: '1:1049973497665:ios:3fba01fa35ea4b396a0bc0',
    messagingSenderId: '1049973497665',
    projectId: 'marathiaarti-125c8',
    databaseURL: 'https://marathiaarti-125c8.firebaseio.com',
    storageBucket: 'marathiaarti-125c8.appspot.com',
    androidClientId: '1049973497665-cgnlh0kh0mv7jrj3rsvpe12d298uugoj.apps.googleusercontent.com',
    iosClientId: '1049973497665-dpfgms25h77hea9anu8fg55a32gsa443.apps.googleusercontent.com',
    iosBundleId: 'com.prateektimer.flutterwallpaper',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6TBh5-nb_4xU0SI4w7qX09cLtO43D2Hw',
    appId: '1:1049973497665:ios:7861730fea328e616a0bc0',
    messagingSenderId: '1049973497665',
    projectId: 'marathiaarti-125c8',
    databaseURL: 'https://marathiaarti-125c8.firebaseio.com',
    storageBucket: 'marathiaarti-125c8.appspot.com',
    androidClientId: '1049973497665-cgnlh0kh0mv7jrj3rsvpe12d298uugoj.apps.googleusercontent.com',
    iosClientId: '1049973497665-6ihikqlffm9pfu4co507u45v5l51libr.apps.googleusercontent.com',
    iosBundleId: 'com.prateektimer.flutterwallpaper.RunnerTests',
  );
}
