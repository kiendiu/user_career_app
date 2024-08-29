import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:user_career_core/common/gen/colors.gen.dart';

enum AppButtonPressState { none, longPressed, pressed, released }

class AppButton extends ConsumerWidget {
  String title;
  bool isEnabled;
  bool shouldEnableHapticFeedback;
  Color? color;
  TextStyle? titleTextStyle;
  Widget? icon;
  BorderRadiusGeometry? borderRadius;
  Function() onPressed;

  final appButtonPressStateProvider =
      StateProvider<AppButtonPressState>((ref) => AppButtonPressState.none);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () {
        ref.read(appButtonPressStateProvider.notifier).state =
            AppButtonPressState.longPressed;
      },
      onLongPressEnd: (details) {
        _onPressed(ref);
      },
      onTap: () {
        ref.read(appButtonPressStateProvider.notifier).state =
            AppButtonPressState.pressed;
        _onPressed(ref);
      },
      child: Consumer(
        builder: (context, provider, child) {
          var state = ref.watch(appButtonPressStateProvider);

          if (!isEnabled) {
            state = AppButtonPressState.none;
          }

          return AnimatedScale(
            scale: state == AppButtonPressState.released ||
                    state == AppButtonPressState.none
                ? 1
                : 0.96,
            duration: const Duration(milliseconds: 70),
            child: AnimatedOpacity(
              opacity: isEnabled ? 1 : 0.5,
              duration: 300.milliseconds,
              child: Container(
                decoration: ShapeDecoration(
                    color: color ?? AppColors.main1Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: borderRadius ?? 8.0.borderAll(),
                    )),
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) icon!,
                    if (icon != null) HSpace(8),
                    Text(
                      title,
                      style: titleTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future _onPressed(WidgetRef ref) {
    if (!isEnabled) {
      return Future.value();
    }

    return Future.delayed(40.milliseconds, () {
      if (shouldEnableHapticFeedback) {
        HapticFeedback.lightImpact();
      }

      ref.read(appButtonPressStateProvider.notifier).state =
          AppButtonPressState.released;
      onPressed();
    });
  }

  AppButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.isEnabled = true,
      this.color,
      this.icon,
      this.borderRadius,
      this.shouldEnableHapticFeedback = true}) {
    titleTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }

  AppButton.green(
      {super.key,
      required this.title,
      required this.onPressed,
      this.isEnabled = true,
      this.icon,
      this.shouldEnableHapticFeedback = false}) {
    color = Colors.green;
    titleTextStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
  }

  AppButton.red(
      {super.key,
      required this.title,
      required this.onPressed,
      this.isEnabled = true,
      this.icon,
      this.shouldEnableHapticFeedback = false}) {
    color = Colors.red;
    titleTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }

  AppButton.custom(
      {super.key,
      required this.title,
      required this.onPressed,
      this.isEnabled = true,
      this.color,
      this.icon,
      this.titleTextStyle,
      this.shouldEnableHapticFeedback = false});
}
