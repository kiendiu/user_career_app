import 'package:user_career_core/user_career_core.dart';

class UploadMediaResponse implements Decodable {
  String? avatar;

  UploadMediaResponse({this.avatar});

  @override
  void decode(json) {
    avatar = json["avatar"];
  }
}