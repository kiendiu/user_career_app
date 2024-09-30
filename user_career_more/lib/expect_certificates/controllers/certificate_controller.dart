import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/expect_certificates/models/certificate_request.dart';
import 'package:user_career_more/expect_certificates/models/certificate_response.dart';
import 'package:user_career_more/expect_certificates/models/update_media_request.dart';
import 'package:user_career_more/expect_certificates/models/upload_media_response.dart';
import 'package:user_career_more/expect_certificates/repositories/certificate_repository.dart';


class CertificateState {
  CertificateRequest certificateRequest;
  UploadMediaResponse? uploadMediaResponse;
  AppFile? newAvatar;
  bool noDeleteAvatar;

  CertificateState({
    required this.certificateRequest,
    this.uploadMediaResponse,
    this.newAvatar,
    required this.noDeleteAvatar
  });

  CertificateState copyWith({
    CertificateRequest? certificateRequest,
    UploadMediaResponse? uploadMediaResponse,
    AppFile? newAvatar,
    bool? noDeleteAvatar
  }) {
    return CertificateState(
        certificateRequest: certificateRequest ?? this.certificateRequest,
        uploadMediaResponse: uploadMediaResponse ?? this.uploadMediaResponse,
        newAvatar: newAvatar ?? this.newAvatar,
        noDeleteAvatar: noDeleteAvatar?? this.noDeleteAvatar
    );
  }
}

class CertificateController extends AutoDisposeNotifier<CertificateState>
    with AlertMixin, MetadataUpdater{
  @override
  CertificateState build() {
    return CertificateState(
        certificateRequest: CertificateRequest(),
        noDeleteAvatar: false
    );
  }

  Future<List<CertificateResponse>> getCertificates(int page) async {
    try {
      final result = await ref
          .read(certificateRepositoryProvider)
          .getCertificates(PageParams.small(page: page + 1))
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result;
    } catch (e) {
      return [];
    }
  }

  Future<bool> createCertificate() async {
    final result = await ref
        .read(certificateRepositoryProvider)
        .addCertificate(state.certificateRequest)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  Future<bool> deleteCertificate(int? id) async {
    final result = await ref
        .read(certificateRepositoryProvider)
        .deleteCertificate(id ?? 0)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
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

  void clearCertificate() {
    state = state.copyWith(
        certificateRequest: CertificateRequest(),
        noDeleteAvatar: false);
  }
}

final certificateControllerProvider =
NotifierProvider.autoDispose<CertificateController, CertificateState>(() {
  return CertificateController();
});