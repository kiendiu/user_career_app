import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_appbar.dart';
import 'package:user_career_more/filter_goods/controllers/filter_goods_controller.dart';
import 'package:user_career_more/filter_goods/pages/views/expansion_tile_category.dart';

@RoutePage()
class FilterGoodsPage extends ConsumerStatefulWidget {
  const FilterGoodsPage({super.key});

  @override
  ConsumerState<FilterGoodsPage> createState() => _FilterGoodsPageState();
}

class _FilterGoodsPageState extends ConsumerState<FilterGoodsPage> {
  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(filterGoodsControllerProvider);
    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      onRefresh: () async {
        ref.invalidate(filterGoodsControllerProvider);
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
          return const ExpansionTileCategory();
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
    // final goodsController = ref.watch(goodsControllerProvider.notifier);
    // final filterState = ref.watch(filterGoodsControllerProvider);
    return Container(
      color: AppColors.white1Color,
      child: AppButton(
        isEnabled: true,
        title: L.more.bottomSheetCalanderButtonApply,
        onPressed: () {
          // goodsController.updateCategory(
          //     filterState.value?.parentId, filterState.value?.categoryName);
          context.router.maybePop();
        },
      ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
    );
  }
}
