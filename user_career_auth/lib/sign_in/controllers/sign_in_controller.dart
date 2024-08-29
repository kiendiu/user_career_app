import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/sign_in/models/sign_in_request.dart';
import 'package:user_career_auth/sign_in/repositories/sign_in_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class SignInController extends AutoDisposeNotifier<SignInRequest>
    with AlertMixin {
  @override
  SignInRequest build() {
    return SignInRequest();
  }

  Future<bool> signIn() {
    if (!state.canLogin) {
      return Future.value(false);
    }
    showLoading();
    return ref
        .read(signInRepositoryProvider)
        .signIn(state)
        .showErrorBy(this)
        .onSuccess((value) async {
      AuthManager.saveJWTToken(value.accessToken, value.refreshToken);
      // var user = await ref
      //     .read(userRepositoryProvider)
      //     .getUserInfo()
      //     .mapToValue()
      //     .asFuture();
      //
      // if (user != null) {
      //   Storage.save(POSStorageKey.userId, user.id);
      // }
    })
        .hideLoadingBy(this)
        .isSuccess();
  }

  void updateUserName(String username) {
    state = state.copyWith(username: username);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  // void onTapComeBack() {
  //   Storage.clean();
  //   ref.invalidate(signInIdControllerProvider);
  // }
}

final signInControllerProvider =
NotifierProvider.autoDispose<SignInController, SignInRequest>(() {
  return SignInController();
});