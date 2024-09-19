import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_appbar.dart';
import 'package:user_career_more/more/controllers/expect_controller.dart';

@RoutePage()
class ExpectPage extends ConsumerStatefulWidget {
  const ExpectPage({super.key});

  @override
  ConsumerState createState() => _ExpectPageState();
}

class _ExpectPageState extends ConsumerState<ExpectPage> {
  @override
  Widget build(BuildContext context) {
    final expectInformationState = ref.watch(expectInformationControllerProvider);
    final expectInformationController  = ref.watch(expectControllerProvider.notifier);

    return BaseScaffold(
      customAppBar: CommonAppBar(
        centerTitle: true,
        titleText: L.more.expectTitle,
        rightActions: [
          Text(L.more.expectTextButton).onTapWidget(() {
            expectInformationController.updateExpectInformation();
            ref.invalidate(expectInformationControllerProvider);
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
            TextFieldView.outsideBorder(
              initialText: expectInformationState.maybeWhen(
                data: (data) => data.languages?.map((lang) => lang.nameLanguage).join(', ') ?? '',
                orElse: () => L.more.expectAskCommunicateHint,
              ),
              suffixIcons: [
                const Icon(
                  Icons.arrow_drop_down_outlined,
                  color: AppColors.black1Color,
                ).onTapWidget((){})
              ],
            ).paddingOnly(bottom: 14.0),
            Text(
              L.more.expectAskYearOfExperience,
              style: ref.theme.bigTextStyle.weight(FontWeight.bold),
            ).paddingOnly(bottom: 10),
            TextFieldView.outsideBorder(
              initialText: expectInformationState.maybeWhen(
                data: (data) => data.experienceYears.toString(),
                orElse: () => '',
              ),
              textFieldDidChange: (value) {
                ref.read(expectControllerProvider.notifier)
                    .setExperienceYears(int.tryParse(value ?? ''));
              },
              borderRadius: 10.0,
            ).paddingOnly(bottom: 14.0),
            Text(
              L.more.expectAskSkill,
              style: ref.theme.bigTextStyle.weight(FontWeight.bold),
            ).paddingOnly(bottom: 10),
            TextFieldView.outsideBorder(
              initialText: expectInformationState.maybeWhen(
                data: (data) => data.skillDescription,
                orElse: () => '',
              ),
              textFieldDidChange: (value) {
                ref.read(expectControllerProvider.notifier).setSkillDescription(value);
              },
              borderRadius: 10.0,
            ).paddingOnly(bottom: 6.0),
            const Divider(),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.work_outline),
                    title: Text(L.more.expectListTileExperiences),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.build_outlined),
                    title: Text(L.more.expectListTileSkills),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.school_outlined),
                    title: Text(L.more.expectListTileCertificates),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.attach_money_outlined),
                    title: Text(L.more.expectListTilePrice),
                    onTap: () {},
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
}