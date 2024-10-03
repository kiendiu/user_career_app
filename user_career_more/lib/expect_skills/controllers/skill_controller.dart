import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/expect_skills/models/skill_request.dart';
import 'package:user_career_more/expect_skills/models/skill_response.dart';
import 'package:user_career_more/expect_skills/repositories/skill_repository.dart';

class SkillController extends AutoDisposeNotifier<SkillRequest>
    with AlertMixin, MetadataUpdater{
  @override
  SkillRequest build() {
    return SkillRequest();
  }

  Future<List<SkillResponse>> getSkills(int page) async {
    try {
      final result = await ref
          .read(skillRepositoryProvider)
          .getSkill(PageParams.small(page: page + 1))
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result;
    } catch (e) {
      return [];
    }
  }

  Future<bool> createSkill() async {
    final result = await ref
        .read(skillRepositoryProvider)
        .addSkill(state)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  Future<bool> deleteSkill(int? id) async {
    final result = await ref
        .read(skillRepositoryProvider)
        .deleteSkill(id ?? 0)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  void clearSkill() {
    state = SkillRequest();
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

final skillControllerProvider =
NotifierProvider.autoDispose<SkillController, SkillRequest>(() {
  return SkillController();
});