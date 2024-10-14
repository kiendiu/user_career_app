import 'filter_response.dart';

class FilterControllerState {
  int? categoryId;
  String? categoryName;
  int? levelSubCategory;
  List<FilterResponse>? filterableCategory;

  FilterControllerState({
    this.categoryId,
    this.categoryName,
    this.levelSubCategory,
    this.filterableCategory
  });

  FilterControllerState copyWith({
    int? categoryId,
    String? categoryName,
    int? levelSubCategory,
    List<FilterResponse>? filterableCategory
  }) {
    return FilterControllerState(
        categoryId: categoryId ?? this.categoryId,
        categoryName: categoryName ?? this.categoryName,
        levelSubCategory: levelSubCategory ?? this.levelSubCategory,
        filterableCategory: filterableCategory ?? this.filterableCategory
    );
  }
}
