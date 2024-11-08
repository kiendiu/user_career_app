import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/controllers/language_controllers/language_info_controller.dart';
import 'package:user_career_auth/admin/models/language_model.dart';
import 'package:user_career_core/user_career_core.dart';

import 'language_detail_view.dart';

class LanguageInfoView extends ConsumerStatefulWidget {
  final LanguageModel languageModel;
  const LanguageInfoView({super.key, required this.languageModel});

  @override
  ConsumerState createState() => _LanguageInfoViewState();
}

class _LanguageInfoViewState extends ConsumerState<LanguageInfoView> {
  final _controller = SwipeActionController();

  @override
  Widget build(BuildContext context) {
    final languageInfoState = ref.watch(languageInfoControllerProvider(
        widget.languageModel));
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
                languageInfoState.nameLanguage ?? '-',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: ref.theme.defaultTextStyle,
              ).paddingOnly(right: 10),
            ],
          ).marginOnly(left: 8).expand(),
        ],
      )
          .paddingSymmetric(horizontal: 16, vertical: 12)
          .makeColor(AppColors.white1Color),
    ).onTapWidget(() {
      context.showOverlay(LanguageDetailView(languageModel: widget.languageModel));
    });
  }

  List<SwipeAction> get _rightActions => [
    SwipeAction(
        color: AppColors.errorColor,
        onTap: (_) {
          _controller.closeAllOpenCell();
          context.showOverlay(BaseConfirmPopupView.warning(
              title: "Xoá ngôn ngữ",
              message: "Bạn có chắc chắn muốn xoá ngôn ngữ này không?",
              confirmText: "Đồng ý",
              cancelText: "Quay lại",
              onConfirm: () {
                ref.watch(languageInfoControllerProvider(widget.languageModel).notifier).deleteLanguage(
                        () {
                      NotificationCenter().postNotification(
                          RawStringNotificationName("deleteItemCategory"),
                          widget.languageModel);
                      context.showSuccess("Xoá ngôn ngữ thành công!");
                    },
                        () {
                      context.showOverlay(
                        const BaseConfirmPopupView.remind(
                          title: "Xoá danh mục",
                          message: "Danh mục này đang, bạn không thể xoá ngôn ngữ này!",
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
