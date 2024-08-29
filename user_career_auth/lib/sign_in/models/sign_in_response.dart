import 'package:user_career_core/user_career_core.dart';

class SignInResponse implements Decodable {
  String? accessToken;
  String? refreshToken;

  @override
  void decode(json) {
    accessToken = json?['access_token'];
    refreshToken = json?['refresh_token'];
  }
}