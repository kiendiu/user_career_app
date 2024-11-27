import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/more/models/expect_information_request.dart';
import 'package:user_career_more/more/models/expect_information_response.dart';
import 'package:user_career_more/more/models/language_model.dart';

abstract interface class IExpectRepository {
  ResultFuture<BaseListResponse<LanguageModel>> getLanguages();

  ResultFuture<bool> updateExpectInformation(ExpectInformationRequest request);

  ResultFuture<ExpectInformationResponse> getExpectInformation();

  ResultFuture<bool> submitRequireApprove(String approval);

}

class ExpectRepository extends MoreBaseRepository implements IExpectRepository {

  @override
  ResultFuture<BaseListResponse<LanguageModel>> getLanguages() {
    return make.request(
        path: "/users/languages",
        decoder: BaseListResponseModel.decodeBy(() => LanguageModel())
    ).get();
  }

  @override
  ResultFuture<bool> updateExpectInformation(ExpectInformationRequest request) {
    return make.request(
      path: "/users/update-details",
      body: request.encode(),
      decoder: const EmptyResponse()
    ).patch().map(onValue: (value) => true);
  }

  @override
  ResultFuture<ExpectInformationResponse> getExpectInformation() {
    return make.request(
      path: "/users/details",
      decoder: ExpectInformationResponse(),
    ).get();
  }

  @override
  ResultFuture<bool> submitRequireApprove(String approval) {
    return make.request(
      path: "/users//approval/$approval",
      decoder: const EmptyResponse()
    ).put().map(onValue: (value) => true);
  }

}

final expectRepositoryProvider = Provider.autoDispose<IExpectRepository>((ref) {
  return ExpectRepository();
});