import 'package:auto_route/auto_route.dart';
import 'package:user_career_more/core/router.gm.dart';

@AutoRouterConfig.module()
class MoreRouterModule extends $MoreRouterModule {

  static List<AutoRoute> routes = [
    AutoRoute(page: MoreRoute.page),
    AutoRoute(page: CalendarRoute.page),
    AutoRoute(page: UpdateInformationRoute.page),
    AutoRoute(page: ExpectRoute.page),
    AutoRoute(page: ServiceRoute.page),
    AutoRoute(page: WalletRoute.page),
    AutoRoute(page: ChangePasswordRoute.page)
  ];
}