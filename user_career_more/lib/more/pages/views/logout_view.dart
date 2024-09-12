import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';

class LogoutView extends ConsumerStatefulWidget {
  const LogoutView({super.key});

  @override
  ConsumerState<LogoutView> createState() => _LogoutPopupState();
}

class _LogoutPopupState extends ConsumerState<LogoutView> with AlertMixin {
  @override
  Widget build(BuildContext context) {
    return PopupView(
      backgroundColor: AppColors.white1Color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _titleLogout(),
          _logoutQuestion(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _cancelButton(),
              HSpace.h8,
              _logoutButton(),
            ],
          ),
        ],
      ).paddingSymmetric(vertical: 24, horizontal: 16),
    ).marginSymmetric(horizontal: 32);
  }

  Widget _cancelButton() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.white4Color,
    ),
    child: Text(
      L.more.cancel,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.black1Color,
        fontWeight: FontWeight.w500,
      ),
    )
        .paddingSymmetric(vertical: 17.5)
        .center()
        .onTapWidget(() => context.maybePop()),
  ).expand();

  Widget _logoutButton() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.errorColor,
    ),
    child: Text(L.more.logout,
        style: ref.theme.defaultTextStyle.copyWith(
          color: AppColors.white1Color,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        )).paddingSymmetric(vertical: 17.5).center().onTapWidget(
          () {
            context.maybePop().then(
                  (value) {
                showLoading();
                AuthManager.logout();
                Storage.removeOn(POSStorageKey.infoAvatarPath);
                Storage.removeOn(POSStorageKey.infoUserNameKey);
                Storage.removeOn(POSStorageKey.infoEmailKey);
                Storage.removeOn(POSStorageKey.infoPhoneKey);
                Storage.removeOn(POSStorageKey.infoAdressKey);
                AuthManager.logout();
                hideLoading();
                NotificationCenter()
                    .postNotification(RawStringNotificationName("log_out"));
              },
            );
      },
    ),
  ).expand();

  Widget _titleLogout() => Text(
    L.more.logout,
    style: ref.theme.defaultTextStyle.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: AppColors.black1Color,
    ),
    textAlign: TextAlign.center,
  );

  Widget _logoutQuestion() => Text(
    L.more.youDefinitelyWantToSignOut,
    style: ref.theme.defaultTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.black1Color,
    ),
    textAlign: TextAlign.center,
  ).paddingSymmetric(vertical: 16);
}
