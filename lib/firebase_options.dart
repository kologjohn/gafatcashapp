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
    apiKey: 'AIzaSyBDFMjiFsTmxPAJxOieKhU4Xy8Wx8xvKac',
    appId: '1:542035889260:web:910e8b997298d4d3eedc49',
    messagingSenderId: '542035889260',
    projectId: 'gafatcash-405b7',
    authDomain: 'gafatcash-405b7.firebaseapp.com',
    storageBucket: 'gafatcash-405b7.appspot.com',
    measurementId: 'G-6EEEHFLH5V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBSSr_ZtiG9eys6tCpVqJdTPjClejzrZ-g',
    appId: '1:542035889260:android:7f072e027fec60b4eedc49',
    messagingSenderId: '542035889260',
    projectId: 'gafatcash-405b7',
    storageBucket: 'gafatcash-405b7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCm9VA3WPQ5wvjZ9i3t6-HyD87ymVzTlTI',
    appId: '1:542035889260:ios:d93c69a787d69c2deedc49',
    messagingSenderId: '542035889260',
    projectId: 'gafatcash-405b7',
    storageBucket: 'gafatcash-405b7.appspot.com',
    androidClientId: '542035889260-0f3lgb0mturuqp0d20nr741vsqv4fidc.apps.googleusercontent.com',
    iosClientId: '542035889260-vsdi3vm49v39ttatid9kju468ovng63l.apps.googleusercontent.com',
    iosBundleId: 'com.gafatcash.gafatcash',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBRlujz8bGNQNwscxXSo7hNQvI1ANzlnV4',
    appId: '1:542035889260:ios:585cd04b718014c2eedc49',
    messagingSenderId: '542035889260',
    projectId: 'gafatcash-405b7',
    storageBucket: 'gafatcash-405b7.appspot.com',
    androidClientId: '542035889260-0f3lgb0mturuqp0d20nr741vsqv4fidc.apps.googleusercontent.com',
    iosClientId: '542035889260-uuf9hjvo45vbgpmuqg4f5ipq23ts7j67.apps.googleusercontent.com',
    iosBundleId: 'com.gafatcash.gafatcash.RunnerTests',
  );
}