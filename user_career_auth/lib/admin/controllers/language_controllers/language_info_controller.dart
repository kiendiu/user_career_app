import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/language_model.dart';
import 'package:user_career_auth/admin/repositories/admin_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class LanguageInfoController
    extends AutoDisposeFamilyNotifier<LanguageModel, LanguageModel>
    with AutoDisposeFamilyNotifierUpdateMixin, AlertMixin{
  @override
  LanguageModel build(LanguageModel arg) {
    return arg;
  }

  Future<void> deleteLanguage(Function() onSuccess, Function() onRemind) async {
    final result = await ref
        .read(adminRepositoryProvider)
        .deleteLanguage(state.languageId ?? 0)
        .hideLoadingBy(this)
        .asFuture();
    switch(result){
      case Success():
        onSuccess();
        break;
      case Failure(error: final error):
        if(error.errorCode == 403){
          onRemind();
        }else{
          showError(error);
        }
        break;
    }
  }

  void updateLanguage(LanguageModel language) {
    update((state) => language);
  }
}

final languageInfoControllerProvider = NotifierProvider.autoDispose
    .family<LanguageInfoController, LanguageModel, LanguageModel>(
        () => LanguageInfoController());