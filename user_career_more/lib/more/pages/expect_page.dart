import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_appbar.dart';
import 'package:user_career_core/views/custom_text_field.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/more/controllers/expect_controller.dart';
import 'package:user_career_more/more/models/language_model.dart';
import 'package:user_career_more/more/pages/views/language_picker_view.dart';

@RoutePage()
class ExpectPage extends ConsumerStatefulWidget {
  const ExpectPage({super.key});

  @override
  ConsumerState createState() => _ExpectPageState();
}

class _ExpectPageState extends ConsumerState<ExpectPage> {
  Set<LanguageModel> languagesLocal = {};

  @override
  Widget build(BuildContext context) {
    final expectState = ref.watch(expectControllerProvider);
    final expectController  = ref.read(expectControllerProvider.notifier);

    return BaseScaffold(
      customAppBar: CommonAppBar(
        centerTitle: true,
        titleText: L.more.expectTitle,
        rightActions: [
          Text(L.more.expectTextButton).onTapWidget(() {
            expectController.updateExpectInformation();
          }).paddingOnly(right: 14.0)
        ],
      ),
      backgroundColor: AppColors.white1Color,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L.more.expectAskCommunicate,
              style: ref.theme.bigTextStyle.weight(FontWeight.bold),
            ).paddingOnly(top: 14, bottom: 10),
            TextField(
              controller: TextEditingController(
                text: expectState.languagesLocal?.map((lang) => lang.nameLanguage).join(', ') ?? '',
              ),
              readOnly: true,
              enabled: true,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.arrow_drop_down_outlined,
                  color: AppColors.black1Color,
                ).onTapWidget(() {
                  _showListCheckBoxLanguage(expectController);
                }),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: AppColors.black4Color,
                    width: 2.0,
                  ),
                ),
              ),
            ).paddingOnly(bottom: 14.0),
            Text(
              L.more.expectAskYearOfExperience,
              style: ref.theme.bigTextStyle.weight(FontWeight.bold),
            ).paddingOnly(bottom: 10),
            CustomTextFieldView(
                initialText: expectState.experienceYears?.toString() ?? '',
                textFieldDidChange: (value) {
                  ref.read(expectControllerProvider.notifier)
                      .setExperienceYears(int.tryParse(value ?? ''));
                },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: AppColors.black4Color,
                    width: 2.0,
                  ),
                ),
              ),
            ).paddingOnly(bottom: 14.0),
            Text(
              L.more.expectAskSkill,
              style: ref.theme.bigTextStyle.weight(FontWeight.bold),
            ).paddingOnly(bottom: 10),
            CustomTextFieldView(
              initialText: expectState.skillDescription ?? '',
              textFieldDidChange: (value) {
                ref.read(expectControllerProvider.notifier).setSkillDescription(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: AppColors.black4Color,
                    width: 2.0,
                  ),
                ),
              ),
              maxLines: 5,
            ).paddingOnly(bottom: 6.0),
            const Divider(),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.work_outline),
                    title: Text(L.more.expectListTileExperiences),
                    onTap: () {context.router.push(const ExpectExperiencesRoute());},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.build_outlined),
                    title: Text(L.more.expectListTileSkills),
                    onTap: () {context.router.push(const ExpectSkillsRoute());},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.school_outlined),
                    title: Text(L.more.expectListTileCertificates),
                    onTap: () {context.router.push(const ExpectCertificatesRoute());},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.attach_money_outlined),
                    title: Text(L.more.expectListTilePrice),
                    onTap: () {context.router.push(const ExpectPriceServiceRoute());},
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 14.0),
      ),
    );
  }

  void _showListCheckBoxLanguage(ExpectController controller) async {
    final languages = (await controller.getLanguages()).toSet();

    InteractiveSheet.fixedContent(
      LanguagePickerView(
        languages: languages,
        languagesLocal: languagesLocal,
        onSelectionChanged: (newSelectedLanguages) {
          setState(() {
            languagesLocal = newSelectedLanguages;
            controller.setLanguagesLocal(languagesLocal);
            controller.setLanguages(newSelectedLanguages.map((lang) => lang.id).cast<int>().toList());
          });
        },
      ),
      isFloating: false,
      canShowIndicator: false,
    ).show();
  }
}