// Generated manually — `flutterfire configure` couldn't complete its OAuth
// login in this environment, so this mirrors the structure it would have
// produced, built from the config downloaded directly in Firebase Console.
// iOS is not registered yet in the Firebase project.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS — '
          'register the iOS app in the Firebase console first.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB5SThdMLEziUc_SyDP5sd4dT_Ha0stVnA',
    appId: '1:635857910784:web:db4c0623e1dc13b9922ce5',
    messagingSenderId: '635857910784',
    projectId: 'xtremeriders-app420',
    authDomain: 'xtremeriders-app420.firebaseapp.com',
    storageBucket: 'xtremeriders-app420.firebasestorage.app',
    measurementId: 'G-WP81LZ4K4M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmqIdFbHr2orYrlYfy7dYCQEehvPjRwfk',
    appId: '1:635857910784:android:cd31b7eb3ae84d41922ce5',
    messagingSenderId: '635857910784',
    projectId: 'xtremeriders-app420',
    storageBucket: 'xtremeriders-app420.firebasestorage.app',
  );
}
