import 'package:flutter/foundation.dart';
import 'package:flutter_new_template/features/post/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'core/injection_container.dart' as di;
import 'export.dart';
import 'features/post/presentation/bloc/posts/posts_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  await Future.wait([GetStorage.init()]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kPrimaryColor),
  );
  LocaleSettings.setLocaleRaw(
      sl<GetStorage>().read(kLanguage) ?? AppLocale.en.languageCode);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        RequestsInspector(
          navigatorKey: null,
          enabled: kDebugMode,
          showInspectorOn: ShowInspectorOn.LongPress,
          child: TranslationProvider(child: const MyApp()),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  static bool isDark = GetStorage().read('dark') ?? false;
  static BuildContext? appContext;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    appContext = context;
    return ScreenUtilInit(
        designSize: const Size(baseWidth, baseHeight),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
              BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
            ],
            child: MaterialApp.router(
              locale: TranslationProvider.of(context).flutterLocale,
              theme: isDark ? darkTheme : lightTheme,
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.routes,
            ),
          );
        });
  }
}
