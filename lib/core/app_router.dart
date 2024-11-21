import 'package:flutter_new_template/features/animated_splash/views/animated_splash_view.dart';
import 'package:flutter_new_template/features/auth/presentation/login/login_page.dart';
import 'package:flutter_new_template/features/auth/presentation/pass/home_page.dart';

import '../../export.dart';

/// don't use for navigate without context
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class AppRouter {
  /// use for navigate without context
  static final GoRouter routes = GoRouter(
      navigatorKey: navKey,
      initialLocation:
          !sl<GetStorage>().hasData(kToken) ? Routes.home : Routes.login,
      routes: [
        GoRoute(
          name: Routes.animatedSplash,
          path: Routes.animatedSplash,
          builder: (context, state) => AnimatedSplash(
            imagePath: '',
            home: sl<GetStorage>().hasData(kToken) ? Routes.home : Routes.login,
            title: '',
            duration: Duration.hoursPerDay,
            type: AnimatedSplashType.StaticDuration,
          ),
        ),
        GoRoute(
          name: Routes.login,
          path: Routes.login,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          name: Routes.home,
          path: Routes.home,
          builder: (context, state) => HomePage(),
        ),
      ]);
}
