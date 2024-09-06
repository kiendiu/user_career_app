import 'package:user_career_core/user_career_core.dart';

class ChangePasswordRequest implements Encodable {
  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  ChangePasswordRequest({
    this.oldPassword,
    this.newPassword,
    this.confirmPassword
  });

  ChangePasswordRequest copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
  }) {
    return ChangePasswordRequest(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      'old_password': oldPassword,
      'new_password': newPassword,
      'confirm_new_password': confirmPassword,
    };
  }

  bool get isEmpty =>
      isEmptyOldPassword &&
      isEmptyNewPassword &&
      isEmptyConfirmPassword;

  bool get isEmptyOldPassword =>
      oldPassword != null &&
      oldPassword!.isNotEmpty;

  bool get isEmptyNewPassword =>
      newPassword != null &&
      newPassword!.isNotEmpty;

  bool get isEmptyConfirmPassword =>
      confirmPassword != null &&
      confirmPassword!.isNotEmpty;

  bool get isOldPasswordEqualToNewPassword => oldPassword == newPassword;

  bool get isNewPasswordNotEqualToConfirmPassword => newPassword != confirmPassword;

}