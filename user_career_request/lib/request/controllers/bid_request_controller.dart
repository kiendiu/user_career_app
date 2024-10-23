import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/request/models/Bid_controller_state.dart';
import 'package:user_career_request/request/models/bid_request.dart';
import 'package:user_career_request/request/repositories/request_repository.dart';

class BidRequestController extends AutoDisposeNotifier<BidRequest>
    with AlertMixin, MetadataUpdater {
  @override
  BidRequest build() {
    return BidRequest();
  }

  Future<bool> addBidRequest() async {
    final result = await ref
        .read(requestRepositoryProvider)
        .addBidRequest(state)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  void setRequestId(int requestId){
    state = state.copyWith(requestId: requestId);
  }

  void setPrice(int price){
    state = state.copyWith(price: price);
  }

  void setDescription(String description){
    state = state.copyWith(description: description);
  }

  void setChangeReason(String changeReason){
    state = state.copyWith(changeReason: changeReason);
  }
}

final bidRequestControllerProvider = NotifierProvider.autoDispose<BidRequestController, BidRequest>(() {
  return BidRequestController();
});