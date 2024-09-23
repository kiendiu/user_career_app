import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/more/models/request/expect_experience_request.dart';
import 'package:user_career_more/more/models/response/expect_experience_response.dart';
import 'package:user_career_more/more/repositories/expect_experience_repository.dart';

class ExpectExperiencesController extends AutoDisposeNotifier<ExpectExperienceRequest>
    with AlertMixin, MetadataUpdater{
  @override
  ExpectExperienceRequest build() {
    return ExpectExperienceRequest();
  }

  Future<List<ExpectExperienceResponse>> getExpectExperiences(int page) async {
    try {
      final result = await ref
          .read(expectExperienceRepositoryProvider)
          .getExpectExperiences(PageParams.small(page: page + 1))
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result;
    } catch (e) {
      return [];
    }
  }

  Future<bool> createExpectExperiences(ExpectExperienceRequest request) async {
    final result = await ref
        .read(expectExperienceRepositoryProvider)
        .addExpectExperience(request)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  Future<bool> updateExpectExperiences(ExpectExperienceRequest request) async {
    final result = await ref
        .read(expectExperienceRepositoryProvider)
        .updateExpectExperience(request)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  Future<bool> deleteExpectExperiences(int id) async {
    final result = await ref
        .read(expectExperienceRepositoryProvider)
        .deleteExpectExperience(id)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  void setExpectCompany(String? value) {
    state =  state.copyWith(company: value);
  }

  void setExpectCategory(int? value) {
    state =  state.copyWith(categoryId: value);
  }

  void setExpectPosition(String? value) {
    state =  state.copyWith(position: value);
  }

  void setExpectDescription(String? value) {
    state =  state.copyWith(jobDescription: value);
  }

  void setExpectStartTime(DateTime? value) {
    state =  state.copyWith(startTime: value.toString());
  }

  void setExpectEndTime(DateTime? value) {
    state =  state.copyWith(endTime: value.toString());
  }

  void setExpectCurrentlyWorking(bool? value) {
    state =  state.copyWith(currentlyWorking: value);
  }
}

final expectExperiencesControllerProvider =
NotifierProvider.autoDispose<ExpectExperiencesController, ExpectExperienceRequest>(() {
  return ExpectExperiencesController();
});