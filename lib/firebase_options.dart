// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  static FirebaseOptions get web => FirebaseOptions(
        apiKey: dotenv.env['WEB_API_KEY']!,
        appId: dotenv.env['WEB_APP_ID']!,
        messagingSenderId: dotenv.env['WEB_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['WEB_PROJECT_ID']!,
        authDomain: dotenv.env['WEB_AUTH_DOMAIN'],
        storageBucket: dotenv.env['WEB_STORAGE_BUCKET'],
        measurementId: dotenv.env['WEB_MEASUREMENT_ID'],
      );

  static FirebaseOptions get android => FirebaseOptions(
        apiKey: dotenv.env['ANDROID_API_KEY']!,
        appId: dotenv.env['ANDROID_APP_ID']!,
        messagingSenderId: dotenv.env['ANDROID_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['ANDROID_PROJECT_ID']!,
        storageBucket: dotenv.env['ANDROID_STORAGE_BUCKET'],
      );

  static FirebaseOptions get ios => FirebaseOptions(
        apiKey: dotenv.env['IOS_API_KEY']!,
        appId: dotenv.env['IOS_APP_ID']!,
        messagingSenderId: dotenv.env['IOS_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['IOS_PROJECT_ID']!,
        storageBucket: dotenv.env['IOS_STORAGE_BUCKET'],
        iosClientId: dotenv.env['IOS_CLIENT_ID'],
        iosBundleId: dotenv.env['IOS_BUNDLE_ID'],
      );

  static FirebaseOptions get macos => FirebaseOptions(
        apiKey: dotenv.env['MACOS_API_KEY']!,
        appId: dotenv.env['MACOS_APP_ID']!,
        messagingSenderId: dotenv.env['MACOS_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['MACOS_PROJECT_ID']!,
        storageBucket: dotenv.env['MACOS_STORAGE_BUCKET'],
        androidClientId: dotenv.env['MACOS_ANDROID_CLIENT_ID'],
        iosClientId: dotenv.env['MACOS_IOS_CLIENT_ID'],
        iosBundleId: dotenv.env['MACOS_IOS_BUNDLE_ID'],
      );

  static FirebaseOptions get windows => FirebaseOptions(
        apiKey: dotenv.env['WINDOWS_API_KEY']!,
        appId: dotenv.env['WINDOWS_APP_ID']!,
        messagingSenderId: dotenv.env['WINDOWS_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['WINDOWS_PROJECT_ID']!,
        authDomain: dotenv.env['WINDOWS_AUTH_DOMAIN'],
        storageBucket: dotenv.env['WINDOWS_STORAGE_BUCKET'],
        measurementId: dotenv.env['WINDOWS_MEASUREMENT_ID'],
      );
}
