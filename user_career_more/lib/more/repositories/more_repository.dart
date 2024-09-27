import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/more/models/get_information_request.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/more/models/get_information_response.dart';

abstract interface class IMoreRepository {
  ResultFuture<GetInformationResponse> getUserInfo();

  ResultFuture<bool> updateInformation(GetInformationRequest request);

}

class MoreRepository extends MoreBaseRepository implements IMoreRepository {

  @override
  ResultFuture<GetInformationResponse> getUserInfo() {
    return make
        .request(path: "/users/profile", body: {}, decoder: GetInformationResponse())
        .get();
  }

  @override
  ResultFuture<bool> updateInformation(GetInformationRequest request) {
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
}

final moreRepositoryProvider = Provider.autoDispose<IMoreRepository>((ref) {
  return MoreRepository();
});