import 'package:flutter/material.dart';
import 'package:user_career_core/user_career_core.dart';

class CommonActionChip extends ActionChip {
  CommonActionChip({
    super.key,
    BorderSide? borderSide,
    OutlinedBorder? line,
    String? textTitle,
    TextStyle? titleStyle,
    EdgeInsetsGeometry super.padding = const EdgeInsets.all(8.0),
    super.labelPadding,
    Widget? iconTitle,
    Widget? title,
    Color? backgroundColor,
    void Function()? onTap,
  }) : super(
    side: borderSide ?? BorderSide.none,
    shape: line ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
    label: title ??
        Row(
          children: [
            Text(
              textTitle ?? "",
              style: titleStyle ?? const TextStyle()
                  .textColor(AppColors.black1Color)
                  .size(12)
                  .weight(FontWeight.w400),
            ).marginOnly(right: 1),
            iconTitle ?? Assets.icons.icDown.svg(),
          ],
        ),
    backgroundColor: backgroundColor ?? AppColors.white3Color,
    onPressed: onTap,
  );
}

