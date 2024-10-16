import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/request/models/Bid_controller_state.dart';
import 'package:user_career_request/request/models/bid_model.dart';
import 'package:user_career_request/request/models/mine_controller_state.dart';
import 'package:user_career_request/request/repositories/request_repository.dart';

class BidController extends AutoDisposeNotifier<BidControllerState>
    with AlertMixin, MetadataUpdater {
  @override
  BidControllerState build() {
    return BidControllerState();
  }

  Future<List<BidModel>> getListBid(int page) async {
    try {
      final result = await ref
          .read(requestRepositoryProvider)
          .getListBid(BidParams(
          page: page + 1,
          status: state.selected?.rawValue
      ))
          .showErrorBy(this)
          .updateMetadataBy(this)
          .map(onValue: (value) => value?.items ?? [])
          .mapToValueOr(defaultValue: []).asFuture();
      return result;
    } catch (e) {
      return [];
    }
  }

  void setSelected(StatusEnum status){
    state = state.copyWith(selected: status);
  }
}

final bidControllerProvider = NotifierProvider.autoDispose<BidController, BidControllerState>(() {
  return BidController();
});