import 'package:user_career_auth/core/router.dart';
import 'package:user_career_auth/core/router.gm.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/core/router.dart';
import 'package:user_career_home/core/router.gm.dart';
import 'package:user_career_request/core/router.dart';
import 'package:user_career_request/core/router.gm.dart';
import 'package:user_career_more/core/router.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_message/core/router.dart';
import 'package:user_career_message/core/router.gm.dart';
import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(modules: [
  HomeRouterModule,
  RequestRouterModule,
  //MessageRouterModule,
  MoreRouterModule,
  AuthRouterModule,
  MobileFrameworkRouterModule,
])
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    ApplicationMainRoute(
      tabs: [
        TabRoute(
            tabRouterPage: HomeTabRouter.page,
            firstPage: HomeRoute.page),
        TabRoute(
            tabRouterPage: RequestTabRouter.page,
            firstPage: RequestRoute.page),
        // TabRoute(
        //     tabRouterPage: MessageTabRouter.page,
        //     firstPage: MessageRoute.page),
        TabRoute(
            tabRouterPage: MoreTabRouter.page,
            firstPage: MoreRoute.page),
      ],
      guards: [
        AutoRouteGuardCallback(
              (resolver, router) {
            if (AuthManager.checkValidAccessToken()) {
              resolver.next(true);
            } else {
              router.replaceAll([
                const SignInRoute(),
              ]);
            }
          },
        )
      ]
    ),
    ...MobileFrameworkRouterModule.routes,
    ...AuthRouterModule.routes,
    ...RequestRouterModule.routes,
    ...HomeRouterModule.routes,
    ...MoreRouterModule.routes,
    //...MessageRouterModule.routes,
  ];
}
