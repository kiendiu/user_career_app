import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:user_career_auth/core/router.gm.dart';

@AutoRouterConfig.module()
class AuthRouterModule extends $AuthRouterModule {
  static List<AutoRoute> routes = [
    CustomRoute(
      page: SignInRoute.page,
      fullscreenDialog: true,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: SendMailVerifyRoute.page),
    AutoRoute(page: MailVerifyCodeRoute.page),
    AutoRoute(page: SuccessfulRoute.page),
    AutoRoute(page: ResetPasswordRoute.page),
    AutoRoute(page: AdminRoute.page),
    AutoRoute(page: UserDetailRoute.page)
  ];
}