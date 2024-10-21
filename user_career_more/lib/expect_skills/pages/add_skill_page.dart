import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/expect_skills/controllers/skill_controller.dart';

@RoutePage()
class AddSkillPage extends ConsumerStatefulWidget {
  const AddSkillPage({super.key});

  @override
  ConsumerState createState() => _AddSkillPageState();
}

class _AddSkillPageState extends ConsumerState<AddSkillPage> {

  @override
  Widget build(BuildContext context) {
    final skillState = ref.watch(skillControllerProvider);
    final skillController = ref.read(skillControllerProvider.notifier);

    return BaseScaffold(
        backgroundColor: AppColors.white3Color,
        customAppBar: BaseAppBarView(
          title: "Thêm kỹ năng",
        ),
        bottomView: Container(
          color: AppColors.white1Color,
          child: AppButton(
            isEnabled: skillState.canAddSkill,
            title: L.more.addExperienceTextButton,
            onPressed: () {
              skillController
                  .createSkill()
                  .then((value) => {
                if (value == true)
                  {
                    context.showSuccess(L.more.inforMessageSuccess),
                    skillController.clearSkill(),
                    NotificationCenter()
                        .postNotification(RawStringNotificationName('reloadListSkill')),
                    context.maybePop(),
                  }
              });
            },
          ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushRoute(const FilterCategoriesRoute());
                  },
                  child: TextFieldView.outsideBorder(
                    title: "Lĩnh vực",
                    placeholder: "Lĩnh vực",
                    isRequired: true,
                    validator: (_) => (skillState.isEmptyCategory),
                    errorText: () => L.more.errorEmpty,
                    initialText: skillState.nameCategory ?? "",
                  ).paddingOnly(top: 10),
                ),
                TextFieldView.outsideBorder(
                  title: "Tên kỹ năng",
                  placeholder: "Tên kỹ năng",
                  isRequired: true,
                  validator: (_) => skillState.isEmptyNameSkill,
                  errorText: () => L.more.errorEmpty,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  textFieldDidChange: (text){
                    skillController.setSkillName(text);
                  },
                ).paddingOnly(top: 12),
                TextFieldView.outsideBorder(
                  title: "Số năm kinh nghiệm",
                  placeholder: "Số năm kinh nghiệm",
                  isRequired: true,
                  validator: (_) => (skillState.isEmptyExperienceYear),
                  errorText: () => L.more.errorEmpty,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  inputType: TextInputType.number,
                  textFieldDidChange: (text){
                    int number = int.parse(text!);
                    skillController.setExperienceYear(number);
                  },
                ).paddingOnly(top: 12),
                CommonTextFieldView(
                  borderRadius: 18,
                  title: "Mô tả kỹ năng",
                  placeholder: "Mô tả kỹ năng",
                  isRequired: true,
                  lengthLimiter: CharacterLengthLimiter(length: 100),
                  validator: (_) => (skillState.isEmptySkillDescription),
                  errorText: () => L.more.errorEmpty,
                  textFieldDidChange: (text){
                    skillController.setSkillDescription(text);
                  },
                ).paddingOnly(top: 12),
                Text(
                  "Lưu ý:\n    +Thời lượng tư vấn là bội số của 15\n    +Giá tư vấn tối thiểu là 10,000đ",
                  style: ref.theme.mediumTextStyle.copyWith(
                    color: Colors.grey,
                  )
                ).paddingOnly(top: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldView.outsideBorder(
                        title: "Trực tiếp",
                        placeholder: "phút",
                        isRequired: true,
                        validator: (_) => (skillState.isEmptyTimeOffline),
                        errorText: () => L.more.errorInvalidMessage,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        inputType: TextInputType.number,
                        textFieldDidChange: (text){
                          int number = int.parse(text!);
                          skillController.setTimeOffline(number);
                        },
                      ).paddingOnly(top: 12),
                    ),
                    const Gap(12),
                    Expanded(
                      child: TextFieldView.outsideBorder(
                        title: "Giá Offline",
                        placeholder: "VND",
                        isRequired: true,
                        validator: (_) => (skillState.isEmptyPriceOffline),
                        errorText: () => L.more.errorInvalidMessage,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        inputType: TextInputType.number,
                        textFieldDidChange: (text){
                          int number = int.parse(text!);
                          skillController.setPriceOffline(number);
                        },
                      ).paddingOnly(top: 12),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldView.outsideBorder(
                        title: "Gọi điện",
                        placeholder: "phút",
                        isRequired: true,
                        validator: (_) => (skillState.isEmptyTimeOnline),
                        errorText: () => L.more.errorInvalidMessage,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        inputType: TextInputType.number,
                        textFieldDidChange: (text){
                          int number = int.parse(text!);
                          skillController.setTimeOnline(number);
                        },
                      ).paddingOnly(top: 12),
                    ),
                    const Gap(12),
                    Expanded(
                      child: TextFieldView.outsideBorder(
                        title: "Giá Online",
                        placeholder: "VND",
                        isRequired: true,
                        validator: (_) => (skillState.isEmptyPriceOnline),
                        errorText: () => L.more.errorInvalidMessage,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        inputType: TextInputType.number,
                        textFieldDidChange: (text){
                          int number = int.parse(text!);
                          skillController.setPriceOnline(number);
                        },
                      ).paddingOnly(top: 12),
                    ),
                  ],
                ).paddingOnly(bottom: 12),
              ],
            ).paddingSymmetric(horizontal: 12).makeColor(AppColors.white1Color)
        )
    );
  }
}
