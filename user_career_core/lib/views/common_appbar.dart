import 'package:flutter/material.dart';
import 'package:user_career_core/user_career_core.dart';

class CommonAppBar extends AppBar {
  CommonAppBar(
      {super.key,
      String? titleText,
      bool noLeading = false,
      bool centerTitle = false,
      double titleSpacing = 16.0,
      double maxHeight = 56.0,
      Widget? title,
      Widget? leading,
      Color? backgroundColor,
      List<Widget>? rightActions})
      : super(
          title: title ??
              Text(
                (titleText ?? ""),
                style: const TextStyle(
                        color: AppColors.black1Color,
                        fontWeight: FontWeight.w500)
                    .size(18),
              ),
          backgroundColor: Colors.white,
          titleSpacing: titleSpacing,
          elevation: 0,
          toolbarHeight: maxHeight,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.white3Color, // Màu sắc của highlight
                  width: 2.0, // Độ dày của highlight
                ),
              ),
            ),
          ),
          centerTitle: centerTitle,
          automaticallyImplyLeading: false,
          leading: noLeading
              ? null
              : leading ??
                  const BackButton(
                    color: AppColors.black1Color,
                  ),
          actions: rightActions,
        );
}
