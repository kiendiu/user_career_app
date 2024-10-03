import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/expect_skills/models/filter_categories_response.dart';

abstract interface class IFilterCategoriesRepository {
  ResultFuture<BaseListResponse<FilterCategoriesResponse>> getFilterGoods();
}

class FilterCategoriesRepository extends MoreBaseRepository implements IFilterCategoriesRepository {
  @override
  ResultFuture<BaseListResponse<FilterCategoriesResponse>> getFilterGoods() {
    return make
        .request(
      path: "/expects/categories",
      decoder: BaseListResponseModel.decodeBy(() => FilterCategoriesResponse()),
    ).get();
  }
}

final filterCategoriesRepositoryProvider = Provider.autoDispose<IFilterCategoriesRepository>((ref) {
  return FilterCategoriesRepository();
});
