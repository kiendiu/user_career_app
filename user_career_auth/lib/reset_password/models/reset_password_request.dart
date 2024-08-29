import 'package:user_career_core/user_career_core.dart';

class ResetPasswordRequest implements Encodable {
  String? password = "";
  String? confirmPassword = "";

  ResetPasswordRequest({this.password, this.confirmPassword});

  ResetPasswordRequest copyWith({String? password, String? confirmPassword}) {
    return ResetPasswordRequest(
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword);
  }

  @override
  Map<String, dynamic> encode() {
    return {"new_password": password, "confirm_new_password": confirmPassword};
  }

  bool get canPassword => (password?.length ?? 0) > 8;

  bool get canConfirmPassword =>
      confirmPassword != null && confirmPassword == password;
}
