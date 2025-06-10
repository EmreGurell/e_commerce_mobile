import 'package:flutter/services.dart';
import 'package:tarhanaciyasarmobil/app.dart';
import 'package:tarhanaciyasarmobil/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Widget binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Load .env file BEFORE Firebase initialization
  await dotenv.load(fileName: ".env");

  // GetX Local Storage
  await GetStorage.init();

  // Status bar tasarımı
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  // Splash ekranı açık kalsın
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Firebase başlat
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) {
    Get.put(AuthenticationRepository());
  });

  // Uygulamayı başlat
  runApp(const MyApp());
}
