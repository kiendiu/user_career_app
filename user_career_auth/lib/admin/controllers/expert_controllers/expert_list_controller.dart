import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_career_auth/admin/models/responses/user_response.dart';
import 'package:user_career_auth/admin/repositories/admin_repository.dart';
import 'package:user_career_core/user_career_core.dart';

import 'expert_controller.dart';

class ExpertListController extends AutoDisposeNotifier<void>
    with AlertMixin, MetadataUpdater {
  @override
  void build() {
    return;
  }


  Future<List<UserResponse>> getUser(int page) async {
    try {
      final state = ref.watch(expertControllerProvider);
      final result = await ref
          .read(adminRepositoryProvider)
          .getUser(UserParams(
          page: page + 1,
          approval: state.approval?.approvalValue
      ))
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result;
    } catch (e) {
      return [];
    }
  }
}

final expertListControllerProvider = NotifierProvider.autoDispose<
    ExpertListController, void>(
      () => ExpertListController(),
);