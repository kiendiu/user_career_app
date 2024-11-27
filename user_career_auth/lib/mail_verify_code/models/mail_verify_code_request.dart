import 'package:user_career_core/user_career_core.dart';

class MailVerifyCodeRequest implements Encodable{
  String? email = "";
  String? verifyCode = "";

  @override
  Map<String, dynamic> encode() {
    return {
      "email": email,
      "otp": verifyCode,
    };
  }

  MailVerifyCodeRequest copyWith({
    String? email,
    String? verifyCode,
  }) {
    return MailVerifyCodeRequest()
      ..email = email ?? this.email
      ..verifyCode = verifyCode ?? this.verifyCode;
  }

  bool get canSubmitVerifyCode => (verifyCode?.length ?? 0) > 5;
}