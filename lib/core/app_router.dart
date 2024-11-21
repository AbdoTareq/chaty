import 'package:flutter_new_template/features/animated_splash/views/animated_splash_view.dart';
import 'package:flutter_new_template/features/auth/presentation/login/login_page.dart';
import 'package:flutter_new_template/features/auth/presentation/pass/confirm_page.dart';
import 'package:flutter_new_template/features/auth/presentation/pass/reset_pass_phone_page.dart';
import 'package:flutter_new_template/features/home/presentation/nav_page.dart';
import 'package:flutter_new_template/features/post/presentation/pages/posts_page.dart';

import '../../export.dart';

/// don't use for navigate without context
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class AppRouter {
  /// use for navigate without context
  static final GoRouter routes = GoRouter(
      navigatorKey: navKey,
      initialLocation:
          !sl<GetStorage>().hasData(kToken) ? Routes.posts : Routes.login,
      routes: [
        GoRoute(
          name: Routes.animatedSplash,
          path: Routes.animatedSplash,
          builder: (context, state) => AnimatedSplash(
            imagePath: '',
            home:
                sl<GetStorage>().hasData(kToken) ? Routes.posts : Routes.login,
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
        // GoRoute(
        //   name: Routes.signup,
        //   path: Routes.signup,
        //   builder: (context, state) => SignUpPage(),
        // ),
        GoRoute(
          name: Routes.resetPassPhone,
          path: Routes.resetPassPhone,
          builder: (context, state) =>
              ResetPassPhonePage(phoneArg: state.extra as String),
        ),
        GoRoute(
          name: Routes.confirm,
          path: Routes.confirm,
          builder: (context, state) =>
              ConfirmPage(phone: state.extra as String),
        ),
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return NavPage(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            // The route branch for the first tab of the bottom navigation bar.
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: Routes.posts,
                  path: Routes.posts,
                  builder: (context, state) => const PostsPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: Routes.posts2,
                  path: Routes.posts2,
                  builder: (context, state) => const PostsPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: Routes.posts3,
                  path: Routes.posts3,
                  builder: (context, state) => const PostsPage(),
                ),
              ],
            ),
          ],
        ),
      ]);
}
