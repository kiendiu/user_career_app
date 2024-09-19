import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/common/models/get_information_response.dart';
import 'package:user_career_more/more/controllers/more_controller.dart';
import 'package:user_career_more/update_information/models/update_information_request.dart';
import 'package:user_career_more/update_information/models/update_media_request.dart';
import 'package:user_career_more/update_information/models/upload_media_response.dart';
import 'package:user_career_more/update_information/repositories/update_information_repository.dart';

class UpdateInfoControllerState {
  UpdateInformationRequest updateInformationRequest;
  UploadMediaResponse? uploadMediaResponse;
  AppFile? newAvatar;
  bool noDeleteAvatar;

  UpdateInfoControllerState({
    required this.updateInformationRequest,
    this.uploadMediaResponse,
    this.newAvatar,
    required this.noDeleteAvatar
  });

  UpdateInfoControllerState copyWith({
    GetInformationResponse? getInformationResponse,
    UpdateInformationRequest? updateInformationRequest,
    UploadMediaResponse? uploadMediaResponse,
    AppFile? newAvatar,
    bool? noDeleteAvatar
  }) {
    return UpdateInfoControllerState(
      updateInformationRequest: updateInformationRequest ?? this.updateInformationRequest,
      uploadMediaResponse: uploadMediaResponse ?? this.uploadMediaResponse,
      newAvatar: newAvatar ?? this.newAvatar,
      noDeleteAvatar: noDeleteAvatar?? this.noDeleteAvatar
    );
  }
}

class UpdateInformationController
    extends AutoDisposeNotifier<UpdateInfoControllerState> with AlertMixin {
  @override
  UpdateInfoControllerState build() {
    final updateInformationRequest = UpdateInformationRequest(
      email: Storage.get(POSStorageKey.infoEmailKey),
      username: Storage.get(POSStorageKey.infoUserNameKey),
      avatar: Storage.get(POSStorageKey.infoAvatarPath),
      phone: Storage.get(POSStorageKey.infoPhoneKey),
      address: Storage.get(POSStorageKey.infoAdressKey),
    );
    return UpdateInfoControllerState(
      updateInformationRequest: updateInformationRequest,
      noDeleteAvatar: true,
    );
  }

  Future<bool> updateInfo() async {
    showLoading();
    final updateResult = await ref
        .read(updateInformationRepositoryProvider)
        .updateInformation(state.updateInformationRequest)
        .showErrorBy(this)
        .hideLoadingBy(this)
        // .showSuccessBy(this, message: "Cập nhật thành công")
        .isSuccess();
    return updateResult;
  }

  Future<void> uploadFile(AppFile? avatar) async {
    showLoading();
    final result = await ref
        .read(updateInformationRepositoryProvider)
        .updateAvatar(UploadMediaRequest()..fileName = avatar)
        .showErrorBy(this)
        .hideLoadingBy(this)
        .mapToValueOr(defaultValue: UploadMediaResponse())
        .asFuture();
    state = state.copyWith(
        uploadMediaResponse: result,
        updateInformationRequest:
        state.updateInformationRequest.copyWith(avatar: result.avatar));
    updateInfo().then((value) => {
    if (value == true)
    {
      ref.invalidate(moreControllerProvider),
    }});
  }

  void setName(String name) {
    state = state.copyWith(
        updateInformationRequest:
        state.updateInformationRequest.copyWith(username: name));
  }

  void setEmail(String email) {
    state = state.copyWith(
        updateInformationRequest:
        state.updateInformationRequest.copyWith(email: email));
  }

  void setPhone(String phone) {
    state = state.copyWith(
        updateInformationRequest:
        state.updateInformationRequest.copyWith(phone: phone));
  }
  void setAddress(String address) {
    state = state.copyWith(
        updateInformationRequest:
        state.updateInformationRequest.copyWith(address: address));
  }

  void setAvatar(
      {String? avatarPath, bool? noDeleteAvatar, AppFile? newAvatar}) {
    state = state.copyWith(
        noDeleteAvatar: noDeleteAvatar,
        newAvatar: newAvatar,
        updateInformationRequest:
        state.updateInformationRequest.copyWith(avatar: avatarPath));
  }

  void updateAvatar(AppFile? avatar) async {
    state = state.copyWith(newAvatar: avatar);
  }

  bool checkNewAvatar() => state.newAvatar != null;
}

final updateInformationControllerProvider = NotifierProvider.autoDispose<
    UpdateInformationController, UpdateInfoControllerState>(() {
  return UpdateInformationController();
});
