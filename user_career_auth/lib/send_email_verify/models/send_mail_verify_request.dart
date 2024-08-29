import 'package:user_career_core/user_career_core.dart';

class SendMailVerifyRequest implements Encodable{
  String? email = "";

  @override
  Map<String, dynamic> encode() {
    return {
      "email": email,
    };
  }

  bool get canSubmitLogin => email != null
      && email!.isNotEmpty
      && email!.isValidEmail();
}