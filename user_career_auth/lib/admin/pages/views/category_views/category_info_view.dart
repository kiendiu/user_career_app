import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/controllers/category_controllers/category_info_controller.dart';
import 'package:user_career_auth/admin/models/category_model.dart';
import 'package:user_career_core/user_career_core.dart';
import 'category_detail_view.dart';

class CategoryInfoView extends ConsumerStatefulWidget {
  final CategoryFullModel category;
  const CategoryInfoView({super.key, required this.category});

  @override
  ConsumerState createState() => _ProductInfoViewState();
}

class _ProductInfoViewState extends ConsumerState<CategoryInfoView> {
  final _controller = SwipeActionController();

  @override
  Widget build(BuildContext context) {
    final categoryInfoState = ref.watch(categoryInfoControllerProvider(
        widget.category));
    return BaseTableViewCell(
      swipeActionController: _controller,
      rightActions: _rightActions,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryInfoState.categoryModel.nameCategory ?? '-',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: ref.theme.defaultTextStyle,
              ).paddingOnly(right: 10),
              RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Danh mục cha: ",
                        style: ref.theme.smallTextStyle
                            .textColor(Colors.grey)),
                    TextSpan(
                        text: categoryInfoState.parentCategoryModel?.nameCategory ?? '-',
                        style: ref.theme.smallTextStyle
                            .textColor(AppColors.mainColor)),
                  ])).marginOnly(top: 4),
            ],
          ).marginOnly(left: 8).expand(),
        ],
      )
          .paddingSymmetric(horizontal: 16, vertical: 12)
          .makeColor(AppColors.white1Color),
    ).onTapWidget(() {
      context.showOverlay(CategoryDetailView(categoryFullModel: widget.category));
    });
  }

  List<SwipeAction> get _rightActions => [
    SwipeAction(
        color: AppColors.errorColor,
        onTap: (_) {
          _controller.closeAllOpenCell();
          context.showOverlay(BaseConfirmPopupView.warning(
            title: "Xoá danh mục",
            message: "Bạn có chắc chắn muốn xoá danh mục này không?",
            confirmText: "Đồng ý",
            cancelText: "Quay lại",
            onConfirm: () {
              ref.watch(categoryInfoControllerProvider(widget.category).notifier).deleteCategory(
                () {
                  NotificationCenter().postNotification(
                      RawStringNotificationName("deleteItemCategory"),
                      widget.category);
                  context.showSuccess("Xoá danh mục thành công!");
                },
                () {
                  context.showOverlay(
                    const BaseConfirmPopupView.remind(
                      title: "Xoá danh mục",
                      message: "Danh mục này đang, bạn không thể xoá danh mục này!",
                      confirmText:"Đóng",
                    ),
                  );
                }
              );
            }));
        },
        content: Assets.icons.icTrash
            .svg(
            colorFilter:
            const ColorFilter.mode(Colors.white, BlendMode.srcIn))
            .squareBox(edgeSize: 24)), //Assets.icons.icAppBarEdit.svg().squareBox(edgeSize: 24)),
  ];
}