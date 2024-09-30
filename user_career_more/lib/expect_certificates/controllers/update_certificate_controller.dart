import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/expect_certificates/models/certificate_request.dart';
import 'package:user_career_more/expect_certificates/models/certificate_response.dart';
import 'package:user_career_more/expect_certificates/models/update_media_request.dart';
import 'package:user_career_more/expect_certificates/models/upload_media_response.dart';
import 'package:user_career_more/expect_certificates/repositories/certificate_repository.dart';

class UpdateCertificateState {
  CertificateRequest certificateRequest;
  UploadMediaResponse? uploadMediaResponse;
  AppFile? newAvatar;
  bool noDeleteAvatar;

  UpdateCertificateState({
    required this.certificateRequest,
    this.uploadMediaResponse,
    this.newAvatar,
    required this.noDeleteAvatar
  });

  UpdateCertificateState copyWith({
    CertificateRequest? certificateRequest,
    UploadMediaResponse? uploadMediaResponse,
    AppFile? newAvatar,
    bool? noDeleteAvatar
  }) {
    return UpdateCertificateState(
        certificateRequest: certificateRequest ?? this.certificateRequest,
        uploadMediaResponse: uploadMediaResponse ?? this.uploadMediaResponse,
        newAvatar: newAvatar ?? this.newAvatar,
        noDeleteAvatar: noDeleteAvatar?? this.noDeleteAvatar
    );
  }
}



class UpdateCertificateController
    extends AutoDisposeFamilyNotifier<UpdateCertificateState, CertificateResponse> with AlertMixin {
  @override
  UpdateCertificateState build(CertificateResponse arg) {
    return UpdateCertificateState(
        certificateRequest: CertificateRequest(
          certificateId: arg.certificateId,
          certificateName: arg.certificateName,
          certificateDescription: arg.certificateDescription,
          linkUrl: arg.linkUrl,
        ),
        noDeleteAvatar: false);
  }

  Future<bool> updateCertificate() async {
    showLoading();
    final updateResult = await ref
        .read(certificateRepositoryProvider)
        .updateCertificate(state.certificateRequest)
        .showErrorBy(this)
        .hideLoadingBy(this)
        .isSuccess();
    return updateResult;
  }

  Future<void> uploadFile(AppFile? avatar) async {
    showLoading();
    final result = await ref
        .read(certificateRepositoryProvider)
        .updateAvatar(UploadMediaRequest()..fileName = avatar)
        .showErrorBy(this)
        .hideLoadingBy(this)
        .mapToValueOr(defaultValue: UploadMediaResponse())
        .asFuture();
    state = state.copyWith(
        uploadMediaResponse: result,
        certificateRequest:
        state.certificateRequest.copyWith(linkUrl: result.linkUrl));
  }

  void setName(String? name) {
    state = state.copyWith(
        certificateRequest:
        state.certificateRequest.copyWith(certificateName: name));
  }

  void setDescription(String? description) {
    state = state.copyWith(
        certificateRequest:
        state.certificateRequest.copyWith(certificateDescription: description));
  }

  void setLinkUrl(String? linkUrl) {
    state = state.copyWith(
        certificateRequest:
        state.certificateRequest.copyWith(linkUrl: linkUrl));
  }

  void setAvatar(
      {String? avatarPath, bool? noDeleteAvatar, AppFile? newAvatar}) {
    state = state.copyWith(
        noDeleteAvatar: noDeleteAvatar,
        newAvatar: newAvatar,
        certificateRequest:
        state.certificateRequest.copyWith(linkUrl: avatarPath));
  }

  void updateAvatar(AppFile? avatar) async {
    state = state.copyWith(newAvatar: avatar);
  }

  bool checkNewAvatar() => state.newAvatar != null;
}

final updateCertificateControllerProvider = NotifierProvider.autoDispose.family<
    UpdateCertificateController, UpdateCertificateState, CertificateResponse>(() {
  return UpdateCertificateController();
});
