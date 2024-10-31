import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/home/controllers/expect_detail_controller.dart';
import 'package:user_career_home/home/models/expect_detail_response.dart';
import 'package:user_career_home/home/models/info_service_model.dart';
import 'package:user_career_home/home/pages/views/contact_method_view.dart';
import 'package:user_career_home/home/pages/views/evaluates_view.dart';
import 'package:user_career_home/home/pages/views/experiences_view.dart';
import 'package:user_career_home/home/pages/views/infor_view.dart';
import 'package:user_career_home/home/pages/views/skills_view.dart';
import 'package:user_career_home/home/pages/views/star_rating_view.dart';

@RoutePage()
class ExpectDetailPage extends ConsumerStatefulWidget {
  final int expectId;
  const ExpectDetailPage({super.key, required this.expectId});

  @override
  ConsumerState createState() => _ExpectDetailPageState();
}

class _ExpectDetailPageState extends ConsumerState<ExpectDetailPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(expectDetailControllerProvider(widget.expectId));
    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      customAppBar: BaseAppBarView(
        title: "Thông tin chuyên gia",
      ),
      bottomView: Container(
        color: AppColors.white1Color,
        child: AppButton(
          title: "Đặt lịch ngay",
          onPressed: () {
            state.maybeWhen(
              orElse: () => null,
              data: (data) {
                context.showOverlay(ContactMethodView(expectDetailResponse: InfoServiceModel(
                  serviceId: data.serviceId,
                  expertId: data.userId,
                  priceOnline: data.priceOnline,
                  timeOnline: data.timeOnline,
                  priceOffline: data.priceOffline,
                  timeOffline: data.timeOffline,
                )));
              }
            );
            //context.pushRoute(const BookingRoute());
          },
        ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
      ),
      body:state.maybeWhen(
        orElse: () => const SizedBox(),
        data: (data) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: AppColors.white1Color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageView(
                    url: data.avatar ?? '',
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
                            data.username ?? '',
                            style: ref.theme.bigTextStyle.weight(FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ).expand(),
                          StarRating(
                              rating: data.averageRating ?? 0.0
                          ).paddingOnly(right: 10.0),
                        ],
                      ).paddingOnly(bottom: 5.0),
                      Row(
                        children: [
                          const Icon(
                              Icons.local_library_outlined,
                              size: 15,
                              color: AppColors.main1Color
                          ).paddingOnly(right: 5.0),
                          Text(
                            data.nameCategory ?? '',
                            style: ref.theme.mediumTextStyle.weight(FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                              Icons.phone_in_talk_outlined,
                              size: 15,
                              color: AppColors.main1Color
                          ).paddingOnly(right: 5.0),
                          Text(
                            '${data.priceOnlineString} / ${data.timeOnline ?? ''} phút',
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
                            '${data.priceOfflineString} / ${data.timeOffline ?? ''} phút',
                            style: ref.theme.itemTextStyle,
                          )
                        ],
                      ),
                    ],
                  ).paddingSymmetric(vertical: 10.0).expand(),
                ],
              ),
            ).paddingOnly(bottom: 5),
            Flexible(
              fit: FlexFit.loose,
              child: BaseTabBarView(
                data: [
                  TabBarViewData.normal(
                      title: "Thông tin",
                      body: InforView(information: data.information ?? Information())),
                  TabBarViewData.normal(
                      title: "Kinh nghiệm",
                      body: ExperiencesView(experience: data.experience ?? [],)),
                  TabBarViewData.normal(
                      title: "Kỹ năng",
                      body: SkillsView(expectDetailResponse: data, skill: data.skill ?? [])),
                  TabBarViewData.normal(
                      title: "Đánh giá",
                      body: EvaluatesView(review: data.review ?? Review(),)),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
