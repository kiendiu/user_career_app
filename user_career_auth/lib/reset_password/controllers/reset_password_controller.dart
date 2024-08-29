import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/reset_password/models/reset_password_request.dart';
import 'package:user_career_auth/reset_password/repositories/reset_password_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class ResetPasswordController extends AutoDisposeNotifier<ResetPasswordRequest>
    with AlertMixin {
  @override
  ResetPasswordRequest build() {
    return ResetPasswordRequest();
  }

  Future<bool> resetPassword() {
    showLoading();
    return ref
        .read(resetPasswordRepositoryProvider)
        .resetPassword(state)
        .hideLoadingBy(this)
        .showErrorBy(this)
        .showSuccessBy(this, message: L.auth.resetPasswordSuccessfulText)
        .isSuccess();
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
  }
}

final resetPasswordControllerProvider =
    NotifierProvider.autoDispose<ResetPasswordController, ResetPasswordRequest>(
        () {
  return ResetPasswordController();
});
