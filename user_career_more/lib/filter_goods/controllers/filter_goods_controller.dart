import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/filter_goods/models/filter_goods_controller_state.dart';
import 'package:user_career_more/filter_goods/models/filter_goods_response.dart';
import 'package:user_career_more/filter_goods/repositories/filter_goods_repository.dart';

class FilterGoodsController
    extends AutoDisposeAsyncNotifier<FilterGoodsControllerState>
    with AlertMixin, MetadataUpdater {
  @override
  FutureOr<FilterGoodsControllerState> build() async {
    final result = await getProductCategories();
    return FilterGoodsControllerState(
        filterableGood: result,
        categoryId: 0,
    );
  }

  Future<List<FilterGoodsResponse>> getProductCategories() async {
    try {
      final result = await ref
          .read(filterGoodsRepositoryProvider)
          .getFilterGoods()
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result;
    } catch (e) {
      return [];
    }
  }

  List<FilterGoodsResponse> getSubCategories(int? parentId) {
    return state.value?.filterableGood
            ?.where((category) => category.parentId == parentId)
            .toList() ??
        [];
  }

  List<FilterGoodsResponse> getCategories() {
    return state.value?.filterableGood
            ?.where((category) => category.parentId == null)
            .toList() ??
        [];
  }

  bool isSubCategory(int? subCategoryId) {
    return state.value?.filterableGood
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

final filterGoodsControllerProvider = AsyncNotifierProvider.autoDispose<
    FilterGoodsController, FilterGoodsControllerState>(() {
  return FilterGoodsController();
});
