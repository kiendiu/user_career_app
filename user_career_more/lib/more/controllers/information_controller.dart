import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/more/models/requests/information_request.dart';
import 'package:user_career_more/more/models/requests/information_request.dart';
import 'package:user_career_more/more/models/requests/upload_media_request.dart';
import 'package:user_career_more/more/models/states/information_controller_state.dart';
import 'package:user_career_more/more/models/upload_media_response.dart';
import 'package:user_career_more/more/repositories/more_repository.dart';

class InformationController
    extends AutoDisposeNotifier<InformationControllerState> with AlertMixin {
  @override
  InformationControllerState build() {
    final informationRequest = InformationRequest(
      email: Storage.get(POSStorageKey.infoEmailKey),
      username: Storage.get(POSStorageKey.infoUserNameKey),
      avatar: Storage.get(POSStorageKey.infoAvatarPath),
    );

    return InformationControllerState(
      informationRequest: informationRequest,
      noDeleteAvatar: true,
    );
  }

  Future<bool> updateInfo() async {
    showLoading();
    final updateResult = await ref
        .read(moreRepositoryProvider)
        .updateInformation(state.informationRequest)
        .showErrorBy(this)
        .hideLoadingBy(this)
        .showSuccessBy(this, message: "Cập nhật thành công")
        .isSuccess();
    return updateResult;
  }

  Future<void> uploadFile(AppFile? avatar) async {
    showLoading();
    final result = await ref
        .read(moreRepositoryProvider)
        .uploadMedia(UploadMediaRequest()..fileName = avatar?.fileName ?? "")
        .showErrorBy(this)
        .onSuccess((value) async {
      await ref
          .read(moreRepositoryProvider)
          .uploadFileS3(value.preSignedUrl ?? "", avatar?.file ?? File(""))
          .showErrorBy(this)
          .hideLoadingBy(this)
          .isSuccess();
    })
        .mapToValueOr(defaultValue: UploadMediaResponse())
        .asFuture();

    state = state.copyWith(
        uploadMediaResponse: result,
        informationRequest:
        state.informationRequest.copyWith(avatar: result.fullPath));
  }

  void setName(String name) {
    state = state.copyWith(
        informationRequest:
        state.informationRequest.copyWith(username: name));
  }

  void setEmail(String email) {
    state = state.copyWith(
        informationRequest:
        state.informationRequest.copyWith(email: email));
  }

  void setPhone(String phone) {
    state = state.copyWith(
        informationRequest:
        state.informationRequest.copyWith(phone: phone));
  }
  void setAddress(String address) {
    state = state.copyWith(
        informationRequest:
        state.informationRequest.copyWith(address: address));
  }

  void setAvatar(
      {String? avatarPath, bool? noDeleteAvatar, AppFile? newAvatar}) {
    state = state.copyWith(
        noDeleteAvatar: noDeleteAvatar,
        newAvatar: newAvatar,
        informationRequest:
        state.informationRequest.copyWith(avatar: avatarPath));
  }

  void updateAvatar(AppFile? avatar) async {
    state = state.copyWith(newAvatar: avatar);
  }
}

final informationControllerProvider = NotifierProvider.autoDispose<
    InformationController, InformationControllerState>(() {
  return InformationController();
});
