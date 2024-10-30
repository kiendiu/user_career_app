import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/expect_experiences/models/expect_experience_request.dart';
import 'package:user_career_more/expect_experiences/models/expect_experience_response.dart';
import 'package:user_career_more/expect_experiences/repositories/expect_experience_repository.dart';

class EditExperienceController extends AutoDisposeFamilyNotifier<ExpectExperienceRequest, ExpectExperienceResponse>
    with AlertMixin, MetadataUpdater{
  @override
  ExpectExperienceRequest build(ExpectExperienceResponse arg) {
    if(arg.isNotNull){
      final expectExperienceRequest = ExpectExperienceRequest(
        userId: arg.userId,
        experienceId: arg.experienceId,
        company: arg.company,
        categoryId: arg.categoryId,
        nameCategory: arg.nameCategory,
        startTime: arg.startTime?.toString(),
        endTime: arg.endTime?.toString(),
        currentlyWorking: arg.currentlyWorking == null ? false : true,
        jobDescription: arg.jobDescription,
        position: arg.position,
      );
      return expectExperienceRequest;
    }else{
      return ExpectExperienceRequest();
    }
  }

  Future<bool> updateExpectExperiences() async {
    final result = await ref
        .read(expectExperienceRepositoryProvider)
        .updateExpectExperience(state)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }
  void setExpectCompany(String? value) {
    state =  state.copyWith(company: value);
  }

  void setExpectCategory(int? value, String? text){
    state =  state.copyWith(categoryId: value, nameCategory: text);
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

  void clearExpectExperience() {
    state = ExpectExperienceRequest();
  }
}

final editExperienceControllerProvider =
    NotifierProvider.autoDispose.family<EditExperienceController, ExpectExperienceRequest, ExpectExperienceResponse>(() => EditExperienceController());