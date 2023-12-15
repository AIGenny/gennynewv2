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
    apiKey: 'AIzaSyC7glYqglbxE3RB1M5MT9g7ttU1NCYUWEs',
    appId: '1:690641507832:web:36cb1f5f2f0a6a1805720d',
    messagingSenderId: '690641507832',
    projectId: 'genny-v2-75394',
    authDomain: 'genny-v2-75394.firebaseapp.com',
    storageBucket: 'genny-v2-75394.appspot.com',
    measurementId: 'G-FJQKX9W81K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACezt6NmfpvK-imgX2nGZ3MXJSPA3Ssx8',
    appId: '1:690641507832:android:7b3f81da4d8af4b705720d',
    messagingSenderId: '690641507832',
    projectId: 'genny-v2-75394',
    storageBucket: 'genny-v2-75394.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzCAsZKTmA1qtvLlUe6jjg_kIAfzut81U',
    appId: '1:690641507832:ios:09d854795d4054a105720d',
    messagingSenderId: '690641507832',
    projectId: 'genny-v2-75394',
    storageBucket: 'genny-v2-75394.appspot.com',
    iosBundleId: 'com.example.gennynewv2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzCAsZKTmA1qtvLlUe6jjg_kIAfzut81U',
    appId: '1:690641507832:ios:2a438bedd891c98405720d',
    messagingSenderId: '690641507832',
    projectId: 'genny-v2-75394',
    storageBucket: 'genny-v2-75394.appspot.com',
    iosBundleId: 'com.example.gennynewv2.RunnerTests',
  );
}