import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/change_password/models/change_password_request.dart';
import 'package:user_career_more/core/repository.dart';

abstract interface class IChangePasswordRepository {
  ResultFuture<bool> changePassword(ChangePasswordRequest request);
}

class ChangePasswordRepository extends MoreBaseRepository implements IChangePasswordRepository {
  @override
  ResultFuture<bool> changePassword(ChangePasswordRequest request) {
    return make.request(
        path: "/users/changePassword",
        decoder: const EmptyResponse(),
        body: request.encode(),
    ).put().map(onValue: (value) => true );
  }
}

final changePasswordRepositoryProvider = Provider<IChangePasswordRepository>((ref) {
  return ChangePasswordRepository();
});