import 'package:user_career_core/user_career_core.dart';

class RegisterRequest implements Encodable {
  String? username;
  String? phone;
  String? email;
  String? password;

  RegisterRequest({this.username, this.phone, this.email, this.password});

  @override
  Map<String, dynamic> encode() {
    return {"username": username, "phone": phone, "email": email, "password": password};
  }

  RegisterRequest copyWith({String? username, String? phone, String? email, String? password}) {
    return RegisterRequest(
      username: username ?? this.username,
      phone: phone ?? this.phone,
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

  bool get isPhoneValid => phone != null && phone!.trim().isNotEmpty;
  String? idName;
}