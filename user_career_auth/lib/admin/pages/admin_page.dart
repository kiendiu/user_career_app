import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/pages/views/category_views/category_tab.dart';
import 'package:user_career_auth/admin/pages/views/dash_board_views/dash_board_tab.dart';
import 'package:user_career_auth/admin/pages/views/expert_views/expert_tab.dart';
import 'package:user_career_auth/admin/pages/views/language_views/language_tab.dart';
import 'package:user_career_auth/admin/pages/views/logout_view.dart';
import 'package:user_career_core/user_career_core.dart';

@RoutePage()
class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  ConsumerState createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  final _appBarController = BaseAppBarController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      customAppBar: BaseAppBarView(
        title: "Trang chủ",
        shouldShowLeading: false,
        controller: _appBarController,
        actions: [
          AppBarActionButton(
              child: Assets.icons.icFilter.svg(),
              onTap: () {}),
          AppBarActionButton(
              child: Assets.icons.icSearch.svg(),
              onTap: () {
                _appBarController.changeAppBarState(false);
              }),
          AppBarActionButton(
              child: Assets.icons.icLogoutIcon.svg(
                  height: 20,
                  width: 20,
                color: AppColors.white1Color
              ),
              onTap: () {
                context.showOverlay(const LogoutView());
              }),
        ],
      ),
      body: BaseTabBarView(
        data: [
          TabBarViewData.normal(
              title: "Thống kê",
              body: const DashBoardTab()),
          TabBarViewData.normal(
              title: "Chuyên gia",
              body: const ExpertTab()),
          TabBarViewData.normal(
              title: "Danh mục",
              body: const CategoryTab()),
          TabBarViewData.normal(
              title: "Ngôn ngữ",
              body: const LanguageTab()),
        ],
      ),
    );
  }
}
