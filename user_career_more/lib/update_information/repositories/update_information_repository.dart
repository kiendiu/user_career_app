import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/update_information/models/update_information_request.dart';
import 'package:user_career_more/update_information/models/update_media_request.dart';
import 'package:user_career_more/update_information/models/upload_media_response.dart';

abstract interface class IUpdateInformationRepository {
  ResultFuture<bool> updateInformation(UpdateInformationRequest request);

  ResultFuture<UploadMediaResponse> updateAvatar(UploadMediaRequest request);
}

class UpdateInformationRepository extends MoreBaseRepository
    implements IUpdateInformationRepository {
  @override
  ResultFuture<bool> updateInformation(UpdateInformationRequest request) {
    return make.request(
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
  ResultFuture<UploadMediaResponse> updateAvatar(UploadMediaRequest request) {
    return make.request(
        path: "/uploads/upload-avatar",
        decoder: UploadMediaResponse(),
        body: request.encode()
    ).post();
  }

}

final updateInformationRepositoryProvider =
Provider.autoDispose<IUpdateInformationRepository>((ref) {
  return UpdateInformationRepository();
});
