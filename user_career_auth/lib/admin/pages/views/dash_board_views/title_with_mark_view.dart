import 'package:flutter/material.dart';
import 'package:user_career_core/user_career_core.dart';

class TitleWithMarkView extends StatelessWidget with GlobalThemePlugin {
  final String title;

  const TitleWithMarkView({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.mainColor
              ),
            ),
            const Gap(8),
            Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ).textColor(AppColors.black1Color)
            ).flexible()
          ]),
    );
  }
}
