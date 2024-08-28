import 'package:auto_route/auto_route.dart';
import 'package:user_career_message/core/router.gm.dart';

@AutoRouterConfig.module()
class MessageRouterModule extends $MessageRouterModule {

  static List<AutoRoute> routes = [
    AutoRoute(page: MessageRoute.page),
  ];
}