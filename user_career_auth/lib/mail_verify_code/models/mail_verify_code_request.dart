import 'package:user_career_core/user_career_core.dart';

class MailVerifyCodeRequest implements Encodable{
  String? email = "";
  String? verifyCode = "";

  @override
  Map<String, dynamic> encode() {
    return {
      "email": email,
      "verify_code": verifyCode,
    };
  }

  bool get canSubmitVerifyCode => (verifyCode?.length ?? 0) > 5;
}