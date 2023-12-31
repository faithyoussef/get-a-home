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
    apiKey: 'AIzaSyD0JOtkz6mLq2YslW2dkpX4wMGLZNyU3Nw',
    appId: '1:744717497622:web:4810a506e641ec51774c37',
    messagingSenderId: '744717497622',
    projectId: 'getawallpaper-46c8a',
    authDomain: 'getawallpaper-46c8a.firebaseapp.com',
    storageBucket: 'getawallpaper-46c8a.appspot.com',
    measurementId: 'G-Z8F8KVKLGH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC41gWTmXKlWh41M-bysYzAzDlPZmJVRe8',
    appId: '1:744717497622:android:b7025e856313a50d774c37',
    messagingSenderId: '744717497622',
    projectId: 'getawallpaper-46c8a',
    storageBucket: 'getawallpaper-46c8a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCsM7PhTtuJZrNVJcLiSPiGBwPvbrmMIQw',
    appId: '1:744717497622:ios:5ae4d92311cb96b6774c37',
    messagingSenderId: '744717497622',
    projectId: 'getawallpaper-46c8a',
    storageBucket: 'getawallpaper-46c8a.appspot.com',
    iosClientId: '744717497622-b1teni06riid09onvptm7iqa84fbgub9.apps.googleusercontent.com',
    iosBundleId: 'com.example.getawallpaper',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCsM7PhTtuJZrNVJcLiSPiGBwPvbrmMIQw',
    appId: '1:744717497622:ios:77e72d7452911805774c37',
    messagingSenderId: '744717497622',
    projectId: 'getawallpaper-46c8a',
    storageBucket: 'getawallpaper-46c8a.appspot.com',
    iosClientId: '744717497622-2arlrjvg6qjg2p30otrql8ek4ofh9g78.apps.googleusercontent.com',
    iosBundleId: 'com.example.getawallpaper.RunnerTests',
  );
}
