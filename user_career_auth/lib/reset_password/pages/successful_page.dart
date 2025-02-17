import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/core/router.gm.dart';
import 'package:user_career_core/user_career_core.dart';

@RoutePage()
class SuccessfulPage extends ConsumerStatefulWidget {
  const SuccessfulPage({super.key});

  @override
  ConsumerState<SuccessfulPage> createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends ConsumerState<SuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      noAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.icSuccessful.svg(height: 150).marginOnly(bottom: 20),
          Text(
            L.auth.textPageTitleSuccessfulPage,
            style: ref.theme.itemPickerTitleTextStyle.weight(FontWeight.w800).textColor(AppColors.successColor),
          ).marginOnly(bottom: 20),
          Text(
            L.auth.textPageContentSuccessfulPage,
            style: ref.theme.itemTextStyle,
          ).marginOnly(bottom: 20),
          AppButton(
            title: L.auth.buttonNextText,
            onPressed: () => _comeBackSignIn(),
          ),
        ],
      ).center().paddingSymmetric(horizontal: 20),
    );
  }

  void _comeBackSignIn() => context.router.replaceAll([const SignInRoute()]);
}
