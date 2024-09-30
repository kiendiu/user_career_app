import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_text_field_view.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/expect_experiences/controllers/edit_experience_controller.dart';
import 'package:user_career_more/expect_experiences/models/expect_experience_response.dart';

@RoutePage()
class EditExperiencePage extends ConsumerStatefulWidget {
  final ExpectExperienceResponse expectExperienceResponse;
  const EditExperiencePage({super.key, required this.expectExperienceResponse});

  @override
  ConsumerState createState() => _EditExperiencePageState();
}

class _EditExperiencePageState extends ConsumerState<EditExperiencePage> {

  bool isWorkingHere = false;

  @override
  void initState() {
    super.initState();
    isWorkingHere = widget.expectExperienceResponse.currentlyWorking == 1;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editExperienceControllerProvider(widget.expectExperienceResponse));
    final controller = ref.watch(editExperienceControllerProvider(widget.expectExperienceResponse).notifier);

    return BaseScaffold(
        customAppBar: AppBar(
          title: const Text(
            "Chỉnh sửa kinh nghiệm",
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
            isEnabled: true,
            title: L.more.addExperienceTextButton,
            onPressed: () {
              controller.updateExpectExperiences().then((value) {
                if (value == true) {
                  context.showSuccess(L.more.inforMessageSuccess);
                  NotificationCenter()
                      .postNotification(RawStringNotificationName('reloadListExperience'));
                  context.maybePop();
                }
              });
            },
          ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldView.outsideBorder(
                  title: L.more.addExperienceTextFieldCompany,
                  placeholder: L.more.addExperienceTextFieldCompany,
                  isRequired: true,
                  errorText: () => L.more.errorEmpty,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  initialText: state.company,
                  textFieldDidChange: (text){
                    controller.setExpectCompany(text);
                  },
                ).paddingOnly(top: 12),
                GestureDetector(
                  onTap: () {
                    context.pushRoute(FilterEditCategoryRoute(
                      expectExperienceResponse: widget.expectExperienceResponse,
                    ));
                  },
                  child: TextFieldView.outsideBorder(
                    initialText: state.nameCategory,
                    title: L.more.addExperienceTextFieldCategory,
                    placeholder: L.more.addExperienceTextFieldCategory,
                    isRequired: true,
                  ).paddingOnly(top: 10),
                ),
                TextFieldView.outsideBorder(
                  title: L.more.addExperienceTextFieldPosition,
                  placeholder: L.more.addExperienceTextFieldPosition,
                  isRequired: true,
                  errorText: () => L.more.errorEmpty,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  initialText: state.position,
                  textFieldDidChange: (text){
                    controller.setExpectPosition(text);
                  },
                ).paddingOnly(top: 12),
                DatePickerTextFieldView(
                    title: L.more.addExperienceTextFieldStartDate,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    initialDateTime: () => DateTime.parse(state.startTime ?? ''),
                    onConfirmSelectTime: (date) {
                      controller.setExpectStartTime(date);
                    }
                ).paddingOnly(top: 12),
                Row(
                  children: [
                    Checkbox(
                      value: isWorkingHere,
                      onChanged: (bool? newValue) {
                        isWorkingHere = newValue ?? false;
                        controller.setExpectCurrentlyWorking(isWorkingHere);
                      },
                    ),
                    Text(L.more.addExperienceAskWorkHere),
                  ],
                ),
                DatePickerTextFieldView(
                    title: L.more.addExperienceTextFieldEndDate,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    errorText: () => "Thời gian không hợp lệ !",
                    isDisabled: state.currentlyWorking ?? false,
                    initialDateTime: () => state.currentlyWorking == true ? null : DateTime.parse(state.endTime ?? ''),
                    onConfirmSelectTime: (date) {
                      controller.setExpectEndTime(date);
                    }
                ).paddingOnly(top: 12),
                CommonTextFieldView(
                  borderRadius: 18,
                  title: L.more.addExperienceTextFieldDescription,
                  placeholder: L.more.addExperienceTextFieldDescription,
                  isRequired: true,
                  initialText: state.jobDescription,
                  lengthLimiter: CharacterLengthLimiter(length: 100),
                  errorText: () => L.more.errorEmpty,
                  textFieldDidChange: (text){
                    controller.setExpectDescription(text);
                  },
                ).paddingOnly(top: 12),
              ],
            ).paddingSymmetric(horizontal: 12)
        )
    );
  }
}
