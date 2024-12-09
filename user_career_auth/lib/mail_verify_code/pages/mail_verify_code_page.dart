import 'package:auto_route/auto_route.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:user_career_auth/core/router.gm.dart';
import 'package:user_career_auth/mail_verify_code/controllers/countdown_timer.dart';
import 'package:user_career_auth/mail_verify_code/controllers/mail_verify_code_controller.dart';
import 'package:user_career_auth/send_email_verify/controllers/send_mail_verify_controller.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_appbar.dart';

@RoutePage()
class MailVerifyCodePage extends ConsumerStatefulWidget {
  const MailVerifyCodePage({super.key});

  @override
  ConsumerState<MailVerifyCodePage> createState() => _MailVerifyCodePageState();
}

class _MailVerifyCodePageState extends ConsumerState<MailVerifyCodePage>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(countdownTimerProvider.notifier);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      customAppBar: CommonAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L.auth.textPageTitleVerifyPage,
              style: ref.theme.itemPickerTitleTextStyle,
            ).marginOnly(top: 32, bottom: 12),
            Text(
              "${L.auth.textPageContentVerifyPage}"
              "${Storage.get(POSStorageKey.userNameKey)}."
              "\n${L.auth.textPageContentTimeVerifyPage}",
              style: ref.theme.itemTextStyle,
            ).marginOnly(bottom: 32),
            _buildTextFieldVerifyCode(),
            _buildButtonConfirmVerifyCode(),
            _buildResendMailVerifyCode(),
          ],
        ).paddingAll(20.0),
      ),
    );
  }

  Widget _buildTextFieldVerifyCode() {
    return PinInputTextField(
      pinLength: 6,
      decoration: BoxLooseDecoration(
        strokeColorBuilder: const FixedColorBuilder(AppColors.white5Color),
      ),
      cursor: Cursor(
        width: 2,
        color: AppColors.black1Color,
        enabled: true,
      ),
      onChanged: (pin) {
        return ref
            .read(mailVerifyCodeControllerProvider.notifier)
            .updateVerifyCode(Storage.get(POSStorageKey.userNameKey), pin);
      },
    ).marginOnly(bottom: 28);
  }

  Widget _buildButtonConfirmVerifyCode() {
    return Consumer(builder: (context, ref, child) {
      return AppButton(
        isEnabled:
            ref.watch(mailVerifyCodeControllerProvider).canSubmitVerifyCode,
        title: L.auth.buttonConfirmText,
        onPressed: () => _confirmVerifyCode(),
      );
    }).marginOnly(bottom: 20);
  }

  Widget _buildResendMailVerifyCode() {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: "${L.auth.textQuestionConfirmEmail} ",
        style: ref.theme.itemTextStyle,
      ),
      WidgetSpan(
          child: ref.watch(countdownTimerProvider.notifier).isTimerComplete
              ? _buildResendVerify()
              : _buildNonResendVerify()),
    ])).center();
  }

  Widget _buildNonResendVerify() {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: L.auth.textButtonResendEmailText,
        style: ref.theme.itemTextStyle,
      ),
      TextSpan(
        text: " (${ref.watch(countdownTimerProvider)}s)",
        style: ref.theme.itemTextStyle.textColor(AppColors.mainColor),
      ),
    ]));
  }

  Widget _buildResendVerify() {
    return RichText(
        text: TextSpan(
      text: L.auth.textButtonResendEmailText,
      style: ref.theme.itemTextStyle.textColor(AppColors.mainColor),
      recognizer: TapGestureRecognizer()..onTap = _resendMailVerifyCode,
    ));
  }

  void _resendMailVerifyCode() async {
    final sendController = ref.read(sendMailVerifyControllerProvider.notifier);
    ref.invalidate(countdownTimerProvider);
    ref.read(countdownTimerProvider.notifier).setInitialValue(60);
    ref.read(countdownTimerProvider.notifier).startTimer();
    sendController.updateEmail(Storage.get(POSStorageKey.userNameKey));
    sendController.sendMail();
  }

  void _confirmVerifyCode() async {
    ref
        .read(mailVerifyCodeControllerProvider.notifier)
        .sendMailVerifyCode()
        .then((value) {
      if (value) {
        ref.invalidate(countdownTimerProvider);
        context.router.push(const ResetPasswordRoute());
      }
    });
  }
}
