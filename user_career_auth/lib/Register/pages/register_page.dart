import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_career_auth/Register/controllers/register_controller.dart';
import 'package:user_career_auth/core/router.gm.dart';
import 'package:user_career_core/user_career_core.dart';

@RoutePage()
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: Colors.white,
      noAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextFieldUserName(),
                _buildTextFieldEmail(),
                _buildTextFieldPassword(),
                _buildButtonSignIn(),
                _buildXWebLogo()
              ],
            ),
          ).center().expand(),

        ],
      ).paddingSymmetric(horizontal: 20.0),
    );
  }

  Widget _buildTextFieldUserName() {
    return TextFieldView.outsideBorder(
      isRequired: true,
      title: 'Tên tài khoản',
      placeholder: L.auth.textFieldEmailHint,
      padding: const EdgeInsets.only(left: 10, right: 10),
      textFieldDidChange: (text) => ref
            .read(registerControllerProvider.notifier)
            .updateUsername(text?.trim() ?? ""),
    ).marginOnly(bottom: 20);
  }
  Widget _buildTextFieldEmail() {
    return TextFieldView.outsideBorder(
      isRequired: true,
      padding: const EdgeInsets.only(left: 10, right: 10),
      title: L.auth.textFieldEmailTitle,
      placeholder: L.auth.textFieldEmailHint,
      textFieldDidChange: (text) => ref
          .read(registerControllerProvider.notifier)
          .updateEmail(text?.trim() ?? ""),
      errorText: () => L.common.errorCheckEmail,
      validator: (text) {
        return ref.read(registerControllerProvider).isEmailValid;
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
          .read(registerControllerProvider.notifier)
          .updatePassword(text?.trim() ?? ""),
      errorText: () => L.common.errorCheckPassword,
      validator: (text) => ref.read(registerControllerProvider).isPasswordValid,
    ).marginOnly(bottom: 20);
  }
  Widget _buildButtonSignIn() {
    return Consumer(
      builder: (context, ref, child) {
        return AppButton(
          isEnabled: ref.watch(registerControllerProvider).canRegister,
          title: L.auth.buttonSignInText,
          color: AppColors.main1Color,
          onPressed: () => _register(),
        );
      },
    );
  }
  Widget _buildXWebLogo() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Bạn đã có tài khoản? ',
            style: ref.theme.defaultTextStyle,
          ),
          TextSpan(
            text: ' Đăng nhập',
            style:
                ref.theme.defaultTextStyle.textColor(AppColors.main1Color),
            recognizer: TapGestureRecognizer()
                ..onTap = ()=>
                    context.router.replaceAll(const [SignInRoute()]),
          ),
        ],
      ),
    ).paddingOnly(top: 60);
  }

  void callPhoneNumber(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _register() async =>
      ref.read(registerControllerProvider.notifier).signInId().then((success) {
        if (success) {
          context.router.replaceAll(const [SignInRoute()]);
        }
      });
}
