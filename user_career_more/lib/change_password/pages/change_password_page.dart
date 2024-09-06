import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_appbar.dart';
import 'package:user_career_more/change_password/controllers/change_password_controller.dart';

@RoutePage()
class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.read(changePasswordControllerProvider.notifier);
    final state = ref.watch(changePasswordControllerProvider);
    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      onBack: () => context.maybePop(),
      customAppBar: CommonAppBar(
        centerTitle: true,
        titleText: "Thay đổi mật khẩu",
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    PasswordTextFieldView(
                      padding: const EdgeInsets.only(left: 10),
                      shouldShowBorder: false,
                      shouldShowOutsideBorder: true,
                      title: L.more.changePasswordOld,
                      placeholder: L.more.changePasswordHintText,
                      textFieldDidChange: (text) =>
                          controller.setOldPassword(text),
                      validator: (_) => (state.isEmptyOldPassword),
                      errorText: () => L.more.errorEmpty,
                    ).paddingSymmetric(horizontal: 12.0).paddingOnly(top: 12.0),
                    PasswordTextFieldView(
                      padding: const EdgeInsets.only(left: 10),
                      shouldShowBorder: false,
                      shouldShowOutsideBorder: true,
                      title: L.more.changePasswordNew,
                      textFieldDidChange: (text) =>
                          controller.setNewPassword(text),
                      placeholder: L.more.changePasswordHintText,
                      validator: (_) => (state.isEmptyNewPassword),
                      errorText: () => L.more.errorEmpty,
                    ).paddingSymmetric(horizontal: 12.0).paddingOnly(top: 12.0),
                    PasswordTextFieldView(
                      padding: const EdgeInsets.only(left: 10),
                      shouldShowBorder: false,
                      shouldShowOutsideBorder: true,
                      title: L.more.changePasswordEnter,
                      placeholder: L.more.changePasswordHintText,
                      textFieldDidChange: (text) =>
                          controller.setConfirmPassword(text),
                      validator: (_) => (state.isEmptyConfirmPassword),
                      errorText: () => L.more.errorEmpty,
                    ).paddingSymmetric(horizontal: 12.0).paddingOnly(top: 12.0),
                  ])
                  .paddingOnly(bottom: 12.0)
                  .makeColor(AppColors.white1Color)
                  .makeColor(AppColors.white5Color)
                  .paddingOnly(top: 12.0),
            ),
          ),
          Container(
            color: AppColors.white1Color,
            child: AppButton(
              isEnabled: ref.watch(changePasswordControllerProvider).isEmpty,
              title: L.more.changePasswordButton,
              onPressed: () {
                controller.changePassword();
              },
            ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
          )
        ],
      ),
    );
  }
}