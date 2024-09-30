import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/expect_certificates/models/certificate_request.dart';
import 'package:user_career_more/expect_certificates/models/certificate_response.dart';
import 'package:user_career_more/expect_certificates/models/update_media_request.dart';
import 'package:user_career_more/expect_certificates/models/upload_media_response.dart';

abstract interface class ICertificateRepository {
  ResultFuture<BaseListResponse<CertificateResponse>> getCertificates(BaseParams params);

  ResultFuture<bool> addCertificate(CertificateRequest request);

  ResultFuture<bool> updateCertificate(CertificateRequest request);

  ResultFuture<bool> deleteCertificate(int certificateId);

  ResultFuture<CertificateResponse>getDetailCertificate(int certificateId);

  ResultFuture<UploadMediaResponse> updateAvatar(UploadMediaRequest request);
}

class CertificateRepository extends MoreBaseRepository implements ICertificateRepository {
  @override
  ResultFuture<BaseListResponse<CertificateResponse>> getCertificates(BaseParams params) {
    return make.request(
        path: "/expects/certificates",
        params: params,
        decoder: BaseListResponseModel.decodeBy(() => CertificateResponse())
    ).get();
  }

  @override
  ResultFuture<bool> addCertificate(CertificateRequest request) {
    return make.request(
      path: "/expects/certificate",
      body: request.encode(),
      decoder: const EmptyResponse(),
    ).post().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> deleteCertificate(int experienceId) {
    return make.request(
      path: "/expects/certificate/${experienceId.toString()}",
      decoder: const EmptyResponse(),
    ).delete().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> updateCertificate(CertificateRequest request) {
    return make.request(
      path: "/expects/certificate",
      body: request.encode(),
      decoder: const EmptyResponse(),
    ).put().map(onValue: (value) => true);
  }

  @override
  ResultFuture<UploadMediaResponse> updateAvatar(UploadMediaRequest request) {
    return make.request(
        path: "/uploads/upload-certificate",
        decoder: UploadMediaResponse(),
        body: request.encode()
    ).post();
  }

  @override
  ResultFuture<CertificateResponse> getDetailCertificate(int certificateId) {
    return make.request(
        path: "/expects/certificate/$certificateId",
        decoder: CertificateResponse()
    ).get();
  }
}

final certificateRepositoryProvider = Provider.autoDispose<ICertificateRepository>((ref) {
  return CertificateRepository();
});