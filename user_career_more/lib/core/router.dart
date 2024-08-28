import 'package:auto_route/auto_route.dart';
import 'package:user_career_more/core/router.gm.dart';

@AutoRouterConfig.module()
class MoreRouterModule extends $MoreRouterModule {

  static List<AutoRoute> routes = [
    AutoRoute(page: MoreRoute.page),
  ];
}