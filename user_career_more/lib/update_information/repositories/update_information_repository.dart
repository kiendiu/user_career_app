import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/update_information/models/update_information_request.dart';

abstract interface class IUpdateInformationRepository {
  ResultFuture<bool> updateInformation(UpdateInformationRequest request);
}

class UpdateInformationRepository extends MoreBaseRepository
    implements IUpdateInformationRepository {
  @override
  ResultFuture<bool> updateInformation(UpdateInformationRequest request) {
    return make
        .request(
        path: "/users/profile",
        decoder: const EmptyResponse(),
        body: request.encode())
        .put();
  }
}

final updateInformationRepositoryProvider =
Provider.autoDispose<IUpdateInformationRepository>((ref) {
  return UpdateInformationRepository();
});
