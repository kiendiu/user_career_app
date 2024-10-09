import 'package:auto_route/auto_route.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/expect_skills/pages/filter_update_category_page.dart';

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
    PresentedRoute(page: FilterUpdateCategoryRoute.page),
    PresentedRoute(page: AddExperienceRoute.page),
    PresentedRoute(page: EditExperienceRoute.page),
    PresentedRoute(page: FilterEditCategoryRoute.page),
    PresentedRoute(page: FilterExperienceCategoriesRoute.page),
    PresentedRoute(page: AddCertificateRoute.page),
    PresentedRoute(page: UpdateCertificateRoute.page),
    PresentedRoute(page: AddSkillRoute.page),
    PresentedRoute(page: UpdateSkillRoute.page),
    PresentedRoute(page: FilterUpdateCategoryRoute.page),
  ];
}