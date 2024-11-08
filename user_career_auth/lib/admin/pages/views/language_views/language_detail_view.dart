import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/controllers/language_controllers/language_detail_controller.dart';
import 'package:user_career_auth/admin/models/language_model.dart';
import 'package:user_career_core/user_career_core.dart';

class LanguageDetailView extends ConsumerStatefulWidget {
  final LanguageModel? languageModel;
  const LanguageDetailView({super.key, this.languageModel});

  @override
  ConsumerState createState() => _LanguageDetailViewState();
}

class _LanguageDetailViewState extends ConsumerState<LanguageDetailView> with AlertMixin{
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(languageDetailControllerProvider(widget.languageModel));
    final controller = ref.watch(languageDetailControllerProvider(widget.languageModel).notifier);
    return PopupView(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.isEdit
                  ? "Chỉnh sửa ngôn ngữ"
                  : "Thêm ngôn ngữ",
              style: ref.theme.defaultTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: AppColors.black1Color,
              ),
              textAlign: TextAlign.center,
            ),
            TextFieldView.outsideBorder(
              isRequired: true,
              title: "Tên ngôn ngữ",
              placeholder: "Vui lòng nhập",
              initialText: state.editLanguageModel?.nameLanguage,
              textFieldDidChange: (text){
                controller.updateLanguage(state.editLanguageModel!.copyWith(nameLanguage: text));
              },
            ).paddingSymmetric(vertical: 10),
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
                        RawStringNotificationName("reloadLanguageListView"));
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
