import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/Register/models/register_request.dart';
import 'package:user_career_auth/core/repository.dart';
import 'package:user_career_core/user_career_core.dart';

abstract interface class IRegisterRepository {
  ResultFuture<bool> register(RegisterRequest request);
}

class RegisterRepository extends AuthBaseRepository
    implements IRegisterRepository {
  @override
  ResultFuture<bool> register(RegisterRequest request) {
    return make
        .request(
            path: "/users/register",
            decoder: const EmptyResponse(),
            body: request.encode())
        .post()
        .map(
      onValue: (value) {
        return true;
      },
    );
  }
}

final registerRepositoryProvider =
    Provider.autoDispose<IRegisterRepository>((ref) {
  return RegisterRepository();
});
