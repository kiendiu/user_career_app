import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/expect_skills/models/filter_categories_controller_state.dart';
import 'package:user_career_more/expect_skills/models/filter_categories_response.dart';
import 'package:user_career_more/expect_skills/repositories/filter_categories_repository.dart';

class FilterCategoriesController
    extends AutoDisposeAsyncNotifier<FilterCategoriesControllerState>
    with AlertMixin, MetadataUpdater {
  @override
  FutureOr<FilterCategoriesControllerState> build() async {
    final result = await getProductCategories();
    return FilterCategoriesControllerState(
        filterableCategory: result,
        categoryId: 0,
    );
  }

  Future<List<FilterCategoriesResponse>> getProductCategories() async {
    try {
      final result = await ref
          .read(filterCategoriesRepositoryProvider)
          .getFilterGoods()
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result;
    } catch (e) {
      return [];
    }
  }

  List<FilterCategoriesResponse> getSubCategories(int? parentId) {
    return state.value?.filterableCategory
            ?.where((category) => category.parentId == parentId)
            .toList() ??
        [];
  }

  List<FilterCategoriesResponse> getCategories() {
    return state.value?.filterableCategory
            ?.where((category) => category.parentId == null)
            .toList() ??
        [];
  }

  bool isSubCategory(int? subCategoryId) {
    return state.value?.filterableCategory
            ?.where((category) => category.parentId == subCategoryId)
            .toList()
            .isNotEmpty ??
        false;
  }

  bool checkedSelectedCategory(int? categoryId) {
    return state.value?.categoryId == categoryId;
  }

  void setCategory(int? categoryId, String? categoryName) {
    update((state) =>
        state.copyWith(categoryId: categoryId, categoryName: categoryName));
  }

  bool checkedLevelSubCategory(int levelSubCategory, int limitedLevel) =>
      levelSubCategory < limitedLevel;

  int nextLevel(int currentLevel) => currentLevel + 1;
}

final filterCategoriesControllerProvider = AsyncNotifierProvider.autoDispose<
    FilterCategoriesController, FilterCategoriesControllerState>(() {
  return FilterCategoriesController();
});
