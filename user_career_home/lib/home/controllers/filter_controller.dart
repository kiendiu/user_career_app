import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/home/models/filter_controller_state.dart';
import 'package:user_career_home/home/models/filter_response.dart';
import 'package:user_career_home/home/repositories/home_repository.dart';

class FilterController
    extends AutoDisposeAsyncNotifier<FilterControllerState>
    with AlertMixin, MetadataUpdater {
  @override
  FutureOr<FilterControllerState> build() async {
    final result = await getMajorCategories();
    return FilterControllerState(
      filterableCategory: result,
      categoryId: 0,
    );
  }

  Future<List<FilterResponse>> getMajorCategories() async {
    try {
      final result = await ref
          .read(homeRepositoryProvider)
          .getFilterCategories()
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result;
    } catch (e) {
      return [];
    }
  }

  List<FilterResponse> getSubCategories(int? parentId) {
    return state.value?.filterableCategory
        ?.where((category) => category.parentId == parentId)
        .toList() ??
        [];
  }

  List<FilterResponse> getCategories() {
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

final filterControllerProvider = AsyncNotifierProvider.autoDispose<
    FilterController, FilterControllerState>(() {
  return FilterController();
});
