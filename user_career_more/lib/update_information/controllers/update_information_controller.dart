import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/update_information/models/update_information_request.dart';
import 'package:user_career_more/update_information/repositories/update_information_repository.dart';

class UpdateInfoControllerState {
  UpdateInformationRequest updateInformationRequest;

  UpdateInfoControllerState({
    required this.updateInformationRequest,
  });

  UpdateInfoControllerState copyWith({
    UpdateInformationRequest? informationRequest,
  }) {
    return UpdateInfoControllerState(
      updateInformationRequest: informationRequest ?? this.updateInformationRequest,
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
    );
  }

  Future<bool> updateInfo() async {
    showLoading();
    final updateResult = await ref
        .read(updateInformationRepositoryProvider)
        .updateInformation(state.updateInformationRequest)
        .showErrorBy(this)
        .hideLoadingBy(this)
        .showSuccessBy(this, message: "Cập nhật thành công")
        .isSuccess();
    return updateResult;
  }

  void setName(String name) {
    state = state.copyWith(
        informationRequest:
        state.updateInformationRequest.copyWith(username: name));
  }

  void setEmail(String email) {
    state = state.copyWith(
        informationRequest:
        state.updateInformationRequest.copyWith(email: email));
  }

  void setPhone(String phone) {
    state = state.copyWith(
        informationRequest:
        state.updateInformationRequest.copyWith(phone: phone));
  }
  void setAddress(String address) {
    state = state.copyWith(
        informationRequest:
        state.updateInformationRequest.copyWith(address: address));
  }
}

final updateInformationControllerProvider = NotifierProvider.autoDispose<
    UpdateInformationController, UpdateInfoControllerState>(() {
  return UpdateInformationController();
});
