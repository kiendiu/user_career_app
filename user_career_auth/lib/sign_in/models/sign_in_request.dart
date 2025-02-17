import 'package:user_career_core/user_career_core.dart';

class SignInRequest implements Encodable {
  String? email;
  String? password;

  SignInRequest({this.email, this.password});

  @override
  Map<String, dynamic> encode() {
    return {"email": email, "password": password};
  }

  SignInRequest copyWith({String? username, String? password}) {
    return SignInRequest(
        email: username ?? email,
        password: password ?? this.password);
  }

  bool get canLogin =>
      email != null &&
          email!.trim().isNotEmpty &&
          email!.isValidEmail() &&
          password != null &&
          password!.trim().isNotEmpty;

  bool get isUsernameValid =>
      email != null &&
          email!.trim().isNotEmpty &&
          email!.isValidEmail();

  bool get isPasswordValid => password != null && password!.trim().isNotEmpty;
}
