import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/category_model.dart';
import 'package:user_career_auth/admin/repositories/admin_repository.dart';
import 'package:user_career_core/user_career_core.dart';

import 'category_info_controller.dart';

class CategoryController extends AutoDisposeNotifier<void>
  with AlertMixin, MetadataUpdater{
  @override
  void build() {
    return;
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final result = await ref
          .read(adminRepositoryProvider)
          .getCategories()
          .showErrorBy(this)
          .updateMetadataBy(this)
          .mapToValueOr(defaultValue: BaseListResponse<CategoryModel>())
          .asFuture();
      for (var item in result.items) {
        ref.read(categoryItemsProvider(item.categoryId).notifier).state = item;
      }
      return result.items;
    } catch (e) {
      return [];
    }
  }

}

final categoryControllerProvider = NotifierProvider.autoDispose<CategoryController, void>(() {
  return CategoryController();
});