import 'package:user_career_core/user_career_core.dart';

class UploadMediaResponse implements Decodable {
  String? linkUrl;

  UploadMediaResponse({this.linkUrl});

  @override
  void decode(json) {
    linkUrl = json["link_url"];
  }
}