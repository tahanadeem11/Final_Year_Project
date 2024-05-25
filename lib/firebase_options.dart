// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
 import 'firebase_options.dart';
/// // ...


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
    apiKey: 'AIzaSyBcL-mSFunTMPlZd99cCugygct0K0pX90k',
    appId: '1:636512754707:web:567e135bd69846692df3e6',
    messagingSenderId: '636512754707',
    projectId: 'labquest-c735f',
    authDomain: 'labquest-c735f.firebaseapp.com',
    storageBucket: 'labquest-c735f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeohanPV-VwDyp86bhVhbsJSdJgjTHhwM',
    appId: '1:636512754707:android:8748b466bc1230912df3e6',
    messagingSenderId: '636512754707',
    projectId: 'labquest-c735f',
    storageBucket: 'labquest-c735f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDR54NUOAKEDPltJYKFXQI8sttnj2FJU5Q',
    appId: '1:636512754707:ios:3bdc87b88037562e2df3e6',
    messagingSenderId: '636512754707',
    projectId: 'labquest-c735f',
    storageBucket: 'labquest-c735f.appspot.com',
    iosClientId: '636512754707-tr7ao9hbbs50rn08v6pu7ugll04i3g4g.apps.googleusercontent.com',
    iosBundleId: 'com.example.labquest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDR54NUOAKEDPltJYKFXQI8sttnj2FJU5Q',
    appId: '1:636512754707:ios:3bdc87b88037562e2df3e6',
    messagingSenderId: '636512754707',
    projectId: 'labquest-c735f',
    storageBucket: 'labquest-c735f.appspot.com',
    iosClientId: '636512754707-tr7ao9hbbs50rn08v6pu7ugll04i3g4g.apps.googleusercontent.com',
    iosBundleId: 'com.example.labquest',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBcL-mSFunTMPlZd99cCugygct0K0pX90k',
    appId: '1:636512754707:web:c8f6e0fcb4c65b192df3e6',
    messagingSenderId: '636512754707',
    projectId: 'labquest-c735f',
    authDomain: 'labquest-c735f.firebaseapp.com',
    storageBucket: 'labquest-c735f.appspot.com',
  );
}