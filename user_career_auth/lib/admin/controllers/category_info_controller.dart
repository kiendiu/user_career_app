import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/category_model.dart';
import 'package:user_career_auth/admin/repositories/admin_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class CategoryInfoController
    extends AutoDisposeFamilyNotifier<CategoryFullModel, CategoryFullModel>
    with AlertMixin{
  @override
  CategoryFullModel build(CategoryFullModel arg) {
    return arg;
  }

  Future<void> deleteCategory(Function() onSuccess, Function() onRemind) async {
    final result = await ref
        .read(adminRepositoryProvider)
        .deleteCategory(state.categoryModel.categoryId ?? 0)
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

  void setCategoryModel(CategoryModel categoryModel){
    state = state.copyWith(categoryModel: categoryModel);
  }

  void setParentCategoryModel(CategoryModel parentCategoryModel){
    state = state.copyWith(parentCategoryModel: parentCategoryModel);
  }
}

final categoryInfoControllerProvider = NotifierProvider.autoDispose
    .family<CategoryInfoController, CategoryFullModel, CategoryFullModel>(
        () => CategoryInfoController());

final categoryItemsProvider = StateProvider.family<CategoryModel?, int?>((ref, int? arg) {
  return null;
},);