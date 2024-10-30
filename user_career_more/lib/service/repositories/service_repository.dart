import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/service/models/payment_request.dart';
import 'package:user_career_more/service/models/review_request.dart';
import 'package:user_career_more/service/models/service_model.dart';

abstract interface class IServiceRepository{
  ResultFuture<ListServiceData<ServiceModel>> getListServices(BaseParams params);

  ResultFuture<bool> updateStatusService(int id, String status);

  ResultFuture<bool> addReview(int id, ReviewRequest reviewRequest);

  ResultFuture<bool> createPayment(PaymentRequest request);
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

  @override
  ResultFuture<bool> addReview(int id, ReviewRequest reviewRequest) {
    return make.request(
      path: "/manages/booked_services/$id",
      body: reviewRequest.encode(),
      decoder: const EmptyResponse(),
    ).post().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> createPayment(PaymentRequest request) {
    return make.request(
      path: "/requests/paymentNoUpdateStatusBooking",
      body: request.encode(),
      decoder: const EmptyResponse(),
    ).post().map(
      onValue: (value) {
        return true;
      },
    );
  }
}

final serviceRepositoryProvider = Provider.autoDispose<IServiceRepository>((ref) {
  return ServiceRepository();
});