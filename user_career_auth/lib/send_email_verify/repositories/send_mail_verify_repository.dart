import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/core/repository.dart';
import 'package:user_career_auth/send_email_verify/models/send_mail_verify_request.dart';
import 'package:user_career_core/user_career_core.dart';

abstract interface class ISendMailVerifyRepository {
  ResultFuture<bool> sendMailVerify(SendMailVerifyRequest request);
}

class ResetPasswordRepository extends AuthBaseRepository
    implements ISendMailVerifyRepository {
  @override
  ResultFuture<bool> sendMailVerify(SendMailVerifyRequest request) {
    return make
        .request(
            path: "/oauth/send-mail-verify-code",
            decoder: const EmptyResponse(),
            body: request.encode())
        .post()
        .map(onValue: (value) => true);
  }
}

final sendMailVerifyRepositoryProvider =
    Provider.autoDispose<ISendMailVerifyRepository>((ref) {
  return ResetPasswordRepository();
});