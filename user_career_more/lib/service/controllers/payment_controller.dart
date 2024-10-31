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

  Future<void> createPayment(PaymentRequest request, Function() onSuccess, Function() onRemind) async {
    final result = await ref
        .read(serviceRepositoryProvider)
        .createPayment(request)
        .hideLoadingBy(this)
        .asFuture();
    switch(result){
      case Success():
        onSuccess();
        break;
      case Failure(error: final error):
        if(error.errorCode == 400){
          onRemind();
        }else{
          showError(error);
        }
        break;
    }
  }

  void updateState(PaymentRequest request) {
    state = request;
  }
}

final paymentControllerProvider = NotifierProvider.autoDispose<PaymentController, PaymentRequest>(() {
  return PaymentController();
});