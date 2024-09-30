import 'package:user_career_core/user_career_core.dart';

class CertificateResponse implements Decodable {
  int? userId;
  int? certificateId;
  String? certificateName;
  String? certificateDescription;
  String? linkUrl;
  String? thumbnails;

  CertificateResponse({
    this.userId,
    this.certificateId,
    this.certificateName,
    this.certificateDescription,
    this.linkUrl,
    this.thumbnails,
  });

  @override
  void decode(json) {
    userId = json["user_id"];
    certificateId = json["certificate_id"];
    certificateName = json["name_certificate"];
    certificateDescription = json["certificate_description"];
    linkUrl = json["link_url"];
    thumbnails = json["thumbnails"];
  }

  CertificateResponse copyWith({
    int? userId,
    int? certificateId,
    String? certificateName,
    String? certificateDescription,
    String? linkUrl,
    String? thumbnails,
  }) {
    return CertificateResponse(
      userId: userId ?? this.userId,
      certificateId: certificateId ?? this.certificateId,
      certificateName: certificateName ?? this.certificateName,
      certificateDescription: certificateDescription ?? this.certificateDescription,
      linkUrl: linkUrl ?? this.linkUrl,
      thumbnails: thumbnails ?? this.thumbnails,
    );
  }
}