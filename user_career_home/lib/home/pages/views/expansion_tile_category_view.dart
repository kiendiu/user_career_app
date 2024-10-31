import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/home/controllers/filter_controller.dart';
import 'package:user_career_home/home/models/filter_response.dart';
import 'package:user_career_home/home/pages/views/CustomExpansionTileView.dart';

class ExpansionTileCategoryView extends ConsumerStatefulWidget {
  const ExpansionTileCategoryView({super.key});

  @override
  ConsumerState<ExpansionTileCategoryView> createState() =>
      _ExpansionTileCategoryViewState();
}

class _ExpansionTileCategoryViewState extends ConsumerState<ExpansionTileCategoryView> {
  final optionAllCategoriesId = 0;

  @override
  Widget build(BuildContext context) {
    final filterGoodsController =
    ref.watch(filterControllerProvider.notifier);
    return Column(
      children: [
        _buildSelectedAll(),
        ...filterGoodsController
            .getCategories()
            .map((category) => _buildCategory(category)),
      ],
    );
  }

  Widget _buildSelectedAll() {
    return ExpansionTile(
      title: Text("Tất cả",
          style: ref.theme.mediumTextStyle
              .weight(FontWeight.w600)
              .textColor(AppColors.black1Color)),
      shape: const Border(
        top: BorderSide(color: Colors.transparent),
        bottom: BorderSide(color: Colors.transparent),
      ),
      trailing: _buildRadioButton(
        ref
            .watch(filterControllerProvider.notifier)
            .checkedSelectedCategory(optionAllCategoriesId)
            ? true
            : false,
        24,
      ),
      leading: const SizedBox.shrink(),
      onExpansionChanged: (value) {
        ref
            .read(filterControllerProvider.notifier)
            .setCategory(0, "Tất cả");
      },
    ).makeColor(AppColors.white1Color);
  }

  Widget _buildCategory(FilterResponse category,
      {double leftPadding = 24, int currentLevel = 1}) {
    final filterGoodsController =
    ref.watch(filterControllerProvider.notifier);
    ref.watch(filterControllerProvider);
    List<Widget> buildSubCategories(int? parentId, int level) {
      return filterGoodsController
          .getSubCategories(parentId)
          .asMap()
          .entries
          .map((subCategory) => _buildCategory(subCategory.value,
          leftPadding: leftPadding, currentLevel: level))
          .toList();
    }

    return filterGoodsController.isSubCategory(category.categoryId) &&
        filterGoodsController.checkedLevelSubCategory(currentLevel, 3)
        ? Column(
      children: [
        _builtBottomLine(currentLevel),
        Container(
          child: CustomExpansionTileView(
            childrenPadding: EdgeInsets.only(
                left: filterGoodsController.checkedLevelSubCategory(
                    currentLevel, 2)
                    ? leftPadding
                    : 0),
            title: Text(
              category.nameCategory ?? "",
              style: ref.theme.mediumTextStyle
                  .weight(FontWeight.w600)
                  .textColor(AppColors.black1Color),
            ),
            shape: const Border(
              top: BorderSide(color: Colors.transparent),
              bottom: BorderSide(color: Colors.transparent),
            ),
            trailing: _buildRadioButton(
              filterGoodsController.checkedSelectedCategory(category.categoryId)
                  ? true
                  : false,
              24,
            ),
            children: buildSubCategories(category.categoryId,
                filterGoodsController.nextLevel(currentLevel)),
            onExpansionChanged: (value) {
              filterGoodsController.setCategory(category.categoryId, category.nameCategory);
            },
          ).makeColor(AppColors.white1Color),
        ),
      ],
    )
        : _buildNonSubCategory(category, currentLevel);
  }

  Widget _buildNonSubCategory(FilterResponse category, int currentLevel) {
    final filterGoodsController =
    ref.read(filterControllerProvider.notifier);
    return Column(
      children: [
        _builtBottomLine(currentLevel),
        ExpansionTile(
          title: Text(category.nameCategory ?? "",
              style: filterGoodsController.checkedLevelSubCategory(
                  currentLevel, 3)
                  ? ref.theme.mediumTextStyle
                  .weight(FontWeight.w600)
                  .textColor(AppColors.black1Color)
                  : ref.theme.mediumTextStyle.textColor(AppColors.black1Color)),
          leading: const SizedBox.shrink(),
          shape: const Border(
            top: BorderSide(color: Colors.transparent),
            bottom: BorderSide(color: Colors.transparent),
          ),
          trailing: _buildRadioButton(
            filterGoodsController.checkedSelectedCategory(category.categoryId)
                ? true
                : false,
            24,
          ),
          onExpansionChanged: (value) {
            filterGoodsController.setCategory(category.categoryId, category.nameCategory);
          },
        ).makeColor(AppColors.white1Color),
      ],
    );
  }

  Widget _buildRadioButton(bool isSelected, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? ref.theme.mainColor : const Color(0xffD8D8D8),
          width: 2,
        ),
      ),
      child: isSelected
          ? Container(
        width: size - 12,
        height: size - 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ref.theme.mainColor,
        ),
      ).center()
          : null,
    );
  }

  Widget _builtBottomLine(int currentLevel) {
    return SizedBox(
      width: double.infinity,
      child: const SizedBox(
        height: 1,
      ).makeColor(AppColors.white3Color).marginOnly(
          right: 24,
          left: ref
              .read(filterControllerProvider.notifier)
              .checkedLevelSubCategory(currentLevel, 2)
              ? 24
              : 0),
    ).makeColor(AppColors.white1Color);
  }
}
