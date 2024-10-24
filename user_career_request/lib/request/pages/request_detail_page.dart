import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/core/router.gm.dart';
import 'package:user_career_request/request/controllers/add_request_controller.dart';
import 'package:user_career_request/request/controllers/bid_item_controller.dart';
import 'package:user_career_request/request/controllers/bid_request_controller.dart';
import 'package:user_career_request/request/models/bid_model.dart';
import 'package:user_career_request/request/models/enums/bid_status_enum.dart';
import 'package:user_career_request/request/models/info_booking_bid_model.dart';
import 'package:user_career_request/request/models/request_model.dart';
import 'package:user_career_request/request/pages/bid_request_page.dart';
import 'package:user_career_request/request/pages/views/status_container_view.dart';

@RoutePage()
class RequestDetailPage extends ConsumerStatefulWidget {
  final bool isMine;
  final RequestModel request;
  const RequestDetailPage({super.key, required this.request, required this.isMine});

  @override
  ConsumerState createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends ConsumerState<RequestDetailPage> {
  final _appBarController = BaseAppBarController();

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(addRequestControllerProvider.notifier);

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
                  ).paddingOnly(top: 12, bottom: 12.0),
                  Text(
                    "Lĩnh vực: ${widget.request.nameCategory ?? ""}",
                    style: ref.theme.defaultTextStyle,
                  ).paddingOnly(bottom: 12.0),
                  Text(
                    "Ngày tạo: ${widget.request.createdAt.ddMMyyyy2() ?? ""}",
                    style: ref.theme.defaultTextStyle,
                  ).paddingOnly(bottom: 12.0),
                  const Divider(thickness: 1, color: Colors.grey,),
                  Text(
                    "Ngày hết hạn: ${widget.request.biddingEndDate.ddMMyyyy2() ?? ""}",
                    style: ref.theme.defaultTextStyle,
                  ).paddingOnly(bottom: 12.0),
                  Text(
                    "Hình thức: ${widget.request.contactMethod == "offline" ? "Gặp mặt" : "Gọi điện"}",
                    style: ref.theme.defaultTextStyle,
                  ).paddingOnly(bottom: 12.0),
                  widget.request.contactMethod == "offline" ? Text(
                    "Địa chỉ: ${widget.request.address ?? ""}",
                    style: ref.theme.defaultTextStyle,
                  ).paddingOnly(bottom: 12.0) : const SizedBox(),
                  Text(
                    "Ngân sách: ${NumberFormat('#,###').format(widget.request.budget ?? 0)}đ",
                    style: ref.theme.defaultTextStyle
                  ).paddingOnly(bottom: 12.0)
                ],
              ).paddingSymmetric(horizontal: 12.0).makeColor(AppColors.white1Color),
              const Gap(5),
              widget.request.status == "closed"
                ? const SizedBox()
                : Container(
                color: AppColors.white1Color,
                child: AppButton(
                  title: widget.isMine ? "Hủy yêu cầu" : "Chào giá ngay",
                  onPressed: () {
                    if(widget.isMine){
                      controller.cancelRequest(widget.request.requestId!)
                          .then((value) => {
                        if (value == true)
                          {
                            context.showSuccess(L.more.inforMessageSuccess),
                            NotificationCenter()
                                .postNotification(RawStringNotificationName('reloadMine')),
                            context.maybePop(),
                          }
                      });
                    }else{
                      context.showOverlay(BidRequestPage(request: widget.request));
                    }
                  },
                ).paddingSymmetric(horizontal: 10, vertical: 10.0),
              ).paddingOnly(bottom: 5.0),
              widget.request.expectBids.isNotNull
                ? ListView(
                    shrinkWrap: true,
                    children: widget.request.expectBids?.map((e) =>
                        Consumer(
                          builder: (context, ref, child) {
                            var item = ref.watch(bidItemControllerProvider(e.status));
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.monetization_on_outlined, color: AppColors.mainColor),
                                    Text(
                                      "Chào giá: ${NumberFormat('#,###').format(e.price ?? 0)}đ",
                                      style: ref.theme.defaultTextStyle,
                                    ).paddingOnly(left: 5.0).expand(),
                                    item?.status == BidStatusEnum.rejected || item?.status == BidStatusEnum.accepted
                                      ? const SizedBox()
                                      : CupertinoMenuButton(
                                      buttonPadding: const EdgeInsets.all(8),
                                      child: const Icon(Icons.menu_outlined),
                                      itemsBuilder: (_) => [
                                        CupertinoMenuItem(
                                          trailing: const Icon(Icons.check_circle_outline, color: Colors.green),
                                          child: Text(
                                            "Chấp nhận",
                                            style: ref.theme.defaultTextStyle.copyWith(
                                              color: Colors.green,
                                            ),
                                          ),
                                          onTap: () {
                                            _showPopupBid(action: 'accepted', bid: item ?? BidModel());
                                          },
                                        ),
                                        CupertinoMenuItem(
                                          trailing: const Icon(Icons.cancel_outlined, color: Colors.red),
                                          child: Text(
                                            "Từ chối",
                                            style: ref.theme.defaultTextStyle.copyWith(
                                              color: Colors.red,
                                            ),
                                          ),
                                          onTap: () {
                                            _showPopupBid(action: 'rejected', bid: item ?? BidModel());
                                          },
                                        ),
                                      ],
                                    ).paddingOnly(right: 8),
                                  ],
                                ).paddingOnly(bottom: 12.0),
                                Row(
                                  children: [
                                    const Icon(Icons.note_alt_outlined, color: AppColors.mainColor),
                                    Text(
                                      "Mô tả: ${e.description ?? ""}",
                                      style: ref.theme.defaultTextStyle,
                                    ).paddingOnly(left: 5.0),
                                  ],
                                ).paddingOnly(bottom: 12.0),
                                widget.request.budget == e.price
                                    ? const SizedBox()
                                    : Row(
                                  children: [
                                    const Icon(Icons.help_outline_outlined, color: AppColors.mainColor),
                                    Text(
                                      "Lý do: ${e.changeReason ?? ""}",
                                      style: ref.theme.defaultTextStyle,
                                    ).paddingOnly(left: 5.0),
                                  ],
                                ).paddingOnly(bottom: 12.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    StatusBidContainerView(item?.status ?? BidStatusEnum.pending),
                                    const Text(
                                      "Thông tin chuyên gia >>",
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
                            ).paddingSymmetric(horizontal: 12.0, vertical: 12.0).makeColor(AppColors.white1Color);
                          }
                        )
                    ).toList() ?? [],
                  )
                : SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                        "Chưa có chào giá nào",
                        style: ref.theme.mediumTextStyle.weight(FontWeight.bold),
                      ).paddingSymmetric(vertical: 10.0),
                  ),
                ).makeColor(AppColors.white1Color),
            ],
          ).paddingSymmetric(vertical: 5.0),
      ),
    );
  }

  void _showPopupBid({
    required String action, required BidModel bid
  }) {
    context.showOverlay(
        BaseConfirmPopupView.custom(
          width: context.width * 0.9,
          messageWidget: Column(
            children: [
              action == "rejected"
                  ? Assets.icons.icAlertDialogError.svg()
                  : Assets.icons.icAlertDialogSuccess.svg(),
              const Gap(16),
              Text(
                action == "rejected"
                    ? "Từ chối yêu cầu"
                    : "Chấp nhận yêu cầu",
                style:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          title: "Xác nhận",
          buttons: [
            ConfirmPopupViewButton(
              title: "Hủy",
              titleColor: AppColors.black1Color,
              background: AppColors.white4Color,
              callback: () => appRouter.maybePop(),
            ),
            ConfirmPopupViewButton(
              title: action == "rejected" ? "Từ chối" : "Chấp nhận",
              titleColor: Colors.white,
              background: action == "rejected"
                  ? Colors.redAccent
                  : Colors.green,
              callback: () {
                action == "rejected"
                  ? ref.read(bidRequestControllerProvider.notifier)
                    .updateStatusBid(bid.bidId ?? 0, action).then((value) {
                      if(value == true){
                        ref.read(bidItemControllerProvider(bid.status).notifier)
                            .state = bid.copyWith(status: BidStatusEnum.rejected);
                        NotificationCenter().postNotification(RawStringNotificationName('reloadMine'));
                        context.showSuccess("Từ chối thành công");
                        context.maybePop();
                      }
                    })
                  : ref.read(bidRequestControllerProvider.notifier)
                  .updateStatusBid(bid.bidId ?? 0, action).then((value) {
                    if(value == true){
                      context.pushRoute(BookingBidRoute(infoBookingBidModel: InfoBookingBidModel(
                          expertId: bid.expertId,
                          requestId: bid.requestId,
                          contactMethod: widget.request.contactMethod,
                          locationName: widget.request.address,
                          address: widget.request.address,
                          price: bid.price,
                          description: bid.description
                      )));
                      ref.read(bidItemControllerProvider(bid.status).notifier)
                          .state = bid.copyWith(status: BidStatusEnum.accepted);
                      NotificationCenter().postNotification(RawStringNotificationName('reloadMine'));
                      context.showSuccess("Chấp nhận thành công");
                      context.maybePop();
                    }
                  });
              },
            ),
          ],
        ),
        dismissible: false);
  }
}
