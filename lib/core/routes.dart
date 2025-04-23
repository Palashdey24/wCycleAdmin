import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wcycle_admin_panel/model/store_model.dart';
import 'package:wcycle_admin_panel/page/add/add_events_items.dart';
import 'package:wcycle_admin_panel/page/add/add_littered_spot_items.dart';
import 'package:wcycle_admin_panel/page/add/add_recyclecategory.dart';
import 'package:wcycle_admin_panel/page/store_profile_page.dart';
import 'package:wcycle_admin_panel/screen/credintial_screen.dart';
import 'package:wcycle_admin_panel/screen/home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "root");
/*final GlobalKey<NavigatorState> _sheelKey =
    GlobalKey<NavigatorState>(debugLabel: "shell");*/

const String _basePath = "/WCycleDatabase";
final routes = GoRouter(
    initialLocation: "$_basePath/${CredentialScreen.pageConfig.pageName}",
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: "$_basePath/${CredentialScreen.pageConfig.pageName}",
        name: CredentialScreen.pageConfig.pageName,
        builder: (context, state) => const CredentialScreen(),
      ),
      GoRoute(
        path: "$_basePath/${HomeScreen.pageConfig.pageName}",
        name: HomeScreen.pageConfig.pageName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: "$_basePath/${AddRecycableCategory.pageConfig.pageName}",
        name: AddRecycableCategory.pageConfig.pageName,
        builder: (context, state) => const AddRecycableCategory(),
      ),
      GoRoute(
        path: "$_basePath/${AddEventsItems.pageConfig.pageName}",
        name: AddEventsItems.pageConfig.pageName,
        builder: (context, state) => const AddEventsItems(),
      ),
      GoRoute(
        path: "$_basePath/${AddLitteredSpotItems.pageConfig.pageName}",
        name: AddLitteredSpotItems.pageConfig.pageName,
        builder: (context, state) => const AddLitteredSpotItems(),
      ),
      GoRoute(
        path: "$_basePath/${StoreProfilePage.pageConfig.pageName}",
        name: StoreProfilePage.pageConfig.pageName,
        builder: (context, state) =>
            StoreProfilePage(storeModel: state.extra as StoreModel),
      ),
/*      ShellRoute(
          navigatorKey: _sheelKey,
          builder: (context, state, child) => child,
          routes: [
            GoRoute(
              name: HomeScreen.pageConfig.pageName,
              path: "$_basePath/:tab",
              builder: (context, state) => HomeScreen(
                key: state.pageKey,
                tab: state.pathParameters['tab'] ?? "dashboard",
              ),
            ),
          ])*/
    ]);
