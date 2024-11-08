import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/language_model.dart';
import 'package:user_career_auth/admin/repositories/admin_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class LanguageDetailController extends AutoDisposeFamilyNotifier<LanguageDetailState, LanguageModel?>
    with AutoDisposeFamilyNotifierUpdateMixin, AlertMixin, MetadataUpdater{
  @override
  LanguageDetailState build(LanguageModel? arg) {
    if(arg.isNotNull){
      return LanguageDetailState.fromCategoryModel(
        editLanguageModel: arg
      );
    }
    return LanguageDetailState(
        editLanguageModel: LanguageModel(),
        isEdit: false
    );
  }

  Future<bool> addOrEditCategory() async {
    final language = state.editLanguageModel?.copyWith(
      nameLanguage: state.editLanguageModel?.nameLanguage,
      languageId: state.editLanguageModel?.languageId,
    );
    if (state.isEdit) {
      if (language?.languageId == null) return false;
      final result = await ref.read(adminRepositoryProvider)
          .updateLanguage(language!)
          .showErrorBy(this)
          .hideLoadingBy(this)
          .showSuccessBy(this, message: "Cập nhật thành công")
          .isSuccess();
      return result;
    } else {
      final result = await ref.read(adminRepositoryProvider)
          .createLanguage(language!)
          .showErrorBy(this)
          .hideLoadingBy(this)
          .showSuccessBy(this, message: "Thêm mới thành công")
          .isSuccess();
      return result;
    }
  }
  void updateLanguage(LanguageModel language) {
    update((state) => state.copyWith(editLanguageModel: language));
  }
}

final languageDetailControllerProvider = NotifierProvider.autoDispose
    .family<LanguageDetailController, LanguageDetailState, LanguageModel?>(
        () => LanguageDetailController());

class LanguageDetailState{
  final bool isEdit;
  final LanguageModel? editLanguageModel;

  LanguageDetailState.fromCategoryModel({
    required this.editLanguageModel,
  })  : isEdit = true;
  LanguageDetailState({
    this.isEdit = false,
    this.editLanguageModel,
  });

  LanguageDetailState copyWith({
    bool? isEdit,
    LanguageModel? editLanguageModel,
  }) {
    return LanguageDetailState(
      isEdit: isEdit ?? this.isEdit,
      editLanguageModel: editLanguageModel ?? this.editLanguageModel,
    );
  }
}