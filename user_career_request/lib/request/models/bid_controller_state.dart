import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';

import 'mine_controller_state.dart';

class BidControllerState {
  StatusEnum? selected;

  BidControllerState({
    this.selected
  });

  BidControllerState copyWith({
    StatusEnum? selected,
  }){
    return BidControllerState(
        selected: selected ?? this.selected
    );
  }
}

class BidParams extends BaseParams{
  int? page;
  int? size;
  int? excludeUserId;
  String? status;

  BidParams(
      {
        this.page,
        this.status
      }
      ): size = 10 , excludeUserId = Storage.get(POSStorageKey.userId);

  @override
  Map<String, dynamic> buildParams() {
    return super.buildParams()
      ..addAll({
        "page": page,
        "size": size,
        "status": status,
        "exclude_user_id": excludeUserId
      });
  }
}