import 'package:expendi/app/modules/auth/pages/_login_page.dart';
import 'package:expendi/app/modules/auth/pages/_register_page.dart';
import 'package:expendi/app/modules/dashboard/home/pages/_home_page.dart';
import 'package:expendi/app/modules/splash/pages/_splash_page.dart';
import 'package:expendi/app/transitions/_route_transition.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: SplashPage(),
      ),
    ),

    // login
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: LoginPage(),
      ),
    ),

    // register
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const RegisterPage(),
      ),
    ),

    // home
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => customTransitionPage(
        context: context,
        state: state,
        child: const HomePage(),
      ),
    ),
  ],
);

// custom transition:
