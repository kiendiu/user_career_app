import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_text_field_view.dart';
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
        customAppBar: AppBar(
          title: const Text(
            "Thêm kỹ năng",
            style: const TextStyle(
              color: AppColors.white1Color,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          leading: const BackButton(color: AppColors.white1Color),
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
                Row(
                  children: [
                    Expanded(
                      child: TextFieldView.outsideBorder(
                        title: "Trực tiếp",
                        placeholder: "phút",
                        isRequired: true,
                        validator: (_) => (skillState.isEmptyTimeOffline),
                        errorText: () => L.more.errorEmpty,
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
                        errorText: () => L.more.errorEmpty,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        inputType: TextInputType.number,
                        textFieldDidChange: (text){
                          double number = double.parse(text!);
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
                        errorText: () => L.more.errorEmpty,
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
                        errorText: () => L.more.errorEmpty,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        inputType: TextInputType.number,
                        textFieldDidChange: (text){
                          double number = double.parse(text!);
                          skillController.setPriceOnline(number);
                        },
                      ).paddingOnly(top: 12),
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 12)
        )
    );
  }
}
