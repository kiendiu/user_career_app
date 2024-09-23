import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/filter_goods/models/filter_goods_response.dart';

abstract interface class IFilterGoodsRepository {
  ResultFuture<BaseListResponse<FilterGoodsResponse>> getFilterGoods();
}

class FilterGoodsRepository extends MoreBaseRepository implements IFilterGoodsRepository {
  @override
  ResultFuture<BaseListResponse<FilterGoodsResponse>> getFilterGoods() {
    return make
        .request(
      path: "expects/categories",
      decoder: BaseListResponseModel.decodeBy(() => FilterGoodsResponse()),
    ).get();
  }
}

final filterGoodsRepositoryProvider = Provider.autoDispose<IFilterGoodsRepository>((ref) {
  return FilterGoodsRepository();
});
