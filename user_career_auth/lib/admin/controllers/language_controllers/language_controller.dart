import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/language_model.dart';
import 'package:user_career_auth/admin/repositories/admin_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class LanguageController extends AutoDisposeNotifier<void>
    with AlertMixin, MetadataUpdater{
  @override
  void build() {
    return;
  }

  Future<List<LanguageModel>> getLanguages() async {
    try {
      final result = await ref
          .read(adminRepositoryProvider)
          .getLanguages()
          .showErrorBy(this)
          .updateMetadataBy(this)
          .mapToValueOr(defaultValue: BaseListResponse<LanguageModel>())
          .asFuture();
      return result.items;
    } catch (e) {
      return [];
    }
  }

}

final languageControllerProvider = NotifierProvider.autoDispose<LanguageController, void>(() {
  return LanguageController();
});