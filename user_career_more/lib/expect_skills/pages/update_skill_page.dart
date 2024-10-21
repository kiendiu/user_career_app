import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/expect_skills/controllers/update_skill_controller.dart';
import 'package:user_career_more/expect_skills/models/skill_response.dart';

@RoutePage()
class UpdateSkillPage extends ConsumerStatefulWidget {
  final SkillResponse skillResponse;
  const UpdateSkillPage({super.key, required this.skillResponse});

  @override
  ConsumerState createState() => _UpdateSkillPageState();
}

class _UpdateSkillPageState extends ConsumerState<UpdateSkillPage> {

  @override
  Widget build(BuildContext context) {
    final skillState = ref.watch(updateSkillControllerProvider(widget.skillResponse));
    final skillController = ref.watch(updateSkillControllerProvider(widget.skillResponse).notifier);

    return BaseScaffold(
        customAppBar: AppBar(
          title: const Text(
            "Chỉnh sửa kỹ năng",
            style: TextStyle(
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
            title: L.more.addExperienceTextButton,
            onPressed: () {
              skillController
                  .updateSkill()
                  .then((value) => {
                if (value == true)
                  {
                    context.showSuccess(L.more.inforMessageSuccess),
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
                    context.pushRoute(FilterUpdateCategoryRoute(skillResponse: widget.skillResponse));
                  },
                  child: TextFieldView.outsideBorder(
                    title: "Lĩnh vực",
                    placeholder: "Lĩnh vực",
                    isRequired: true,
                    validator: (_) => (skillState.isEmptyCategory),
                    errorText: () => L.more.errorEmpty,
                    initialText: skillState.nameCategory,
                  ).paddingOnly(top: 10),
                ),
                TextFieldView.outsideBorder(
                  title: "Tên kỹ năng",
                  placeholder: "Tên kỹ năng",
                  isRequired: true,
                  initialText: skillState.nameSkill,
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
                  validator: (_) => skillState.isEmptyExperienceYear,
                  errorText: () => L.more.errorEmpty,
                  isRequired: true,
                  initialText: skillState.experienceYear.toString(),
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  // inputType: TextInputType.number,
                  textFieldDidChange: (text){
                    skillController.setExperienceYear(int.parse(text!));
                  },
                ).paddingOnly(top: 12),
                CommonTextFieldView(
                  borderRadius: 18,
                  title: "Mô tả kỹ năng",
                  placeholder: "Mô tả kỹ năng",
                  isRequired: true,
                  initialText: skillState.skillDescription,
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
                        initialText: skillState.timeOffline.toString(),
                        validator: (_) => (skillState.isEmptyTimeOffline),
                        errorText: () => L.more.errorEmpty,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        // inputType: TextInputType.number,
                        textFieldDidChange: (text){
                          skillController.setTimeOffline(int.parse(text!));
                        },
                      ).paddingOnly(top: 12),
                    ),
                    const Gap(12),
                    Expanded(
                      child: TextFieldView.outsideBorder(
                        title: "Giá Offline",
                        placeholder: "VND",
                        isRequired: true,
                        initialText: skillState.priceOffline.toString(),
                        validator: (_) => (skillState.isEmptyPriceOffline),
                        errorText: () => L.more.errorEmpty,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        // inputType: TextInputType.number,
                        textFieldDidChange: (text){
                          skillController.setPriceOffline(int.parse(text!));
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
                        initialText: skillState.timeOnline.toString(),
                        validator: (_) => (skillState.isEmptyTimeOnline),
                        errorText: () => L.more.errorEmpty,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        // inputType: TextInputType.number,
                        textFieldDidChange: (text){
                          skillController.setTimeOnline(int.parse(text!));
                        },
                      ).paddingOnly(top: 12),
                    ),
                    const Gap(12),
                    Expanded(
                      child: TextFieldView.outsideBorder(
                        title: "Giá Online",
                        placeholder: "VND",
                        isRequired: true,
                        initialText: skillState.priceOnline.toString(),
                        validator: (_) => (skillState.isEmptyPriceOnline),
                        errorText: () => L.more.errorEmpty,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        // inputType: TextInputType.number,
                        textFieldDidChange: (text){
                          skillController.setPriceOnline(int.parse(text!));
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
