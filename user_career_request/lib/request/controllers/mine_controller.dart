import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/request/controllers/bid_item_controller.dart';
import 'package:user_career_request/request/models/mine_controller_state.dart';
import 'package:user_career_request/request/models/request_model.dart';
import 'package:user_career_request/request/repositories/request_repository.dart';

class MineController extends AutoDisposeNotifier<MineControllerState>
    with AlertMixin, MetadataUpdater {
  @override
  MineControllerState build() {
    return MineControllerState();
  }

  Future<List<RequestModel>> getListMine(int page) async {
    try {
      final result = await ref
          .read(requestRepositoryProvider)
          .getListMine(MineParams(
          page: page + 1,
          status: state.selected?.rawValue
      ))
          .showErrorBy(this)
          .updateMetadataBy(this)
          .map(onValue: (value) => value?.items ?? [])
          .mapToValueOr(defaultValue: []).asFuture();
      for(var item in result){
        for(var bid in item.expectBids ?? []){
          ref.read(bidItemControllerProvider(bid.status).notifier).state = bid;
        }
      }
      return result;
    } catch (e) {
      return [];
    }
  }

  void setSelected(StatusEnum status){
    state = state.copyWith(selected: status);
  }
}

final mineControllerProvider = NotifierProvider.autoDispose<MineController, MineControllerState>(() {
  return MineController();
});