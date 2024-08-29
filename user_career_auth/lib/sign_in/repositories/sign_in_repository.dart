import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/core/repository.dart';
import 'package:user_career_auth/sign_in/models/sign_in_request.dart';
import 'package:user_career_auth/sign_in/models/sign_in_response.dart';
import 'package:user_career_core/user_career_core.dart';

abstract interface class ISignInRepository {
  ResultFuture<SignInResponse> signIn(SignInRequest request);
}

class SignInRepository extends AuthBaseRepository implements ISignInRepository {
  @override
  ResultFuture<SignInResponse> signIn(SignInRequest request) {
    return make
        .request(
        path: "/users/login",
        decoder: SignInResponse(),
        body: request.encode())
        .post();
  }
}

final signInRepositoryProvider = Provider.autoDispose<ISignInRepository>((ref) {
  return SignInRepository();
});
