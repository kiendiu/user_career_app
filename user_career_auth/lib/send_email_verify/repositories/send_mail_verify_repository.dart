import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/core/repository.dart';
import 'package:user_career_core/user_career_core.dart';

abstract interface class ISendMailVerifyRepository {
  ResultFuture<bool> sendMailVerify(String email);
}

class ResetPasswordRepository extends AuthBaseRepository
    implements ISendMailVerifyRepository {
  @override
  ResultFuture<bool> sendMailVerify(String email) {
    return make
        .request(
            path: "/otp/sendOtp/$email",
            decoder: const EmptyResponse())
        .post()
        .map(onValue: (value) => true);
  }
}

final sendMailVerifyRepositoryProvider =
    Provider.autoDispose<ISendMailVerifyRepository>((ref) {
  return ResetPasswordRepository();
});