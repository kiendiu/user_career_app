import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/core/repository.dart';
import 'package:user_career_auth/mail_verify_code/models/mail_verify_code_request.dart';
import 'package:user_career_auth/mail_verify_code/models/mail_verify_response.dart';
import 'package:user_career_core/user_career_core.dart';

abstract interface class IMailVerifyCodeRepository {
  ResultFuture<MailVerifyResponse> sendMailVerifyCode(MailVerifyCodeRequest request);
}

class MailVerifyCodeRepository extends AuthBaseRepository
    implements IMailVerifyCodeRepository {
  @override
  ResultFuture<MailVerifyResponse> sendMailVerifyCode(MailVerifyCodeRequest request) {
    return make
        .request(
            path: "/oauth/verify-code",
            decoder: MailVerifyResponse(),
            body: request.encode())
        .post();
  }
}

final mailVerifyCodeRepositoryProvider =
    Provider.autoDispose<IMailVerifyCodeRepository>((ref) {
  return MailVerifyCodeRepository();
});