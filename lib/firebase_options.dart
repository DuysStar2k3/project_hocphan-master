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
    apiKey: 'AIzaSyDrx5DKQ-p_UkbV3GwJ_gnMkBWrEBSUFo8',
    appId: '1:264773014211:web:c4607b1017009a0ae50876',
    messagingSenderId: '264773014211',
    projectId: 'photo-share-79468',
    authDomain: 'photo-share-79468.firebaseapp.com',
    storageBucket: 'photo-share-79468.appspot.com',
    measurementId: 'G-6HSJRM63FY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDs2L-2vVfP_ezN_4oTdmSaigf9Hi8S_80',
    appId: '1:264773014211:android:197f927b14d69992e50876',
    messagingSenderId: '264773014211',
    projectId: 'photo-share-79468',
    storageBucket: 'photo-share-79468.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAng8TXq7Ye6SAddEVgAyOGDeMTRSgPUkw',
    appId: '1:264773014211:ios:6f8ac3659cef7e4de50876',
    messagingSenderId: '264773014211',
    projectId: 'photo-share-79468',
    storageBucket: 'photo-share-79468.appspot.com',
    iosBundleId: 'com.example.devUploadImage',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAng8TXq7Ye6SAddEVgAyOGDeMTRSgPUkw',
    appId: '1:264773014211:ios:f92aa2cd408559dfe50876',
    messagingSenderId: '264773014211',
    projectId: 'photo-share-79468',
    storageBucket: 'photo-share-79468.appspot.com',
    iosBundleId: 'com.example.devUploadImage.RunnerTests',
  );
}
