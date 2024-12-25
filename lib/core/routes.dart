import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wcycle_admin_panel/screen/home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "root");
final GlobalKey<NavigatorState> _sheelKey =
    GlobalKey<NavigatorState>(debugLabel: "shell");
final routes = GoRouter(
    initialLocation: "/home/dashboard",
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: "/home",
        builder: (context, state) => const HomeScreen(),
      ),
      ShellRoute(
          navigatorKey: _sheelKey,
          builder: (context, state, child) => child,
          routes: [
            GoRoute(
              path: "/home/:tab",
              builder: (context, state) => HomeScreen(
                key: state.pageKey,
                tab: state.pathParameters['tab'] ?? "dashboard",
              ),
            ),
          ])
    ]);
