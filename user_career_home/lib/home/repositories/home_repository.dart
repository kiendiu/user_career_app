import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/core/repository.dart';
import 'package:user_career_home/home/models/expect_detail_response.dart';
import 'package:user_career_home/home/models/expect_response.dart';
import 'package:user_career_home/home/models/filter_response.dart';

abstract interface class IHomeRepository {
  ResultFuture<BaseListResponse<ExpectResponse>> getListExpects(BaseParams params);

  ResultFuture<BaseListResponse<FilterResponse>> getFilterCategories();

  ResultFuture<ExpectDetailResponse> getDetailExpect(int id);
}

class HomeRepository extends HomeBaseRepository implements IHomeRepository {

  @override
  ResultFuture<BaseListResponse<ExpectResponse>> getListExpects(BaseParams params) {
    return make
        .request(path: "/expects/getListExperts",
        params: params,
        decoder: BaseListResponseModel.decodeBy(() => ExpectResponse())
    ).get();
  }

  @override
  ResultFuture<BaseListResponse<FilterResponse>> getFilterCategories() {
    return make
        .request(
      path: "/expects/categories",
      decoder: BaseListResponseModel.decodeBy(() => FilterResponse()),
    ).get();
  }

  @override
  ResultFuture<ExpectDetailResponse> getDetailExpect(int id) {
    return make.request(
      path: "/expects/getExpertInfo/$id",
      decoder: ExpectDetailResponse(),
    ).get();
  }
}

final homeRepositoryProvider = Provider.autoDispose<IHomeRepository>((ref) {
  return HomeRepository();
});