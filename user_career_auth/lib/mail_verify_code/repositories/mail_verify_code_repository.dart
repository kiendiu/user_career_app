import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/core/repository.dart';
import 'package:user_career_auth/mail_verify_code/models/mail_verify_code_request.dart';
import 'package:user_career_core/user_career_core.dart';

abstract interface class IMailVerifyCodeRepository {
  ResultFuture<bool> sendMailVerifyCode(MailVerifyCodeRequest request);
}

class MailVerifyCodeRepository extends AuthBaseRepository
    implements IMailVerifyCodeRepository {
  @override
  ResultFuture<bool> sendMailVerifyCode(MailVerifyCodeRequest request) {
    return make
        .request(
            path: "/otp/verifyOtp",
            decoder: const EmptyResponse(),
            body: request.encode())
        .post().map(onValue: (value) => true);
  }
}

final mailVerifyCodeRepositoryProvider =
    Provider.autoDispose<IMailVerifyCodeRepository>((ref) {
  return MailVerifyCodeRepository();
});