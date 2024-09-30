import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';

class CertificateRequest implements Encodable {
  int? userId;
  int? certificateId;
  String? certificateName;
  String? certificateDescription;
  String? linkUrl;
  String? thumbnails;

  CertificateRequest({
    this.userId,
    this.certificateId,
    this.certificateName,
    this.certificateDescription,
    this.linkUrl,
    this.thumbnails,
  });


  @override
  Map<String, dynamic> encode() {
    return {
      "user_id": Storage.get(POSStorageKey.userId),
      "certificate_id": certificateId ?? '',
      "name_certificate": certificateName,
      "certificate_description": certificateDescription,
      "link_url": linkUrl,
      "thumbnails": thumbnails ?? '',
    };
  }

  CertificateRequest copyWith({
    int? userId,
    int? certificateId,
    String? certificateName,
    String? certificateDescription,
    String? linkUrl,
    String? thumbnails,
  }) {
    return CertificateRequest(
      userId: userId ?? this.userId,
      certificateId: certificateId ?? this.certificateId,
      certificateName: certificateName ?? this.certificateName,
      certificateDescription: certificateDescription ?? this.certificateDescription,
      linkUrl: linkUrl ?? this.linkUrl,
      thumbnails: thumbnails ?? this.thumbnails,
    );
  }

  bool get isCertificateNameEmpty => certificateName != null && certificateName!.isNotEmpty ;

  bool get isCertificateDescriptionEmpty => certificateDescription != null && certificateDescription!.isNotEmpty ;

  bool get isLinkUrlEmpty => linkUrl != null && linkUrl!.isNotEmpty ;

  bool get canSubmit => isCertificateNameEmpty && isCertificateDescriptionEmpty && isLinkUrlEmpty;
}