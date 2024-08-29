import 'package:mobile_framework/packages/api/base/http_status_codes.dart';
import 'package:user_career_core/user_career_core.dart';

class AppRefreshTokenRequestDetector implements RefreshTokenRequestDetector {
  @override
  bool isRefreshTokenRequest(DioException exp) {
    return exp.response?.statusCode == status401Unauthorized;
  }
}
