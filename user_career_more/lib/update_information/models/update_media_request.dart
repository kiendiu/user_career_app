import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';

class UploadMediaRequest {
  int? userId;
  AppFile? fileName;

  FormData encode() {
    return FormData.fromMap({
      "userId": Storage.get(POSStorageKey.userId),
      "avatar": MultipartFile.fromFileSync(fileName!.path ?? "")
    });
  }
}