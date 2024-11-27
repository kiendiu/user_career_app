import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/Register/models/register_request.dart';
import 'package:user_career_auth/Register/repositories/register_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class RegisterController extends AutoDisposeNotifier<RegisterRequest>
    with AlertMixin {
  @override
  RegisterRequest build() {
    return RegisterRequest();
  }

  Future<bool> signInId() {
    showLoading();
    return ref
        .read(registerRepositoryProvider)
        .register(state)
        .hideLoadingBy(this)
        .showErrorBy(this)
        .isSuccess();
  }

  void updateUsername(String username) {
    state = state.copyWith(username: username);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updatePhone(String phone) {
    state = state.copyWith(phone: phone);
  }
}

final registerControllerProvider =
    NotifierProvider.autoDispose<RegisterController, RegisterRequest>(() {
  return RegisterController();
});
