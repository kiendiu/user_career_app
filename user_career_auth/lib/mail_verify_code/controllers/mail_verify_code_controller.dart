import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/mail_verify_code/models/mail_verify_code_request.dart';
import 'package:user_career_auth/mail_verify_code/repositories/mail_verify_code_repository.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';

class MailVerifyCodeController
    extends AutoDisposeNotifier<MailVerifyCodeRequest> with AlertMixin {
  @override
  MailVerifyCodeRequest build() {
    return MailVerifyCodeRequest();
  }

  Future<bool> sendMailVerifyCode() {
    showLoading();
    return ref
        .read(mailVerifyCodeRepositoryProvider)
        .sendMailVerifyCode(state)
        .hideLoadingBy(this)
        .showErrorBy(this)
        .showSuccessBy(this, message: L.auth.sendVerifyCodeSuccessfulText)
        .onSuccess((value) => Storage.save(POSStorageKey.idKey, value.id))
        .isSuccess();
  }

  void updateVerifyCode(String email, String verifyCode) {
    state = MailVerifyCodeRequest()
      ..email = email
      ..verifyCode = verifyCode;
  }
}

final mailVerifyCodeControllerProvider = NotifierProvider.autoDispose<
    MailVerifyCodeController, MailVerifyCodeRequest>(() {
  return MailVerifyCodeController();
});
