import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/more/controllers/expect_controller.dart';
import 'package:user_career_more/more/models/approval_enum.dart';
import 'package:user_career_more/more/models/language_model.dart';
import 'package:user_career_more/more/pages/views/approval_container_view.dart';

@RoutePage()
class ExpectPage extends ConsumerStatefulWidget {
  const ExpectPage({super.key});

  @override
  ConsumerState createState() => _ExpectPageState();
}

class _ExpectPageState extends ConsumerState<ExpectPage> {
  List<BaseSelectableItemModel<LanguageModel>> field = [];

  @override
  Widget build(BuildContext context) {
    final expectState = ref.watch(expectControllerProvider);
    final expectController  = ref.read(expectControllerProvider.notifier);
    final appBarController = BaseAppBarController();

    return BaseScaffold(
      customAppBar: BaseAppBarView(
        title: L.more.expectTitle,
        controller: appBarController,
      ),
      backgroundColor: AppColors.white3Color,
      bottomView: Container(
        color: AppColors.white1Color,
        child: AppButton(
          title: "Lưu thông tin",
          onPressed: () {
            expectController.updateExpectInformation().then((value) {
              context.showSuccess(L.more.messageChangeSuccessful);
            });
          },
        ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                "Bạn cần được duyệt từ quản trị viên để có thể đăng tải thông tin. \nHoặc bạn có thể thêm thông tin: \n\t\t +chứng chỉ \n\t\t + kỹ năng \n\t\t + kinh nghiệm \nvà gửi yêu cầu duyệt sau!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )
            ).paddingSymmetric(vertical: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Trạng thái: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ).paddingOnly(right: 8),
                ApprovalContainerView(expectState.approval ?? ApprovalEnum.user).paddingOnly(right: 100),
                Visibility(
                  visible: !(expectState.approval == ApprovalEnum.pending || expectState.approval == ApprovalEnum.accepted),
                  child: AppButton(
                    title: "Gửi yêu cầu",
                    onPressed: () {
                      ref.watch(expectInformationControllerProvider.notifier).submitRequireApprove().then(
                        (value){
                          context.showSuccess("Gửi yêu cầu duyệt thành công!");
                        }
                      );
                    },
                  ).box(h: 40),
                ).expand(),
              ]
            ),
            BaseWrapItemsSelectableView<BaseSelectableItemModel<LanguageModel>>(
              title: 'Ngôn ngữ',
              itemPickerTitle: "Chọn ngôn ngữ",
              textPlaceHolder: "Vui lòng Chọn",
              isRequired: false,
              items: expectState.listLanguages ?? [],
              isMultiSelection: true,
              onAddNewItems: (items) {
                expectController.setListLanguages(items);
              },
              onRemoveItem: (item) {
                field = expectState.listLanguages ?? [];
                field.remove(item);
                expectController.setListLanguages(field);
              },
              getItems: (int page) async {
                return expectController.getLanguagesBase();
              },
            ).paddingSymmetric(vertical: 12.0),
            TextFieldView.outsideBorder(
              title: "Số năm kinh nghiệm",
              initialText: expectState.experienceYears?.toString() ?? '',
              placeholder: "Vui lòng nhập",
              padding: const EdgeInsets.only(left: 14, right: 14),
              textFieldDidChange: (value){
                ref.read(expectControllerProvider.notifier)
                    .setExperienceYears(int.tryParse(
                    value ?? (expectState.experienceYears?.toString() ?? '')
                ));
              },
            ).paddingOnly(bottom: 12.0),
            TextFieldView.outsideBorder(
              title: "Mô tả kỹ năng",
              placeholder: "Vui lòng nhập",
              initialText: expectState.skillDescription ?? '',
              maxLength: 5,
              height: 50,
              isExpanded: true,
              lengthLimiter: CharacterLengthLimiter(length: 100),
              textFieldDidChange: (value) {
                ref.read(expectControllerProvider.notifier).setSkillDescription(
                    value ?? expectState.skillDescription ?? ''
                );
              },
              padding: const EdgeInsets.only(left: 14, right: 14),
            ).paddingOnly(bottom: 12.0),
            const Divider(),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.work_outline, color: AppColors.mainColor),
                    title: Text(L.more.expectListTileExperiences),
                    onTap: () {context.router.push(const ExpectExperiencesRoute());},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.build_outlined, color: AppColors.mainColor),
                    title: Text(L.more.expectListTileSkills),
                    onTap: () {context.router.push(const ExpectSkillsRoute());},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.school_outlined, color: AppColors.mainColor),
                    title: Text(L.more.expectListTileCertificates),
                    onTap: () {context.router.push(const ExpectCertificatesRoute());},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.attach_money_outlined, color: AppColors.mainColor),
                    title: Text(L.more.expectListTilePrice),
                    onTap: () {context.router.push(const ExpectPriceServiceRoute());},
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 14.0).makeColor(AppColors.white1Color),
      ),
    );
  }
}