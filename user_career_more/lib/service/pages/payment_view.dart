import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/service/controllers/payment_controller.dart';
import 'package:user_career_more/service/models/payment_request.dart';
import 'package:user_career_more/service/models/service_model.dart';

class PaymentView extends ConsumerStatefulWidget {
  final ServiceModel serviceModel;
  const PaymentView({super.key, required this.serviceModel});

  @override
  ConsumerState createState() => _PaymentViewState();
}

class _PaymentViewState extends ConsumerState<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return PopupView(
      backgroundColor: AppColors.white1Color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Thanh toán",
            style: ref.theme.defaultTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: AppColors.black1Color,
            ),
            textAlign: TextAlign.center,
          ),
          Column(
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phương thức liên hệ",
                    style: ref.theme.bigTextStyle,
                  ),
                  Text(
                    widget.serviceModel.contactMethod ?? '',
                    style: ref.theme.bigTextStyle,
                  )
                ],
              ).paddingOnly(bottom: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thời gian tư vấn",
                    style: ref.theme.bigTextStyle,
                  ),
                  Text(
                    "${widget.serviceModel.duration} phút",
                    style: ref.theme.bigTextStyle,
                  )
                ],
              ).paddingOnly(bottom: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Giá tiền",
                    style: ref.theme.bigTextStyle,
                  ),
                  Text(
                    widget.serviceModel.totalPrice.toString(),
                    style: ref.theme.bigTextStyle,
                  )
                ],
              ).paddingOnly(bottom: 20)
            ]
          ).paddingSymmetric(horizontal: 16).makeColor(AppColors.white1Color),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _cancelButton(),
              HSpace.h8,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.mainColor,
                ),
                child: Text("Thanh toán",
                    style: ref.theme.defaultTextStyle.copyWith(
                      color: AppColors.white1Color,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    )).paddingSymmetric(vertical: 17.5)
                    .center()
                    .onTapWidget(() {
                  ref.read(paymentControllerProvider.notifier).createPayment(
                    PaymentRequest(
                        bookId: widget.serviceModel.bookId,
                        expertId: widget.serviceModel.expertId,
                        cost: (widget.serviceModel.totalPrice ?? 0).toInt(),
                        methodPayment: "Bank"
                    ), (){
                    context.maybePop();
                    NotificationCenter().postNotification(RawStringNotificationName('reloadService'));
                    context.showSuccess("Thanh toán thành công");
                  }, (){
                    context.showOverlay(
                        BaseConfirmPopupView.custom(
                          title: "Thanh toán thất bại",
                          message: "Số dư của bạn không đủ? Bạn cần nạp thêm tiền không?",
                          buttons: [
                            ConfirmPopupViewButton(
                              title: "Quay lại",
                              titleColor: AppColors.black1Color,
                              background: AppColors.white4Color,
                              callback: () {
                                context.maybePop();
                              },
                            ),
                            ConfirmPopupViewButton(
                              title: "Đồng ý",
                              titleColor: AppColors.white1Color,
                              background: AppColors.mainColor,
                              callback: () {
                                context.pushRoute(const DepositWalletRoute());
                              },
                            ),
                          ],
                        )
                    );
                  });
                },
                ),
              ).expand()
            ],
          ),
        ],
      ).paddingSymmetric(vertical: 12, horizontal: 12),
    ).marginSymmetric(horizontal: 32);
  }

  Widget _cancelButton() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.white4Color,
    ),
    child: Text(
      L.more.cancel,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.black1Color,
        fontWeight: FontWeight.w500,
      ),
    )
        .paddingSymmetric(vertical: 17.5)
        .center()
        .onTapWidget(() => context.maybePop()),
  ).expand();
}
