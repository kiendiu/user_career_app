import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/booking/models/info_booking_model.dart';
import 'package:user_career_home/core/router.gm.dart';
import 'package:user_career_home/home/models/info_service_model.dart';

class ContactMethodView extends ConsumerStatefulWidget {
  final InfoServiceModel? expectDetailResponse;
  const ContactMethodView({super.key, this.expectDetailResponse});

  @override
  ConsumerState createState() => _ContactMethodViewState();
}

class _ContactMethodViewState extends ConsumerState<ContactMethodView> {
  @override
  Widget build(BuildContext context) {
    return PopupView(
      child: Column(
        children: [
          Text(
            "Phương thức liên hệ",
            style: ref.theme.bigTextStyle.weight(FontWeight.bold),
            textAlign: TextAlign.center,
          ).paddingSymmetric(vertical: 5.0).paddingOnly(top: 5),
          const Divider(color: Colors.grey),
          const Gap(5),
          ...ContactMethodEnum.values.map((type) {
            return Column(
              children: [
                Row(
                  children: [
                    type.rawValue == "offline"
                      ? const Icon(Icons.people_outline, color: AppColors.mainColor)
                      : const Icon(Icons.phone_in_talk_outlined, color: AppColors.mainColor),
                    Text(
                      type.localizedValue,
                      style: ref.theme.bigTextStyle,
                    ).paddingOnly(left: 10),
                  ]
                ).paddingSymmetric(vertical: 10).onTapWidget((){
                  InfoBookingModel infoBookingModel;
                  if(type.rawValue == "offline") {
                    infoBookingModel = InfoBookingModel(
                      serviceId: widget.expectDetailResponse?.serviceId,
                      expertId: widget.expectDetailResponse?.expertId,
                      contactMethod: type.rawValue,
                      price: widget.expectDetailResponse?.priceOffline,
                      time: widget.expectDetailResponse?.timeOffline,
                    );
                    context.pushRoute(BookingRoute(infoBookingModel: infoBookingModel));
                  } else {
                    infoBookingModel = InfoBookingModel(
                      serviceId: widget.expectDetailResponse?.serviceId,
                      expertId: widget.expectDetailResponse?.expertId,
                      contactMethod: type.rawValue,
                      price: widget.expectDetailResponse?.priceOnline,
                      time: widget.expectDetailResponse?.timeOnline,
                    );
                    context.pushRoute(BookingRoute(infoBookingModel: infoBookingModel));
                  }
                }),
                const Divider(color: AppColors.white4Color),
              ],
            );
          }),
        ],
      ).paddingSymmetric(horizontal: 20),
    ).paddingSymmetric(horizontal: 50);
  }
}

enum ContactMethodEnum{
  offline,
  online;

  String get localizedValue => switch (this) {
    ContactMethodEnum.offline => "Trực tiếp",
    ContactMethodEnum.online => "Gọi điện",
  };

  String get rawValue => switch (this) {
    ContactMethodEnum.offline => "offline",
    ContactMethodEnum.online => "online",
  };
}