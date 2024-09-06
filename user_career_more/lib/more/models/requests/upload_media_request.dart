import 'package:user_career_core/user_career_core.dart';

class UploadMediaRequest implements Encodable{
  String? fileName;

  @override
  Map<String, dynamic> encode() {
    return {
      "avatar": fileName
    };
  }
}