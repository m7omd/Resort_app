import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'core/data/data_source/local/cache_helper.dart';
import 'core/utils/imports.dart';
import 'firebase_options.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  // await dotenv.load(fileName: EnvConfig.fileName);
  print("${CacheHelper.getData(key: "token")}");
  serviceLocator();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        startLocale: const Locale("ar"),
        fallbackLocale: const Locale('ar'),
        saveLocale: true,
        child: const MyApp(),
      ),
    ),
  );
}

//android   1:235330488242:android:a0461ce49757a6c33606ab
// ios       1:235330488242:ios:50ff1e88cb5035713606ab
