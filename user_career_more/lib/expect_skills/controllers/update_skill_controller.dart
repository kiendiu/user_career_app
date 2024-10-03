import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/expect_skills/models/skill_request.dart';
import 'package:user_career_more/expect_skills/models/skill_response.dart';
import 'package:user_career_more/expect_skills/repositories/skill_repository.dart';

class UpdateSkillController extends AutoDisposeFamilyNotifier<SkillRequest, SkillResponse>
    with AlertMixin, MetadataUpdater{
  @override
  SkillRequest build(SkillResponse arg) {
    if(arg.isNotNull){
      final skillRequest = SkillRequest(
        userId: arg.userId,
        skillId: arg.skillId,
        nameSkill: arg.nameSkill,
        categoryId: arg.categoryId,
        experienceYear: arg.experienceYear,
        nameCategory: arg.nameCategory,
        timeOffline: arg.timeOffline,
        timeOnline: arg.timeOnline,
        priceOffline: arg.priceOffline,
        priceOnline:  arg.priceOnline,
        skillDescription: arg.skillDescription
      );
      return skillRequest;
    }else{
      return SkillRequest();
    }
  }

  Future<bool> updateSkill() async {
    final result = await ref
        .read(skillRepositoryProvider)
        .updateSkill(state)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }
  void setSkillName(String? value) {
    state =  state.copyWith(nameSkill: value);
  }

  void setExperienceYear(int? value) {
    state =  state.copyWith(experienceYear: value);
  }

  void setSkillDescription(String? value) {
    state =  state.copyWith(skillDescription: value);
  }

  void setTimeOnline(int? value) {
    state =  state.copyWith(timeOnline: value);
  }

  void setPriceOnline(double? value) {
    state =  state.copyWith(priceOnline: value);
  }

  void setTimeOffline(int? value) {
    state =  state.copyWith(timeOffline: value);
  }

  void setPriceOffline(double? value) {
    state =  state.copyWith(priceOffline: value);
  }

  void setCategory(int? value, String? text){
    state =  state.copyWith(categoryId: value, nameCategory: text);
  }
}

final updateSkillControllerProvider =
NotifierProvider.autoDispose.family<UpdateSkillController, SkillRequest, SkillResponse>(
        () => UpdateSkillController()
);