import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_appbar.dart';
import 'package:user_career_more/expect_experiences/controllers/edit_experience_controller.dart';
import 'package:user_career_more/expect_experiences/controllers/filter_categories_controller.dart';
import 'package:user_career_more/expect_experiences/models/expect_experience_response.dart';
import 'package:user_career_more/expect_experiences/pages/views/expansion_tile_category.dart';

@RoutePage()
class FilterEditCategoryPage extends ConsumerStatefulWidget {
  final ExpectExperienceResponse expectExperienceResponse;
  const FilterEditCategoryPage({super.key, required this.expectExperienceResponse});

  @override
  ConsumerState<FilterEditCategoryPage> createState() => _FilterEditCategoriesPageState();
}

class _FilterEditCategoriesPageState extends ConsumerState<FilterEditCategoryPage> {
  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(filterCategoriesControllerProvider);
    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      onRefresh: () async {
        ref.invalidate(filterCategoriesControllerProvider);
      },
      customAppBar: CommonAppBar(
        titleSpacing: 0.0,
        titleText: "Danh mục",
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.black1Color),
          color: AppColors.black1Color,
          onPressed: () {
            context.maybePop();
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
    final expectExperienceController = ref.watch(editExperienceControllerProvider(widget.expectExperienceResponse).notifier);
    final filterState = ref.watch(filterCategoriesControllerProvider);
    return Container(
      color: AppColors.white1Color,
      child: AppButton(
        isEnabled: true,
        title: L.more.bottomSheetCalanderButtonApply,
        onPressed: () {
          final categoryId = filterState.value?.categoryId;
          expectExperienceController.setExpectCategory(categoryId, filterState.value?.categoryName);
          context.router.maybePop();
        },
      ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
    );
  }
}