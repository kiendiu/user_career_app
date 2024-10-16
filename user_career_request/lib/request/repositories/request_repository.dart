import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/core/repository.dart';
import 'package:user_career_request/request/models/bid_model.dart';
import 'package:user_career_request/request/models/request_model.dart';

abstract interface class IRequestRepository {
  ResultFuture<BaseListResponse<RequestModel>> getListGeneral(BaseParams params);

  ResultFuture<BaseListResponse<RequestModel>> getListMine(BaseParams params);

  ResultFuture<BaseListResponse<BidModel>> getListBid(BaseParams params);
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


}

final requestRepositoryProvider = Provider.autoDispose<IRequestRepository>((ref) {
  return RequestRepository();
});