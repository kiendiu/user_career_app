import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/common/models/get_information_response.dart';
import 'package:user_career_more/common/repositories/more_repository.dart';

import '../../update_information/controllers/update_information_controller.dart';

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
    Storage.save(POSStorageKey.infoFullNameKey, result.fullName);
    Storage.save(POSStorageKey.infoUserNameKey, result.username);
    Storage.save(POSStorageKey.infoEmailKey, result.email);
    Storage.save(POSStorageKey.infoAvatarPath, result.avatar);
    Storage.save(POSStorageKey.infoPhoneKey, result.phone);
    Storage.save(POSStorageKey.infoAddressKey, result.address);
    if (!ref
        .read(updateInformationControllerProvider.notifier)
        .checkNewAvatar()) {
      ref.invalidate(updateInformationControllerProvider);
    }
    return result;
  }

}

final moreControllerProvider = AsyncNotifierProvider.autoDispose<
    MoreController, GetInformationResponse>(() {
  return MoreController();
});
