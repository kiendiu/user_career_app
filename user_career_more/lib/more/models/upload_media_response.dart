import 'package:user_career_core/user_career_core.dart';

class UploadMediaResponse implements Decodable {
  String? filePath;
  String? fullPath;
  String? preSignedUrl;

  @override
  void decode(json) {
    filePath = json["file_path"];
    fullPath = json["full_path"];
    preSignedUrl = json["pre_signed"];
  }
}