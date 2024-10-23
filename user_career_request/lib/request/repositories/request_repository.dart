import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/core/repository.dart';
import 'package:user_career_request/request/models/bid_model.dart';
import 'package:user_career_request/request/models/bid_request.dart';
import 'package:user_career_request/request/models/categories_response.dart';
import 'package:user_career_request/request/models/request.dart';
import 'package:user_career_request/request/models/request_model.dart';

abstract interface class IRequestRepository {
  ResultFuture<BaseListResponse<RequestModel>> getListGeneral(BaseParams params);

  ResultFuture<BaseListResponse<RequestModel>> getListMine(BaseParams params);

  ResultFuture<BaseListResponse<BidModel>> getListBid(BaseParams params);

  ResultFuture<BaseListResponse<CategoriesResponse>> getCategories();

  ResultFuture<bool> addRequest(Request request);

  ResultFuture<bool> cancelRequest(int id);

  ResultFuture<bool> addBidRequest(BidRequest request);
}

class RequestRepository extends RequestBaseRepository implements IRequestRepository {

  @override
  ResultFuture<BaseListResponse<RequestModel>> getListGeneral(BaseParams params) {
    return make.request(
      path: "/requests/getListRequestsGeneral",
      params: params,
      decoder: BaseListResponseModel.decodeBy(() => RequestModel()),
    ).get();
  }

  @override
  ResultFuture<BaseListResponse<RequestModel>> getListMine(BaseParams params) {
    return make.request(
      path: "/requests/getListRequestsMine",
      params: params,
      decoder: BaseListResponseModel.decodeBy(() => RequestModel()),
    ).get();
  }

  @override
  ResultFuture<BaseListResponse<BidModel>> getListBid(BaseParams params) {
    return make.request(
      path: "/requests/getListBids",
      params: params,
      decoder: BaseListResponseModel.decodeBy(() => BidModel()),
    ).get();
  }
  @override
  ResultFuture<BaseListResponse<CategoriesResponse>> getCategories() {
    return make
        .request(
      path: "/expects/categories",
      decoder: BaseListResponseModel.decodeBy(() => CategoriesResponse()),
    ).get();
  }

  @override
  ResultFuture<bool> addRequest(Request request) {
    return make.request(
      path: "/requests/addRequest",
      decoder: const EmptyResponse(),
      body: request.encode()
    ).post().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> cancelRequest(int id) {
    return make.request(
      path: "/requests/cancelRequest/$id",
      decoder: const EmptyResponse(),
    ).post().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> addBidRequest(BidRequest request) {
    return make.request(
      path: "/requests/addBid",
      decoder: const EmptyResponse(),
      body: request.encode()
    ).post().map(onValue: (value) => true);
  }


}

final requestRepositoryProvider = Provider.autoDispose<IRequestRepository>((ref) {
  return RequestRepository();
});