import 'package:expendi/app/modules/auth/pages/_login_page.dart';
import 'package:expendi/app/modules/auth/pages/_register_page.dart';
import 'package:expendi/app/modules/dashboard/_main_shell.dart';
import 'package:expendi/app/modules/dashboard/add/pages/_add_page.dart';
import 'package:expendi/app/modules/dashboard/expenses/pages/_expense_page.dart';
import 'package:expendi/app/modules/dashboard/home/pages/_home_page.dart';
import 'package:expendi/app/modules/dashboard/preferences/pages/_preferences_page.dart';
import 'package:expendi/app/modules/splash/pages/_splash_page.dart';
import 'package:expendi/app/transitions/_route_transition.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
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
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context,state)=> customTransitionPage(
                context: context,
                state: state,
                child: HomePage(),
              ),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/add',
              pageBuilder: (context,state)=> customTransitionPage(
                context: context,
                state: state,
                child: AddPage(),
              ),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/expenses',
              pageBuilder: (context,state)=> customTransitionPage(
                context: context,
                state: state,
                child: ExpensesPage(),
              ),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/preferences',
              pageBuilder: (context,state)=> customTransitionPage(
                context: context,
                state: state,
                child: PreferencesPage(),
              ),
            ),
          ],
        ),
      ]
    )
  ],
);

// custom transition:
