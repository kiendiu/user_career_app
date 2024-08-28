import 'package:recase/recase.dart';
import 'package:user_career_core/user_career_core.dart';

class AppCommonErrorConverter implements CommonErrorTransformable {
  @override
  CommonError transform(CommonError error) {
    var data = error.errorData;
    var messages = data?["message"];

    if (messages is Map<String, dynamic>) {
      final map = messages.values.toList();
      final firstErrorMessageKey = map.firstOrNull;

      if (firstErrorMessageKey is String) {
        return CommonError(
            message: L["error.${firstErrorMessageKey.camelCase}"] ??
                "Đã có lỗi xảy ra");
      }
    }

    return error;
  }
}