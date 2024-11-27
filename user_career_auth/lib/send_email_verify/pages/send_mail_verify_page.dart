import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/core/router.gm.dart';
import 'package:user_career_auth/mail_verify_code/controllers/countdown_timer.dart';
import 'package:user_career_auth/send_email_verify/controllers/send_mail_verify_controller.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_appbar.dart';

@RoutePage()
class SendMailVerifyPage extends ConsumerStatefulWidget {
  const SendMailVerifyPage({super.key});

  @override
  ConsumerState<SendMailVerifyPage> createState() => _SendMailVerifyPageState();
}

class _SendMailVerifyPageState extends ConsumerState<SendMailVerifyPage> {

  @override
  Widget build(BuildContext context) {
    ref.watch(countdownTimerProvider.notifier);
    return BaseScaffold(
      customAppBar: CommonAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L.auth.textPageTitleResetPasswordPage,
              style: ref.theme.itemPickerTitleTextStyle,
            ).marginOnly(top: 32,bottom: 12),
            Text(
              L.auth.textPageContentResetPasswordPage,
              style: ref.theme.itemTextStyle,
            ).marginOnly(bottom: 40),
            _buildTextFieldEmail(),
            _buildButtonSendMail(),
          ],
        ).paddingAll(20.0),
      ),
    );
  }

  Widget _buildTextFieldEmail() {
    return TextFieldView.outsideBorder(
      title: L.auth.textFieldEmailTitle,
      placeholder: L.auth.textFieldEmailHint,
      padding: const EdgeInsets.only(left: 14, right: 14),
      textFieldDidChange: (text) {
        ref
            .read(sendMailVerifyControllerProvider.notifier)
            .updateEmail(text?.trim() ?? "");
      },
    ).marginOnly(bottom: 30);
  }
  Widget _buildButtonSendMail() {
    return Consumer(builder: (context, ref, child) {
      return AppButton(
        title: L.auth.buttonResetPasswordText,
        isEnabled: ref
            .watch(sendMailVerifyControllerProvider)
            .canSubmitLogin,
        onPressed: () => _sendMailVerify(),
      );
    });
  }

  void _sendMailVerify() async {
    if(ref.read(countdownTimerProvider.notifier).isTimerComplete) {
      ref.read(sendMailVerifyControllerProvider.notifier).sendMail()
          .then((value) =>{
        if(value) {
          Storage.save(
              POSStorageKey.userNameKey,
              ref
                  .read(sendMailVerifyControllerProvider)
                  .email
          ),
          ref.read(countdownTimerProvider.notifier).setInitialValue(60),
          ref.read(countdownTimerProvider.notifier).startTimer(),
          context.router.push(const MailVerifyCodeRoute()),
        }
      });
    }else{
      context.router.push(const MailVerifyCodeRoute());
    }
  }
}
