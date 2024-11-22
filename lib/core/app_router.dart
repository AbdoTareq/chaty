import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_template/features/animated_splash/views/animated_splash_view.dart';
import 'package:flutter_new_template/features/home/presentation/chat/chat_details_page.dart';
import 'package:flutter_new_template/features/home/presentation/chat/persons_list_page.dart';
import 'package:flutter_new_template/features/auth/presentation/login/login_page.dart';
import 'package:flutter_new_template/features/auth/presentation/login/signup_page.dart';

import '../../export.dart';

/// don't use for navigate without context
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class AppRouter {
  /// use for navigate without context
  static final GoRouter routes = GoRouter(
      navigatorKey: navKey,
      initialLocation: Routes.animatedSplash,
      routes: [
        GoRoute(
          name: Routes.animatedSplash,
          path: Routes.animatedSplash,
          builder: (context, state) => AnimatedSplash(
            imagePath: '',
            home: sl<FirebaseAuth>().currentUser?.email != null
                ? Routes.personsList
                : Routes.login,
            title: '',
            duration: Duration.hoursPerDay,
            type: AnimatedSplashType.StaticDuration,
          ),
        ),
        GoRoute(
          name: Routes.login,
          path: Routes.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          name: Routes.signup,
          path: Routes.signup,
          builder: (context, state) => const SignupPage(),
        ),
        GoRoute(
          name: Routes.personsList,
          path: Routes.personsList,
          builder: (context, state) => const PersonsListPage(),
        ),
        GoRoute(
          name: Routes.chatDetails,
          path: Routes.chatDetails,
          builder: (context, state) => const ChatDetailsPage(),
        ),
      ]);
}
