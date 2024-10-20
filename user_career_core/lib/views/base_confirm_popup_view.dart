import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';

enum ConfirmType {
  success,
  warning,
  remind,
  error,
  custom;

  Widget get icon => switch (this) {
    ConfirmType.success => Assets.icons.icAlertDialogSuccess.svg(),
    ConfirmType.warning => Assets.icons.icAlertDialogWarning.svg(),
    ConfirmType.remind => Assets.icons.icAlertDialogWarning.svg(),
    ConfirmType.error => Assets.icons.icAlertDialogError.svg(),
    _ => const SizedBox.shrink()
  };
}

class BaseConfirmPopupView extends ConsumerWidget with GlobalThemePlugin {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Widget? titleWidget;
  final Widget? messageWidget;
  final Function()? onConfirm;
  final ConfirmType type;
  final List<ConfirmPopupViewButton> buttons;
  final double? width;

  const BaseConfirmPopupView.warning({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    this.cancelText = '',
    this.width,
    required this.onConfirm,
  })  : type = ConfirmType.warning,
        buttons = const [],
        titleWidget = null,
        messageWidget = null;

  const BaseConfirmPopupView.remind({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    this.width,
    this.onConfirm,
  })  : type = ConfirmType.remind,
        buttons = const [],
        titleWidget = null,
        cancelText = '',
        messageWidget = null;

  const BaseConfirmPopupView.success(
      {super.key,
        this.title = "",
        this.message = "",
        required this.confirmText,
        this.cancelText = '',
        this.width,
        required this.onConfirm})
      : type = ConfirmType.success,
        buttons = const [],
        titleWidget = null,
        messageWidget = null;

  const BaseConfirmPopupView.error({
    super.key,
    this.title = "",
    this.message = "",
    required this.confirmText,
    this.cancelText = '',
    this.width,
    required this.onConfirm,
  })  : type = ConfirmType.error,
        buttons = const [],
        titleWidget = null,
        messageWidget = null;

  const BaseConfirmPopupView.custom(
      {super.key,
        this.title = "",
        this.message = "",
        this.titleWidget,
        this.messageWidget,
        this.width,
        this.buttons = const []})
      : type = ConfirmType.custom,
        confirmText = '',
        cancelText = '',
        onConfirm = null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupView(
        width: width ?? context.width * 0.8,
        child: SeparatedColumn(
          separatorBuilder: (_, __) => const Gap(16),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _title,
            type.icon,
            _message,
            _buttonConfirms,
          ],
        ).paddingSymmetric(vertical: 24, horizontal: 16));
  }

  Widget get _title =>
      titleWidget ??
          Text(title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.black1Color,
              ),)
              .center();

  Widget get _message =>
      messageWidget ??
          Text(message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.black1Color,
              ),
              textAlign: TextAlign.center)
              .center();

  Widget get _buttonConfirms => SeparatedRow(
    separatorBuilder: (_, __) => const Gap(8),
    children: [
      if (type == ConfirmType.warning) ...[
        if (cancelText.isNotEmpty)
          ConfirmPopupViewButton(
            title: cancelText,
            titleColor: AppColors.black1Color,
            background: AppColors.white4Color,
            callback: () => appRouter.maybePop(),
          ).expand(),
        ConfirmPopupViewButton(
          title: confirmText,
          titleColor: Colors.white,
          background: Colors.red,
          callback: () async {
            await appRouter.maybePop();
            onConfirm?.call();
          },
        ).expand(),
      ] else if (type == ConfirmType.remind) ...[
        ConfirmPopupViewButton(
          title: confirmText,
          titleColor: Colors.white,
          background: AppColors.mainColor,
          callback: () async {
            await appRouter.maybePop();
            onConfirm?.call();
          },
        ).expand(),
      ] else if (type == ConfirmType.success) ...[
        if (cancelText.isNotEmpty)
          ConfirmPopupViewButton(
            title: cancelText,
            titleColor: AppColors.black1Color,
            background: AppColors.white4Color,
            callback: () => appRouter.maybePop(),
          ).expand(),
        ConfirmPopupViewButton(
          title: confirmText,
          titleColor: Colors.white,
          background: AppColors.mainColor,
          callback: () async {
            await appRouter.maybePop();
            onConfirm?.call();
          },
        ).expand(),
      ] else if (type == ConfirmType.error) ...[
        if (cancelText.isNotEmpty)
          ConfirmPopupViewButton(
            title: cancelText,
            titleColor: AppColors.black1Color,
            background: AppColors.white4Color,
            callback: () => appRouter.maybePop(),
          ).expand(),
        ConfirmPopupViewButton(
          title: confirmText,
          titleColor: Colors.white,
          background: Colors.redAccent,
          callback: () async {
            await appRouter.maybePop();
            onConfirm?.call();
          },
        ).expand(),
      ] else if (type == ConfirmType.custom)
        ...buttons.map((element) => element.expand())
    ],
  );
}

class ConfirmPopupViewButton extends StatelessWidget with GlobalThemePlugin {
  final String title;
  final Color titleColor;
  final Color background;
  final Function? callback;

  const ConfirmPopupViewButton(
      {super.key,
        required this.title,
        required this.titleColor,
        required this.background,
        this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(
          color: Colors.transparent,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(title,
          textAlign: TextAlign.center,
          style:TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: titleColor,
          )),
    ).onTapWidget(() {
      callback?.call();
    }, radius: 12);
  }
}
