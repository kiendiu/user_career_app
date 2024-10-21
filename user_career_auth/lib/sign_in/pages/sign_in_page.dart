import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/core/router.gm.dart';
import 'package:user_career_auth/sign_in/controllers/sign_in_controller.dart';
import 'package:user_career_core/user_career_core.dart';

@RoutePage()
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.white1Color,
      noAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAppLogo(),
            _buildTextFieldEmail(),
            _buildTextFieldPassword(),
            _buildTextButtonForgotPassword(),
            _buildButtonSignIn(),
            _buildTextButtonRegister(),
          ],
        ),
      ).center().paddingSymmetric(horizontal: 20.0),
    );
  }

  Widget _buildAppLogo() {
    return Column(
      children: [
        Assets.icons.icLogoKmad.svg(height: 80).marginOnly(bottom: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffECF4FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            L.auth.nameApp,
            style: ref.theme.defaultTextStyle
                .size(12)
                .weight(FontWeight.w600)
                .textColor(const Color(0xff1170FF)),
          ).paddingAll(6.0),
        ),
      ],
    ).marginOnly(bottom: 32);
  }

  Widget _buildTextFieldEmail() {
    return TextFieldView.outsideBorder(
      isRequired: true,
      padding: const EdgeInsets.only(left: 10, right: 10),
      title: L.auth.textFieldEmailTitle,
      placeholder: L.auth.textFieldEmailHint,
      textFieldDidChange: (text) => ref
          .read(signInControllerProvider.notifier)
          .updateUserName(text?.trim() ?? ""),
      errorText: () => L.common.errorCheckEmail,
      validator: (text) {
        return ref.read(signInControllerProvider).isUsernameValid;
      },
    ).marginOnly(bottom: 20);
  }
  Widget _buildTextFieldPassword() {
    return PasswordTextFieldView(
      shouldShowOutsideBorder: true,
      padding: const EdgeInsets.only(left: 10, right: 10),
      title: L.auth.textFieldPasswordTitle,
      placeholder: L.auth.textFieldPasswordHint,
      shouldShowBorder: false,
      textFieldDidChange: (text) => ref
          .read(signInControllerProvider.notifier)
          .updatePassword(text?.trim() ?? ""),
      errorText: () => L.common.errorCheckPassword,
      validator: (text) => ref.read(signInControllerProvider).isPasswordValid,
    ).marginOnly(bottom: 20);
  }
  Widget _buildTextButtonForgotPassword() {
    return IntrinsicWidth(
      child: Text(
        L.auth.textButtonForgotPasswordText,
        style: ref.theme.itemTextStyle.textColor(AppColors.main1Color),
      ).onTapWidget(() => context.router.push(const SendMailVerifyRoute())),
    ).align(Alignment.centerRight).marginOnly(bottom: 10.0);
  }
  Widget _buildButtonSignIn() {
    return Consumer(builder: (context, ref, child){
      return AppButton(
        title: L.auth.buttonSignInText,
        onPressed: () => _login(),
        isEnabled: ref.watch(signInControllerProvider).canLogin,
      ).marginOnly(bottom: 10);
    });
  }
  Widget _buildTextButtonRegister() {
    return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: L.auth.textMessageRegister,
              style: ref.theme.defaultTextStyle,
            ),
            TextSpan(
              text: " ",
              style: ref.theme.defaultTextStyle,
            ),
            TextSpan(
              text: L.auth.textButtonRegister,
              style: ref
                  .theme
                  .defaultTextStyle
                  .textColor(AppColors.main1Color),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.router.replaceAll(const [RegisterRoute()]);
                },
            ),
          ],
        )
    ).paddingOnly(top: 60);
  }

  void _login() {
    ref.read(signInControllerProvider.notifier).signIn().then((value) {
      if (value) {
        context.showSuccess(L.auth.signInSuccessfulText);
        NotificationCenter().postNotification(RawStringNotificationName("open_main_route"));
      }
    });
  }
}