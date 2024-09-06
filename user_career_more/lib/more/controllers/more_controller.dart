import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/more/models/get_information_response.dart';
import 'package:user_career_more/more/repositories/more_repository.dart';

import 'information_controller.dart';

class MoreController
    extends AutoDisposeAsyncNotifier<GetInformationResponse> with AlertMixin {
  @override
  Future<GetInformationResponse> build() {
    return getUserInfo();
  }

  Future<GetInformationResponse> getUserInfo() async {
    final result = await ref
        .read(moreRepositoryProvider)
        .getUserInfo()
        .showErrorBy(this)
        .onSuccess((value) => Storage.save(POSStorageKey.idKey, value.id))
        .mapToValueOr(defaultValue: GetInformationResponse())
        .asFuture();
    Storage.save(POSStorageKey.infoUserNameKey, result.username);
    Storage.save(POSStorageKey.infoEmailKey, result.email);
    Storage.save(POSStorageKey.infoAvatarPath, result.avatar);
    ref.invalidate(informationControllerProvider);
    return result;
  }

}

final moreControllerProvider = AsyncNotifierProvider.autoDispose<
    MoreController, GetInformationResponse>(() {
  return MoreController();
});
