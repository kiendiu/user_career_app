import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';

class MineControllerState {
  StatusEnum? selected;

  MineControllerState({
    this.selected
  });

  MineControllerState copyWith({
    StatusEnum? selected,
  }){
    return MineControllerState(
        selected: selected ?? this.selected
    );
  }
}

enum StatusEnum{
  open,
  closed;

  String get localizedValue => switch (this) {
    StatusEnum.open => "Đang diễn ra",
    StatusEnum.closed => "Đã kết thúc",
  };

  String get rawValue => switch (this) {
    StatusEnum.open => "open",
    StatusEnum.closed => "closed",
  };
}

class MineParams extends BaseParams{
  int? page;
  int? size;
  int? excludeUserId;
  String? status;

  MineParams(
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