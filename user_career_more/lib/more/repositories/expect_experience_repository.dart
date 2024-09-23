import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/more/models/request/expect_experience_request.dart';
import 'package:user_career_more/more/models/response/expect_experience_response.dart';

abstract interface class IExpectExperienceRepository {
  ResultFuture<BaseListResponse<ExpectExperienceResponse>> getExpectExperiences(BaseParams params);

  ResultFuture<bool> addExpectExperience(ExpectExperienceRequest request);

  ResultFuture<bool> updateExpectExperience(ExpectExperienceRequest request);

  ResultFuture<bool> deleteExpectExperience(int experienceId);

}

class ExpectExperienceRepository extends MoreBaseRepository implements IExpectExperienceRepository {
  @override
  ResultFuture<BaseListResponse<ExpectExperienceResponse>> getExpectExperiences(BaseParams params) {
    return make.request(
        path: "/expects/experiences",
        params: params,
        decoder: BaseListResponseModel.decodeBy(() => ExpectExperienceResponse())
    ).get();
  }

  @override
  ResultFuture<bool> addExpectExperience(ExpectExperienceRequest request) {
    return make.request(
      path: "/expects/experience",
      body: request.encode(),
      decoder: const EmptyResponse(),
    ).post().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> deleteExpectExperience(int experienceId) {
    return make.request(
      path: "/expects/experience/${experienceId.toString()}",
      decoder: const EmptyResponse(),
    ).delete().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> updateExpectExperience(ExpectExperienceRequest request) {
    return make.request(
      path: "/expects/experience",
      body: request.encode(),
      decoder: const EmptyResponse(),
    ).patch().map(onValue: (value) => true);
  }

}

final expectExperienceRepositoryProvider = Provider.autoDispose<IExpectExperienceRepository>((ref) {
  return ExpectExperienceRepository();
});