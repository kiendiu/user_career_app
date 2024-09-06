import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/change_password/repositories/change_password_repository.dart';
import '../models/change_password_request.dart';

class ChangePasswordController extends AutoDisposeNotifier<ChangePasswordRequest>
    with AlertMixin {

  @override
  ChangePasswordRequest build() {
    return ChangePasswordRequest();
  }

  Future<bool> changePassword() async {
    if (state.isOldPasswordEqualToNewPassword) {
      showError(CommonError.message("Giống mật khẩu cũ"));
      if(state.isNewPasswordNotEqualToConfirmPassword){
        showError(CommonError.message("Khác mật khẩu mới"));
      }
      return Future.value(false);
    }
    showLoading();
    final isSuccess = await ref
        .read(changePasswordRepositoryProvider)
        .changePassword(state)
        .showErrorBy(this)
        .hideLoadingBy(this)
        .showSuccessBy(this, message: "Cập nhật thành công")
        .isSuccess();
    return isSuccess;
  }

  void setOldPassword(String? oldPassword){
    state =  state.copyWith(oldPassword: oldPassword);
  }

  void setNewPassword(String? newPassword){
    state = state.copyWith(newPassword: newPassword);
  }

  void setConfirmPassword(String? confirmPassword){
    state = state.copyWith(confirmPassword: confirmPassword);
  }

}

final changePasswordControllerProvider = NotifierProvider.autoDispose<ChangePasswordController, ChangePasswordRequest>(() {
  return ChangePasswordController();
});