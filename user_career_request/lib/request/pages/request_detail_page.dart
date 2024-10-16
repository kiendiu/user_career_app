import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/base_app_bar_view.dart';
import 'package:user_career_request/request/models/enums/bid_status_enum.dart';
import 'package:user_career_request/request/models/request_model.dart';
import 'package:user_career_request/request/pages/views/status_container_view.dart';

@RoutePage()
class RequestDetailPage extends ConsumerStatefulWidget {
  final RequestModel request;
  const RequestDetailPage({super.key, required this.request});

  @override
  ConsumerState createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends ConsumerState<RequestDetailPage> {
  final _appBarController = BaseAppBarController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      customAppBar: BaseAppBarView(
        title: "Chi tiết yêu cầu",
        controller: _appBarController,
        shouldShowLeading: true,
      ),
      backgroundColor: AppColors.white3Color,
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.request.title ?? "",
                    style: ref.theme.bigTextStyle.weight(FontWeight.bold),
                  ).paddingOnly(bottom: 5.0),
                  Text(
                    "Lĩnh vực: ${widget.request.nameCategory ?? ""}",
                    style: ref.theme.defaultTextStyle.weight(FontWeight.w400),
                  ).paddingOnly(bottom: 5.0),
                  Text(
                    "Ngày tạo: ${widget.request.createdAt.ddMMyyyy2() ?? ""}",
                    style: ref.theme.defaultTextStyle.weight(FontWeight.w400),
                  ).paddingOnly(bottom: 5.0),
                  const Divider(thickness: 1, color: Colors.grey,),
                  Text(
                    "Ngày hết hạn: ${widget.request.biddingEndDate.ddMMyyyy2() ?? ""}",
                    style: ref.theme.defaultTextStyle,
                  ).paddingOnly(bottom: 5.0),
                  Text(
                    "Hình thức: ${widget.request.contactMethod == "offline" ? "Gặp mặt" : "Gọi điện"}",
                    style: ref.theme.defaultTextStyle,
                  ).paddingOnly(bottom: 5.0),
                  widget.request.contactMethod == "offline" ? Text(
                    "Địa chỉ: ${widget.request.address ?? ""}",
                    style: ref.theme.defaultTextStyle,
                  ).paddingOnly(bottom: 5.0) : const SizedBox(),
                  Text(
                    "Ngân sách: ${widget.request.budget ?? 0}",
                  ).paddingOnly(bottom: 5.0)
                ],
              ).paddingOnly(bottom: 5.0).paddingSymmetric(horizontal: 10.0).makeColor(AppColors.white1Color),
              const Gap(5),
              widget.request.expectBids.isNotNull
                ? ListView(
                    shrinkWrap: true,
                    children: widget.request.expectBids?.map((e) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   e.requestTitle ?? "",
                        //   style: ref.theme.defaultTextStyle.weight(FontWeight.bold),
                        // ).paddingOnly(bottom: 5),
                        Row(
                          children: [
                            const Icon(Icons.monetization_on_outlined, color: AppColors.mainColor),
                            Text(
                              "Giá: ${e.price ?? 0}",
                              style: ref.theme.defaultTextStyle,
                            ).paddingOnly(left: 5.0),
                          ],
                        ).paddingOnly(bottom: 5.0),
                        Row(
                          children: [
                            const Icon(Icons.note_alt_outlined, color: AppColors.mainColor),
                            Text(
                              "Mô tả: ${e.description ?? ""}",
                              style: ref.theme.defaultTextStyle,
                            ).paddingOnly(left: 5.0),
                          ],
                        ).paddingOnly(bottom: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatusBidContainerView(e.status ?? BidStatusEnum.pending),
                            const Text(
                              "Xem thông tin chuyên gia",
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ).onTapWidget((){
                              NotificationCenter()
                                  .postNotification(openNotification, {
                                    "type": "request",
                                    "expert_id": e.expertId
                              });
                            }),
                          ],
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 10.0, vertical: 10.0).makeColor(AppColors.white1Color)
                    ).toList() ?? [],
                  )
                : Text(
                    "Chưa có chào giá nào",
                    style: ref.theme.mediumTextStyle.weight(FontWeight.bold),
                  ).paddingOnly(top: 10.0),
            ],
          ).paddingSymmetric(vertical: 5.0),
      ),
    );
  }
}
