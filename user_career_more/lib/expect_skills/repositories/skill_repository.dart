import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/expect_skills/models/skill_request.dart';
import 'package:user_career_more/expect_skills/models/skill_response.dart';

abstract interface class ISkillRepository {
  ResultFuture<BaseListResponse<SkillResponse>> getSkill(BaseParams params);

  ResultFuture<bool> addSkill(SkillRequest request);

  ResultFuture<bool> updateSkill(SkillRequest request);

  ResultFuture<bool> deleteSkill(int experienceId);

}

class SkillRepository extends MoreBaseRepository implements ISkillRepository {
  @override
  ResultFuture<BaseListResponse<SkillResponse>> getSkill(BaseParams params) {
    return make.request(
        path: "/expects/skills",
        params: params,
        decoder: BaseListResponseModel.decodeBy(() => SkillResponse())
    ).get();
  }

  @override
  ResultFuture<bool> addSkill(SkillRequest request) {
    return make.request(
      path: "/expects/skill",
      body: request.encode(),
      decoder: const EmptyResponse(),
    ).post().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> deleteSkill(int experienceId) {
    return make.request(
      path: "/expects/skill/${experienceId.toString()}",
      decoder: const EmptyResponse(),
    ).delete().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> updateSkill(SkillRequest request) {
    return make.request(
      path: "/expects/skill",
      body: request.encode(),
      decoder: const EmptyResponse(),
    ).put().map(onValue: (value) => true);
  }

}

final skillRepositoryProvider = Provider.autoDispose<ISkillRepository>((ref) {
  return SkillRepository();
});