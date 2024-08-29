import 'package:user_career_core/user_career_core.dart';

class MailVerifyResponse implements Decodable{
  int? id;

  @override
  void decode(json) {
    id = json["user_id"];
  }
}