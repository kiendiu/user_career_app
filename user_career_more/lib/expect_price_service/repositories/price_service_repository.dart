import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/expect_price_service/models/add_service_user_request.dart';
import 'package:user_career_more/expect_price_service/models/service_user_request.dart';
import 'package:user_career_more/expect_price_service/models/service_user_response.dart';
import 'package:user_career_more/expect_price_service/models/skill_response.dart';

abstract interface class IPriceServiceRepository {
  ResultFuture<ServiceUserResponse> getServiceGeneral();

  ResultFuture<bool> addServiceGeneral(AddServiceUserRequest serviceUser);

  ResultFuture<bool> updateServiceGeneral(ServiceUserRequest serviceUser);

  ResultFuture<BaseListResponse<SkillResponse>> getListSkill(BaseParams params);


}

class PriceServiceRepository extends MoreBaseRepository implements IPriceServiceRepository {
  @override
  ResultFuture<bool> addServiceGeneral(AddServiceUserRequest serviceUser) {
    return make.request(
        path: "/book/service_general",
        decoder: const EmptyResponse(),
        body: serviceUser.encode(),
    ).post().map(onValue: (value) => true);
  }

  @override
  ResultFuture<ServiceUserResponse> getServiceGeneral() {
    return make.request(
      path: '/book/service_general',
      decoder: ServiceUserResponse(),
    ).get();
  }

  @override
  ResultFuture<bool> updateServiceGeneral(ServiceUserRequest serviceUser) {
    return make.request(
      path: '/book/service_general',
      body: serviceUser.encode(),
      decoder: const EmptyResponse()
    ).put().map(onValue: (value) => true);
  }

  @override
  ResultFuture<BaseListResponse<SkillResponse>> getListSkill(BaseParams params) {
    return make.request(
      path: '/book/skills',
      params: params,
      decoder: BaseListResponseModel.decodeBy(() => SkillResponse()),
    ).get();
  }


}

final priceServiceRepositoryProvider = Provider.autoDispose<IPriceServiceRepository>((ref) {
  return PriceServiceRepository();
});