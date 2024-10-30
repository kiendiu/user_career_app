import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/service/models/payment_request.dart';
import 'package:user_career_more/service/repositories/service_repository.dart';

class PaymentController extends AutoDisposeNotifier<PaymentRequest>
  with AlertMixin, MetadataUpdater{
  @override
  PaymentRequest build() {
    return PaymentRequest();
  }

  Future<bool> createPayment(PaymentRequest request) async {
    try {
      final result = await ref
          .read(serviceRepositoryProvider)
          .createPayment(request)
          .showErrorBy(this)
          .map(onValue: (value) => value ?? false)
          .mapToValueOr(defaultValue: false).asFuture();
      return result;
    } catch (e) {
      return false;
    }
  }

  void updateState(PaymentRequest request) {
    state = request;
  }
}

final paymentControllerProvider = NotifierProvider.autoDispose<PaymentController, PaymentRequest>(() {
  return PaymentController();
});