import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/category_model.dart';
import 'package:user_career_auth/admin/repositories/admin_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class CategoryDetailController extends AutoDisposeFamilyNotifier<CategoryDetailState, CategoryFullModel?>
 with AutoDisposeFamilyNotifierUpdateMixin, AlertMixin, MetadataUpdater{
  @override
  CategoryDetailState build(CategoryFullModel? arg) {
    if(arg.isNotNull){
      return CategoryDetailState.fromCategoryModel(
        editCategoryModel: arg?.categoryModel,
        parentEditCategoryModel: arg?.parentCategoryModel,
      );
    }
    return CategoryDetailState(
      editCategoryModel: CategoryModel(),
      parentEditCategoryModel: CategoryModel(),
      isEdit: false
    );
  }

  Future<List<BaseSelectableItemModel<CategoryModel>>> getCategoriesParent() async {
    try {
      final result = await ref
          .read(adminRepositoryProvider)
          .getCategoriesParent()
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result.map((element) {
        return BaseSelectableItemModel<CategoryModel>(
          data: element,
          id: element.categoryId,
          name: element.nameCategory,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> addOrEditCategory() async {
    final category = state.editCategoryModel?.copyWith(
      nameCategory: state.editCategoryModel?.nameCategory,
      categoryId: state.editCategoryModel?.categoryId,
      parentId: state.parentEditCategoryModel?.categoryId,
    );
    if (state.isEdit) {
      if (category?.categoryId == null) return false;
      final result = await ref.read(adminRepositoryProvider)
          .updateCategory(category!)
          .showErrorBy(this)
          .hideLoadingBy(this)
          .showSuccessBy(this, message: "Cập nhật thành công")
          .isSuccess();
      return result;
    } else {
      final result = await ref.read(adminRepositoryProvider)
          .createCategory(category!)
          .showErrorBy(this)
          .hideLoadingBy(this)
          .showSuccessBy(this, message: "Thêm mới thành công")
          .isSuccess();
      return result;
    }
  }
  void updateCategoryState(CategoryModel categoryModel){
    update((state) => state.copyWith(editCategoryModel: categoryModel));
  }

  void updateParentCategoryState(CategoryModel parentCategoryModel){
    update((state) => state.copyWith(parentEditCategoryModel: parentCategoryModel));
  }
}

final categoryDetailControllerProvider = NotifierProvider.autoDispose
    .family<CategoryDetailController, CategoryDetailState, CategoryFullModel?>(
        () => CategoryDetailController());

class CategoryDetailState{
  final bool isEdit;
  final CategoryModel? editCategoryModel;
  final CategoryModel? parentEditCategoryModel;
  final List<BaseSelectableItemModel<CategoryModel>> parentCategoryList;

  CategoryDetailState.fromCategoryModel({
    required this.editCategoryModel,
    required this.parentEditCategoryModel,
  })  : isEdit = true,
        parentCategoryList = [
          BaseSelectableItemModel<CategoryModel>(
            data: parentEditCategoryModel ?? CategoryModel(),
            id: parentEditCategoryModel?.categoryId,
            name: parentEditCategoryModel?.nameCategory,
          )
        ];
  CategoryDetailState({
    this.isEdit = false,
    this.editCategoryModel,
    this.parentEditCategoryModel,
    this.parentCategoryList = const [],
  });

  CategoryDetailState copyWith({
    bool? isEdit,
    CategoryModel? editCategoryModel,
    CategoryModel? parentEditCategoryModel,
    List<BaseSelectableItemModel<CategoryModel>>? parentCategoryList,
  }) {
    return CategoryDetailState(
      isEdit: isEdit ?? this.isEdit,
      editCategoryModel: editCategoryModel ?? this.editCategoryModel,
      parentEditCategoryModel: parentEditCategoryModel ?? this.parentEditCategoryModel,
      parentCategoryList: parentCategoryList ?? this.parentCategoryList,
    );
  }
}