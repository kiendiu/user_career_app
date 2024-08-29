import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_career_auth/send_email_verify/models/send_mail_verify_request.dart';
import 'package:user_career_auth/send_email_verify/repositories/send_mail_verify_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class SendMailVerifyController
    extends AutoDisposeNotifier<SendMailVerifyRequest> with AlertMixin {
  @override
  SendMailVerifyRequest build() {
    return SendMailVerifyRequest();
  }

  Future<bool> sendMail() {
    showLoading();
    return ref
        .read(sendMailVerifyRepositoryProvider)
        .sendMailVerify(state)
        .hideLoadingBy(this)
        .showErrorBy(this)
        .showSuccessBy(this, message: L.auth.sendMailVerifySuccessfulText)
        .isSuccess();
  }

  void updateEmail(String email) {
    state = SendMailVerifyRequest()..email = email;
  }
}

final sendMailVerifyControllerProvider = NotifierProvider.autoDispose<
    SendMailVerifyController, SendMailVerifyRequest>(() {
      return SendMailVerifyController();
    });
