import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/controllers/category_controllers/category_detail_controller.dart';
import 'package:user_career_auth/admin/models/category_model.dart';
import 'package:user_career_core/user_career_core.dart';

class CategoryDetailView extends ConsumerStatefulWidget {
  final CategoryFullModel? categoryFullModel;
  const CategoryDetailView({
    super.key,
    this.categoryFullModel,
  });

  @override
  ConsumerState createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends ConsumerState<CategoryDetailView> with AlertMixin{
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryDetailControllerProvider(widget.categoryFullModel));
    final controller = ref.watch(categoryDetailControllerProvider(widget.categoryFullModel).notifier);
    return PopupView(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.isEdit
                  ? "Chỉnh sửa danh mục"
                  : "Thêm danh mục",
              style: ref.theme.defaultTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: AppColors.black1Color,
              ),
              textAlign: TextAlign.center,
            ),
            TextFieldView.outsideBorder(
              isRequired: true,
              title: "Tên danh mục",
              placeholder: "Vui lòng nhập",
              initialText: state.editCategoryModel?.nameCategory,
              textFieldDidChange: (text){
                controller.updateCategoryState(state.editCategoryModel!.copyWith(nameCategory: text));
              },
            ).paddingSymmetric(vertical: 10),
            BaseWrapItemsSelectableView<BaseSelectableItemModel<CategoryModel>>(
                title: "Danh mục cha",
                itemPickerTitle: "Chọn danh mục",
                textPlaceHolder: "Vui lòng Chọn",
                isRequired: true,
                items: state.parentCategoryList,
                isMultiSelection: false,
                onAddNewItems: (items) {
                  state.parentCategoryList.clear();
                  state.parentCategoryList.addAll(items);
                  controller.updateCategoryState(state.editCategoryModel!.copyWith(parentId: items.first.id));
                },
                onRemoveItem: (item) {
                  state.parentCategoryList.remove(item);
                  controller.updateCategoryState(state.editCategoryModel!.copyWith(parentId: null));
                },
                getItems: (int page) async {
                  return controller.getCategoriesParent();
                }
            ).paddingOnly(bottom: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.mainColor,
              ),
              child: Text(
                state.isEdit
                    ? "Cập nhật"
                    : "Thêm mới",
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.white1Color,
                  fontWeight: FontWeight.w500,
                ),
              )
                  .paddingSymmetric(vertical: 17.5)
                  .center()
                  .onTapWidget(() {
                    controller.addOrEditCategory().then((value) {
                      if (value) {
                        NotificationCenter().postNotification(
                            RawStringNotificationName("reloadCategoryListView"));
                        context.maybePop();
                      }
                    });
                }
              ),
            ),
          ],
        ).paddingSymmetric(vertical: 24, horizontal: 16),
      ),
    );
  }
}
