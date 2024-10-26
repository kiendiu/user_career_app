import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/service/models/service_model.dart';

abstract interface class IServiceRepository{
  ResultFuture<ListServiceData<ServiceModel>> getListServices(BaseParams params);

  ResultFuture<bool> updateStatusService(int id, String status);
}

class ServiceRepository extends MoreBaseRepository
    implements IServiceRepository{
  @override
  ResultFuture<ListServiceData<ServiceModel>> getListServices(BaseParams params) {
    return make.request(
      path: '/manages/booked_services',
      params: params,
      decoder: ServiceData.decodeBy(() => ServiceModel()),
    ).get();
  }

  @override
  ResultFuture<bool> updateStatusService(int id, String status) {
    return make.request(
      path: "/manages//updateStatusService/$id/$status",
      decoder: const EmptyResponse(),
    ).put().map(onValue: (value) => true);
  }
}

final serviceRepositoryProvider = Provider.autoDispose<IServiceRepository>((ref) {
  return ServiceRepository();
});