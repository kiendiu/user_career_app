import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/responses/user_detail_response.dart';
import 'package:user_career_core/user_career_core.dart';


class SkillsView extends ConsumerStatefulWidget {
  final List<Skill> skill;
  const SkillsView({super.key, required this.skill});

  @override
  ConsumerState createState() => _SkillsViewState();
}

class _SkillsViewState extends ConsumerState<SkillsView> {
  @override
  Widget build(BuildContext context) {
    return widget.skill.isNotEmpty
      ? ListView(
      shrinkWrap: true,
      children: widget.skill
          .map((e) => Container(
        color: AppColors.white1Color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageView(
                url: e.avatar ?? '',
                fit: BoxFit.cover,
                radius: 50,
                placeholder: Assets.icons.icAvatarDefault
                    .svg(height: 50, width: 50)
            ).box(w: 50, h: 50).paddingSymmetric(horizontal: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      e.skillName ?? '',
                      style: ref.theme.bigTextStyle.weight(FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ).paddingOnly(bottom: 5.0).expand(),
                  ],
                ),
                Text(
                  e.nameCategory ?? '',
                  style: ref.theme.mediumTextStyle.copyWith(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                                Icons.phone_in_talk_outlined,
                                size: 15,
                                color: AppColors.main1Color
                            ).paddingOnly(right: 5.0),
                            Text(
                              '${e.priceOnlineString} / ${e.timeOnline ?? ''} phút',
                              style: ref.theme.itemTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                                Icons.people_outline,
                                size: 15,
                                color: AppColors.main1Color
                            ).paddingOnly(right: 5.0),
                            Text(
                              '${e.priceOfflineString} / ${e.timeOffline ?? ''} phút',
                              style: ref.theme.itemTextStyle,
                            )
                          ],
                        ),
                      ],
                    ).expand(),
                  ]
                )
              ],
            ).paddingSymmetric(vertical: 10.0).expand(),
          ],
        ),
      ).paddingOnly(top: 5),
      ).toList(),
    )
    : Builder(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.icNoPermission.svg(),
          const Text(
            "Không có kỹ năng nào khác!",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff242133),
            ),
          ).marginOnly(top: 16),
        ],
      );
    });
  }
}