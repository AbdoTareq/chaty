import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_new_template/firebase_options.dart';

import 'core/injection_container.dart' as di;
import 'export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kPrimaryColor),
  );
  LocaleSettings.setLocaleRaw(AppLocale.en.languageCode);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        TranslationProvider(child: const MyApp()),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  static BuildContext? appContext;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    appContext = context;
    return ScreenUtilInit(
        designSize: const Size(baseWidth, baseHeight),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            locale: TranslationProvider.of(context).flutterLocale,
            theme: darkTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.routes,
          );
        });
  }
}
