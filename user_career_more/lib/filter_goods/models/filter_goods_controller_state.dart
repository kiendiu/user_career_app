import 'filter_goods_response.dart';

class FilterGoodsControllerState {
  int? categoryId;
  String? categoryName;
  int? levelSubCategory;
  List<FilterGoodsResponse>? filterableGood;

  FilterGoodsControllerState({
    this.categoryId,
    this.categoryName,
    this.levelSubCategory,
    this.filterableGood
  });

  FilterGoodsControllerState copyWith({
    int? categoryId,
    String? categoryName,
    int? levelSubCategory,
    List<FilterGoodsResponse>? filterableGood
  }) {
    return FilterGoodsControllerState(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      levelSubCategory: levelSubCategory ?? this.levelSubCategory,
      filterableGood: filterableGood ?? this.filterableGood
    );
  }
}
