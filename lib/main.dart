import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_new_template/features/home/presentation/chat/persons_cubit.dart';
import 'package:flutter_new_template/firebase_options.dart';

import 'core/injection_container.dart' as di;
import 'export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kPrimaryColor),
  );
  LocaleSettings.setLocaleRaw(AppLocale.en.languageCode);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(TranslationProvider(child: const MyApp()));
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final cubit = sl<PersonsCubit>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    cubit.updateStatus('online');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cubit.updateStatus('offline');
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      cubit.updateStatus('online');
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      cubit.updateStatus('offline');
    }
  }

  @override
  Widget build(BuildContext context) {
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
