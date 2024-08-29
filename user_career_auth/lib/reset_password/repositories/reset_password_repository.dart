import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/core/repository.dart';
import 'package:user_career_auth/reset_password/models/reset_password_request.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';

abstract interface class IResetPasswordRepository {
  ResultFuture<bool> resetPassword(ResetPasswordRequest request);
}

class ResetPasswordRepository extends AuthBaseRepository
    implements IResetPasswordRepository {
  @override
  ResultFuture<bool> resetPassword(ResetPasswordRequest request) {
    return make
        .request(
            path: "/oauth/reset-password/${Storage.get(POSStorageKey.idKey)}",
            decoder: const EmptyResponse(),
            body: request.encode())
        .post()
        .map(onValue: (value) => true);
  }
}

final resetPasswordRepositoryProvider =
    Provider.autoDispose<IResetPasswordRepository>((ref) {
  return ResetPasswordRepository();
});