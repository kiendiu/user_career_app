import 'package:user_career_core/user_career_core.dart';

class AppRefreshTokenService implements IRefreshTokenService {
  @override
  bool isRefreshToken = false;

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
