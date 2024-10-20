import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/home/models/expect_detail_response.dart';
import 'package:user_career_home/home/models/info_service_model.dart';
import 'package:user_career_home/home/pages/views/star_rating_view.dart';

import 'contact_method_view.dart';

class SkillsView extends ConsumerStatefulWidget {
  final ExpectDetailResponse expectDetailResponse;
  final List<Skill> skill;
  const SkillsView({super.key,required this.expectDetailResponse, required this.skill});

  @override
  ConsumerState createState() => _SkillsViewState();
}

class _SkillsViewState extends ConsumerState<SkillsView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                    StarRating(
                      rating: e.averageRating ?? 0.0,
                      sizeStar: 20,
                    ).paddingOnly(right: 10.0),
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
                    AppButton(
                      onPressed: () {
                        context.showOverlay(ContactMethodView(expectDetailResponse: InfoServiceModel(
                          serviceId: e.serviceId,
                          expertId: e.expertId,
                          priceOnline: e.priceOnline,
                          timeOnline: e.timeOnline,
                          priceOffline: e.priceOffline,
                          timeOffline: e.timeOffline,
                        )));
                      },
                      title: 'Đặt lịch hẹn',
                    ).box(h: 50, w: 100).paddingOnly(right: 10),
                  ]
                )
              ],
            ).paddingSymmetric(vertical: 10.0).expand(),
          ],
        ),
      ).paddingOnly(top: 5),
      ).toList(),
    );
  }
}