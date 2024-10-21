import 'package:user_career_core/user_career_core.dart';

class RegisterRequest implements Encodable {
  String? username;
  String? email;
  String? password;

  RegisterRequest({this.username, this.email, this.password});

  @override
  Map<String, dynamic> encode() {
    return {"username": username, "email": email, "password": password};
  }

  RegisterRequest copyWith({String? username, String? email, String? password}) {
    return RegisterRequest(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password);
  }

  bool get canRegister =>
      username != null &&
          email != null &&
          email!.trim().isNotEmpty &&
          email!.isValidEmail() &&
          password != null &&
          password!.trim().isNotEmpty;

  bool get isEmailValid =>
      email != null &&
          email!.trim().isNotEmpty &&
          email!.isValidEmail();

  bool get isPasswordValid => password != null && password!.trim().isNotEmpty;

  bool get isUsernameValid => username != null && username!.trim().isNotEmpty;
  String? idName;
}