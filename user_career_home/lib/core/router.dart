import 'package:auto_route/auto_route.dart';
import 'package:user_career_home/core/router.gm.dart';

@AutoRouterConfig.module()
class HomeRouterModule extends $HomeRouterModule {

  static List<AutoRoute> routes = [
    AutoRoute(page: HomeRoute.page),
  ];
}