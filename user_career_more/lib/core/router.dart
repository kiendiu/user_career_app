import 'package:auto_route/auto_route.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/router.gm.dart';

@AutoRouterConfig.module()
class MoreRouterModule extends $MoreRouterModule {

  static List<AutoRoute> routes = [
    AutoRoute(page: MoreRoute.page),
    PresentedRoute(page: CalendarRoute.page),
    PresentedRoute(page: UpdateInformationRoute.page),
    PresentedRoute(page: ExpectRoute.page),
    PresentedRoute(page: ServiceRoute.page),
    PresentedRoute(page: WalletRoute.page),
    PresentedRoute(page: ChangePasswordRoute.page),
    PresentedRoute(page: ExpectExperiencesRoute.page),
    PresentedRoute(page: ExpectSkillsRoute.page),
    PresentedRoute(page: ExpectCertificatesRoute.page),
    PresentedRoute(page: ExpectPriceServiceRoute.page),
    PresentedRoute(page: FilterCategoriesRoute.page),
    PresentedRoute(page: AddExperienceRoute.page)
  ];
}