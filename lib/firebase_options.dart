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
    apiKey: 'AIzaSyCLP8moXXVG40Nno26RINimyZcUXB1gBP8',
    appId: '1:537652772617:web:7789fe0f491879e3c2ddd8',
    messagingSenderId: '537652772617',
    projectId: 'productgiuaky',
    authDomain: 'productgiuaky.firebaseapp.com',
    storageBucket: 'productgiuaky.firebasestorage.app',
    measurementId: 'G-H2QS15X6CM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIIRjsb6Erwsl1diW1Xv-z6zgfvcmbY8I',
    appId: '1:537652772617:android:3b8a1916dded6ffbc2ddd8',
    messagingSenderId: '537652772617',
    projectId: 'productgiuaky',
    storageBucket: 'productgiuaky.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAaiFwrw1uVW2KxU6FsUKQE3PAI3kmQquI',
    appId: '1:537652772617:ios:98510f0aa72dd02ac2ddd8',
    messagingSenderId: '537652772617',
    projectId: 'productgiuaky',
    storageBucket: 'productgiuaky.firebasestorage.app',
    iosBundleId: 'com.example.giuaKy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAaiFwrw1uVW2KxU6FsUKQE3PAI3kmQquI',
    appId: '1:537652772617:ios:98510f0aa72dd02ac2ddd8',
    messagingSenderId: '537652772617',
    projectId: 'productgiuaky',
    storageBucket: 'productgiuaky.firebasestorage.app',
    iosBundleId: 'com.example.giuaKy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCLP8moXXVG40Nno26RINimyZcUXB1gBP8',
    appId: '1:537652772617:web:53c5365d43b78056c2ddd8',
    messagingSenderId: '537652772617',
    projectId: 'productgiuaky',
    authDomain: 'productgiuaky.firebaseapp.com',
    storageBucket: 'productgiuaky.firebasestorage.app',
    measurementId: 'G-H96FDFB7GR',
  );
}
