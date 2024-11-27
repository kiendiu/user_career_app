import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/enums/approval_enum.dart';
import 'package:user_career_core/user_career_core.dart';

class ExpertController extends AutoDisposeNotifier<UserControllerState>
    with AlertMixin, MetadataUpdater{
  @override
  UserControllerState build() {
    return UserControllerState(
      approval: ApprovalEnum.user
    );
  }

  void setApproval(ApprovalEnum? approval){
    state = state.copyWith(approval: approval);
  }
}

final expertControllerProvider = NotifierProvider.autoDispose<ExpertController, UserControllerState>(() {
  return ExpertController();
});

class UserControllerState{
  ApprovalEnum? approval;

  UserControllerState({
    this.approval
  });

  UserControllerState copyWith({
    ApprovalEnum? approval
  }){
    return UserControllerState(
      approval: approval ?? this.approval
    );
  }
}

class UserParams extends BaseParams{
  int? page;
  int? size;
  String? approval;

  UserParams({
    this.page,
    this.approval,
  }): size = 10;

  @override
  Map<String, dynamic> buildParams() {
    return super.buildParams()
      ..addAll({
        "page": page,
        "size": size,
        "approval": approval,
      });
  }
}