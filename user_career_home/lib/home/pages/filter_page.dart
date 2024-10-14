import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_appbar.dart';
import 'package:user_career_home/home/controllers/filter_controller.dart';
import 'package:user_career_home/home/controllers/home_controller.dart';
import 'package:user_career_home/home/pages/views/expansion_tile_category_view.dart';

@RoutePage()
class FilterPage extends ConsumerStatefulWidget {
  const FilterPage({super.key});

  @override
  ConsumerState createState() => _FilterPageState();
}

class _FilterPageState extends ConsumerState<FilterPage> {
  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(filterControllerProvider);
    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      onRefresh: () async {
        ref.invalidate(filterControllerProvider);
      },
      customAppBar: CommonAppBar(
        titleSpacing: 0.0,
        titleText: "Danh mục",
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.black1Color),
          color: AppColors.black1Color,
          onPressed: () {
            context.router.maybePop();
          },
        ),
      ),
      bottomView: filterState.maybeWhen(
          skipLoadingOnRefresh: false,
          orElse: () => const SizedBox(),
          data: (data) {
            return _buildButtonApply();
          }),
      body: filterState.maybeWhen(
        skipLoadingOnRefresh: false,
        orElse: () => const SizedBox(),
        data: (data) {
          return const ExpansionTileCategoryView();
        },
        loading: () {
          return SizedBox(
            height: context.height * 0.8,
            child: Transform.scale(
              scale: 2,
              child: Assets.jsons.wormLoading.lottie(
                  height: 60,
                  width: 60,
                  repeat: true,
                  frameRate: const FrameRate(120)),
            ),
          ).center();
        },
      ),
    );
  }

  Widget _buildButtonApply() {
    final homeController = ref.watch(homeControllerProvider.notifier);
    final filterState = ref.watch(filterControllerProvider);
    return Container(
      color: AppColors.white1Color,
      child: AppButton(
        isEnabled: true,
        title: L.more.bottomSheetCalanderButtonApply,
        onPressed: () {
          homeController.setCategoryId(filterState.value?.categoryId);
          NotificationCenter().postNotification(
              RawStringNotificationName("reloadListExpectView"));
          context.router.maybePop();
        },
      ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
    );
  }
}
