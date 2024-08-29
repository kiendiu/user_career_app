import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/core/router.gm.dart';
import 'package:user_career_auth/reset_password/controllers/reset_password_controller.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/app_button.dart';
import 'package:user_career_core/views/common_appbar.dart';

@RoutePage()
class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(resetPasswordControllerProvider.notifier);
    return BaseScaffold(
      customAppBar: CommonAppBar(
        leading: BackButton(
          color: AppColors.black1Color,
          onPressed: () => context.router
              .replaceAll(const [SignInRoute(), SendMailVerifyRoute()])),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(L.auth.textPageTitleUpdatePasswordPage,
                    style: ref.theme.itemPickerTitleTextStyle)
                .marginOnly(top: 32, bottom: 12),
            Text(L.auth.textPageContentUpdatePasswordPage,
                    style: ref.theme.itemTextStyle)
                .marginOnly(bottom: 32),
            _buildTextFieldNewPassword(),
            _buildTextFieldConfirmPassword(),
            _buildButtonCreatePassword(),
          ],
        ).paddingSymmetric(horizontal: 20.0),
      ),
    );
  }

  Widget _buildTextFieldNewPassword() {
    return PasswordTextFieldView(
        shouldShowOutsideBorder: true,
        shouldShowBorder: false,
        title: L.auth.textFieldPasswordTitle,
        placeholder: L.auth.textFieldPasswordHint,
        padding: const EdgeInsets.only(left: 10, right: 10),
        textFieldDidChange: (text) {
          ref
              .read(resetPasswordControllerProvider.notifier)
              .updatePassword(text?.trim() ?? "");
        },
        errorText: () => L.common.errorCheckNewPassword,
        validator: (text) {
          return ref.read(resetPasswordControllerProvider).canPassword;
        }).marginOnly(bottom: 20);
  }

  Widget _buildTextFieldConfirmPassword() {
    return PasswordTextFieldView(
        shouldShowOutsideBorder: true,
        shouldShowBorder: false,
        title: L.auth.textFieldConfirmPasswordTitle,
        placeholder: L.auth.textFieldConfirmPasswordHint,
        padding: const EdgeInsets.only(left: 10, right: 10),
        textFieldDidChange: (text) {
          ref
              .read(resetPasswordControllerProvider.notifier)
              .updateConfirmPassword(text?.trim() ?? "");
        },
        errorText: () => L.common.errorCheckConfirmPassword,
        validator: (text) {
          return ref.read(resetPasswordControllerProvider).canConfirmPassword;
        }).marginOnly(bottom: 20);
  }

  Widget _buildButtonCreatePassword() {
    return AppButton(
      title: L.auth.buttonUpdatePasswordText,
      isEnabled: ref.watch(resetPasswordControllerProvider).canConfirmPassword,
      onPressed: () => _confirmUpdatePassword(),
    );
  }

  void _confirmUpdatePassword() async {
    ref
        .read(resetPasswordControllerProvider.notifier)
        .resetPassword()
        .then((value) {
      if (value) {
        context.router.push(const SuccessfulRoute());
      }
    });
  }
}
