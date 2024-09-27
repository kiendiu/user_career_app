import 'filter_categories_response.dart';

class FilterCategoriesControllerState {
  int? categoryId;
  String? categoryName;
  int? levelSubCategory;
  List<FilterCategoriesResponse>? filterableCategory;

  FilterCategoriesControllerState({
    this.categoryId,
    this.categoryName,
    this.levelSubCategory,
    this.filterableCategory
  });

  FilterCategoriesControllerState copyWith({
    int? categoryId,
    String? categoryName,
    int? levelSubCategory,
    List<FilterCategoriesResponse>? filterableCategory
  }) {
    return FilterCategoriesControllerState(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      levelSubCategory: levelSubCategory ?? this.levelSubCategory,
      filterableCategory: filterableCategory ?? this.filterableCategory
    );
  }
}
