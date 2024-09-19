import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/more/models/expect_information_request.dart';
import 'package:user_career_more/more/models/expect_information_response.dart';
import 'package:user_career_more/more/models/language_model.dart';
import 'package:user_career_more/more/repositories/expect_repository.dart';

class ExpectInformationController extends AutoDisposeAsyncNotifier<ExpectInformationResponse> with AlertMixin{
  @override
  FutureOr<ExpectInformationResponse> build() {
    return getExpectInformation();
  }

  Future<ExpectInformationResponse> getExpectInformation() async {
    final result = await ref
        .read(expectRepositoryProvider)
        .getExpectInformation()
        .showErrorBy(this)
        .mapToValueOr(defaultValue: ExpectInformationResponse())
        .asFuture();
    return result;
  }
}

final expectInformationControllerProvider = AsyncNotifierProvider.autoDispose<ExpectInformationController, ExpectInformationResponse>(() {
  return ExpectInformationController();
});

class ExpectController extends AutoDisposeNotifier<ExpectInformationRequest> with AlertMixin{
  @override
  ExpectInformationRequest build() {
    return ExpectInformationRequest();
  }

  Future<bool> updateExpectInformation() async {
    final result = await ref
        .read(expectRepositoryProvider)
        .updateExpectInformation(state)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  Future<List<LanguageModel>> getLanguages() async {
    final result = await ref
        .read(expectRepositoryProvider)
        .getLanguages()
        .showErrorBy(this)
        .mapToValueOr(defaultValue: BaseListResponse<LanguageModel>())
        .asFuture();
    return result.items;
  }

  void setExperienceYears(int? experienceYears){
    state = state.copyWith(experienceYears: experienceYears);
  }

  void setSkillDescription(String? skillDescription){
    state = state.copyWith(skillDescription: skillDescription);
  }

  void setLanguages(List<int>? languages){
    state = state.copyWith(languages: languages);
  }
}

final expectControllerProvider = NotifierProvider.autoDispose<ExpectController, ExpectInformationRequest>(() {
  return ExpectController();
});