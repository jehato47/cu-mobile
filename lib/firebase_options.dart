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
    apiKey: 'AIzaSyBuzo4pwZi6blqRAqQGLBo1NWGl8L0K5_o',
    appId: '1:1036605868885:web:bdc1a54010ccda71fdbddc',
    messagingSenderId: '1036605868885',
    projectId: 'cuku-mobile',
    authDomain: 'cuku-mobile.firebaseapp.com',
    storageBucket: 'cuku-mobile.appspot.com',
    measurementId: 'G-4J104Y05ZV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxSqPwNPBkJpm9lVYgmtP-1cNB2pDgbsU',
    appId: '1:1036605868885:android:d6b6e5691f2e9ec8fdbddc',
    messagingSenderId: '1036605868885',
    projectId: 'cuku-mobile',
    storageBucket: 'cuku-mobile.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxNTsLtDqh9xgQuejYcokgD-6ud4rzNMM',
    appId: '1:1036605868885:ios:cd94208ee2e97f44fdbddc',
    messagingSenderId: '1036605868885',
    projectId: 'cuku-mobile',
    storageBucket: 'cuku-mobile.appspot.com',
    iosClientId: '1036605868885-9qnf2p55nnk7vh9gctia318jujuje3ju.apps.googleusercontent.com',
    iosBundleId: 'com.example.cuMobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAxNTsLtDqh9xgQuejYcokgD-6ud4rzNMM',
    appId: '1:1036605868885:ios:cd94208ee2e97f44fdbddc',
    messagingSenderId: '1036605868885',
    projectId: 'cuku-mobile',
    storageBucket: 'cuku-mobile.appspot.com',
    iosClientId: '1036605868885-9qnf2p55nnk7vh9gctia318jujuje3ju.apps.googleusercontent.com',
    iosBundleId: 'com.example.cuMobile',
  );
}
