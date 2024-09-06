import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/more/models/get_information_response.dart';
import 'package:user_career_more/more/models/requests/information_request.dart';
import 'package:user_career_more/more/models/requests/upload_media_request.dart';
import 'package:user_career_more/more/models/upload_media_response.dart';

abstract interface class IMoreRepository {
  ResultFuture<GetInformationResponse> getUserInfo();

  ResultFuture<bool> updateInformation(InformationRequest request);

  ResultFuture<UploadMediaResponse> uploadMedia(UploadMediaRequest request);

  ResultFuture<bool> uploadFileS3(String path, File avatarFile);
}

class MoreRepository extends MoreBaseRepository implements IMoreRepository {

  @override
  ResultFuture<GetInformationResponse> getUserInfo() {
    return make
        .request(path: "/users/profile", body: {}, decoder: GetInformationResponse())
        .get();
  }

  @override
  ResultFuture<bool> updateInformation(InformationRequest request) {
    return make
      .request(
        path: "/users/profile",
        decoder: const EmptyResponse(),
        body: request.encode()
      ).patch().map(
        onValue: (value) {
          return true;
        },
      );
  }

  @override
  ResultFuture<UploadMediaResponse> uploadMedia(UploadMediaRequest request) {
    return make
        .request(
        path: "/users/profile/avatar",
        decoder: UploadMediaResponse(),
        body: request.encode())
        .patch();
  }

  @override
  ResultFuture<bool> uploadFileS3(String path, File avatarFile) {
    return make
        .request(
      path: path,
      decoder: const EmptyResponse(),
      body: avatarFile.openRead(),
      options: Options(headers: {
        "Content-Type": "application/octet-stream",
        "Content-Length": avatarFile.lengthSync(),
      }),
    )
        .noAuthenticationNeeded()
        .put()
        .map(onValue: (value) => true);
  }
}

final moreRepositoryProvider = Provider.autoDispose<IMoreRepository>((ref) {
  return MoreRepository();
});