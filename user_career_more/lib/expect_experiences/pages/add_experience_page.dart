import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_text_field_view.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/expect_experiences/controllers/expect_experiences_controller.dart';

@RoutePage()
class AddExperiencePage extends ConsumerStatefulWidget {
  const AddExperiencePage({super.key});

  @override
  ConsumerState createState() => _AddExperiencePageState();
}

class _AddExperiencePageState extends ConsumerState<AddExperiencePage> {

  bool isWorkingHere = false;

  @override
  Widget build(BuildContext context) {
    final expectExperienceState = ref.watch(expectExperiencesControllerProvider);
    final expectExperienceController = ref.read(expectExperiencesControllerProvider.notifier);

    return BaseScaffold(
      customAppBar: AppBar(
        title: Text(
          L.more.addExperienceTitle,
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
          title: L.more.addExperienceTextButton,
          onPressed: () {
            expectExperienceController
                .createExpectExperiences()
                .then((value) => {
              if (value == true)
              {
                context.showSuccess(L.more.inforMessageSuccess),
                expectExperienceController.clearExpectExperience(),
                NotificationCenter()
                    .postNotification(RawStringNotificationName('reloadListExperience')),
                context.maybePop(),
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
              validator: (_) => expectExperienceState.isEmptyCompany,
              errorText: () => L.more.errorEmpty,
              padding: const EdgeInsets.only(left: 14, right: 14),
              textFieldDidChange: (text){
                expectExperienceController.setExpectCompany(text);
              },
            ).paddingOnly(top: 12),
            GestureDetector(
              onTap: () {
                context.pushRoute(const FilterExperienceCategoriesRoute());
              },
              child: TextFieldView.outsideBorder(
                title: L.more.addExperienceTextFieldCategory,
                placeholder: L.more.addExperienceTextFieldCategory,
                isRequired: true,
                validator: (_) => (expectExperienceState.isEmptyCategory),
                errorText: () => L.more.errorEmpty,
                initialText: expectExperienceState.nameCategory ?? "",
              ).paddingOnly(top: 10),
            ),
            TextFieldView.outsideBorder(
              title: L.more.addExperienceTextFieldPosition,
              placeholder: L.more.addExperienceTextFieldPosition,
              isRequired: true,
              validator: (_) => (expectExperienceState.isEmptyPosition),
              errorText: () => L.more.errorEmpty,
              padding: const EdgeInsets.only(left: 14, right: 14),
              textFieldDidChange: (text){
                expectExperienceController.setExpectPosition(text);
              },
            ).paddingOnly(top: 12),
            DatePickerTextFieldView(
              title: L.more.addExperienceTextFieldStartDate,
              padding: const EdgeInsets.only(left: 14, right: 14),
              onConfirmSelectTime: (date) {
                expectExperienceController.setExpectStartTime(date);
              }
            ).paddingOnly(top: 12),
            Row(
              children: [
                Checkbox(
                  value: isWorkingHere,
                  onChanged: (bool? newValue) {
                    isWorkingHere = newValue ?? false;
                    ref.watch(expectExperiencesControllerProvider.notifier)
                        .setExpectCurrentlyWorking(isWorkingHere);
                  },
                ),
                Text(L.more.addExperienceAskWorkHere),
              ],
            ),
            DatePickerTextFieldView(
              title: L.more.addExperienceTextFieldEndDate,
              isDisabled: expectExperienceState.currentlyWorking ?? false,
              padding: const EdgeInsets.only(left: 14, right: 14),
              validator: (_) => (expectExperienceState.isValidateTimeRange),
              errorText: () => "Thời gian không hợp lệ !",
              onConfirmSelectTime: (date) {
                expectExperienceController.setExpectEndTime(date);
              }
            ).paddingOnly(top: 12),
            CommonTextFieldView(
              borderRadius: 18,
              title: L.more.addExperienceTextFieldDescription,
              placeholder: L.more.addExperienceTextFieldDescription,
              isRequired: true,
              lengthLimiter: CharacterLengthLimiter(length: 100),
              validator: (_) => (expectExperienceState.isEmptyJobDescription),
              errorText: () => L.more.errorEmpty,
              textFieldDidChange: (text){
                expectExperienceController.setExpectDescription(text);
              },
            ).paddingOnly(top: 12),
          ],
        ).paddingSymmetric(horizontal: 12)
      )
    );
  }
}