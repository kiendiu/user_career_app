import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/filter_goods/controllers/filter_goods_controller.dart';
import 'package:user_career_more/filter_goods/models/filter_goods_response.dart';

import 'custom_expansion_tile.dart';

class ExpansionTileCategory extends ConsumerStatefulWidget {
  const ExpansionTileCategory({super.key});

  @override
  ConsumerState<ExpansionTileCategory> createState() =>
      _ExpansionTileCategoryState();
}

class _ExpansionTileCategoryState extends ConsumerState<ExpansionTileCategory> {
  final optionAllCategoriesId = 0;

  @override
  Widget build(BuildContext context) {
    final filterGoodsController =
        ref.watch(filterGoodsControllerProvider.notifier);
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
                .watch(filterGoodsControllerProvider.notifier)
                .checkedSelectedCategory(optionAllCategoriesId)
            ? true
            : false,
        24,
      ),
      leading: const SizedBox.shrink(),
      onExpansionChanged: (value) {
        ref
            .read(filterGoodsControllerProvider.notifier)
            .setCategory(optionAllCategoriesId, "Tất cả");
      },
    ).makeColor(AppColors.white1Color);
  }

  Widget _buildCategory(FilterGoodsResponse category,
      {double leftPadding = 24, int currentLevel = 1}) {
    final filterGoodsController =
        ref.watch(filterGoodsControllerProvider.notifier);
    ref.watch(filterGoodsControllerProvider);
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
                child: CustomExpansionTile(
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

  Widget _buildNonSubCategory(FilterGoodsResponse category, int currentLevel) {
    final filterGoodsController =
        ref.read(filterGoodsControllerProvider.notifier);
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
                  .read(filterGoodsControllerProvider.notifier)
                  .checkedLevelSubCategory(currentLevel, 2)
              ? 24
              : 0),
    ).makeColor(AppColors.white1Color);
  }
}
