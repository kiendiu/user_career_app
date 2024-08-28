import 'package:auto_route/auto_route.dart';
import 'package:user_career_request/core/router.gm.dart';

@AutoRouterConfig.module()
class RequestRouterModule extends $RequestRouterModule {

  static List<AutoRoute> routes = [
    AutoRoute(page: RequestRoute.page),
  ];
}