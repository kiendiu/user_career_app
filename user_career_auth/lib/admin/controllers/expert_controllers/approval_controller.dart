import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/enums/approval_enum.dart';
import 'package:user_career_auth/admin/models/requests/approval_request.dart';
import 'package:user_career_auth/admin/repositories/admin_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class ApprovalController extends AutoDisposeFamilyNotifier<ApprovalRequest, int>
    with AlertMixin, MetadataUpdater {
  @override
  ApprovalRequest build(int arg) {
    return ApprovalRequest(userId: arg);
  }

  Future<bool> approvalExpert() async {
    final result = await ref
        .read(adminRepositoryProvider)
        .approvalExpert(state)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  void setApproval(ApprovalEnum? approval){
    state = state.copyWith(approval: approval?.rawValue);
  }

  void setUserId(int userId){
    state = state.copyWith(userId: userId);
  }

  void setReason(String reason){
    state = state.copyWith(reason: reason);
  }

}

final approvalControllerProvider = NotifierProvider.autoDispose
    .family<ApprovalController, ApprovalRequest, int>(() {
  return ApprovalController();
});