import 'package:user_career_core/common/career_storage_key.dart';
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
    return {
      "email": Storage.get(POSStorageKey.userNameKey),
      "newPassword": password};
  }

  bool get canPassword => (password?.length ?? 0) > 0;

  bool get canConfirmPassword =>
      confirmPassword != null && confirmPassword == password;
}
