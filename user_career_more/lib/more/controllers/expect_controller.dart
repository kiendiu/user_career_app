import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/more/models/approval_enum.dart';
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

  Future<bool> submitRequireApprove() async {
    final result = await ref
        .read(expectRepositoryProvider)
        .submitRequireApprove(ApprovalEnum.pending.rawValue)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }
}

final expectInformationControllerProvider =
AsyncNotifierProvider.autoDispose<ExpectInformationController, ExpectInformationResponse>(() {
  return ExpectInformationController();
});

class ExpectController extends AutoDisposeNotifier<ExpectInformationRequest>
    with AlertMixin, MetadataUpdater{
  @override
  ExpectInformationRequest build() {
    final expectInformation = ref.watch(expectInformationControllerProvider);
    return expectInformation.maybeWhen(
      data: (data) {
        return ExpectInformationRequest(
          experienceYears: data.experienceYears,
          skillDescription: data.skillDescription,
          approval: data.approval,
          listLanguages: data.languages,
        );
      },
      orElse: () => ExpectInformationRequest(),
    );
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

  Future<List<BaseSelectableItemModel<LanguageModel>>> getLanguagesBase() async {
    try {
      final result = await ref
          .read(expectRepositoryProvider)
          .getLanguages()
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result.map((element) {
        return BaseSelectableItemModel<LanguageModel>(
          data: element,
          id: element.id,
          name: element.nameLanguage,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  void setExperienceYears(int? experienceYears){
    state = state.copyWith(experienceYears: experienceYears);
  }

  void setSkillDescription(String? skillDescription){
    state = state.copyWith(skillDescription: skillDescription);
  }

  void setListLanguages(List<BaseSelectableItemModel<LanguageModel>>? listLanguages){
    state = state.copyWith(listLanguages: listLanguages);
  }

  // void setLanguages(List<int>? languages){
  //   state = state.copyWith(languages: languages);
  // }
  //
  // void setLanguagesLocal(Set<LanguageModel>? languagesLocal){
  //   state = state.copyWith(languagesLocal: languagesLocal);
  // }

}

final expectControllerProvider = NotifierProvider.autoDispose<ExpectController, ExpectInformationRequest>(() {
  return ExpectController();
});