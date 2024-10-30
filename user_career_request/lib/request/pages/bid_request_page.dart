import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/core/router.gm.dart';
import 'package:user_career_request/request/controllers/bid_request_controller.dart';
import 'package:user_career_request/request/controllers/general_controller.dart';
import 'package:user_career_request/request/controllers/mine_controller.dart';
import 'package:user_career_request/request/models/request_model.dart';

@RoutePage()
class BidRequestPage extends ConsumerStatefulWidget {
  final RequestModel request;
  const BidRequestPage({super.key, required this.request});

  @override
  ConsumerState createState() => _BidRequestPageState();
}

class _BidRequestPageState extends ConsumerState<BidRequestPage> {
  bool isChangeBudget = false;

  @override
  Widget build(BuildContext context) {
    final bidRequestState = ref.watch(bidRequestControllerProvider);
    final bidRequestController = ref.read(bidRequestControllerProvider.notifier);
    return PopupView(
      backgroundColor: AppColors.white1Color,
      width: 300,
      child: Column(
        children: [
          Text(
            "Chào giá",
            style: ref.theme.bigTextStyle.copyWith(fontWeight: FontWeight.bold),
          ).paddingSymmetric(vertical: 12),
          const Divider(
            color: AppColors.white3Color,
            height: 1,
          ).paddingOnly(bottom: 12),
          BaseCheckBox.initState(
            isSelected: isChangeBudget,
            checkBoxStyle: CheckBoxStyle.roundedSquare,
            onTap: (value) {
              setState(() {
                if(value){
                  isChangeBudget = false;
                } else {
                  isChangeBudget = true;
                }
              });
            },
            rightWidget: Text("Thay đổi giá tiền",
                style: ref.theme.mediumTextStyle),
          ),
          TextFieldView.outsideBorder(
            title: "Giá tiền",
            placeholder: "Nhập giá tiền",
            isRequired: true,
            isDisabled: !isChangeBudget,
            inputType: TextInputType.number,
            initialText: widget.request.budget.toString(),
            textFieldDidChange: (text) {
              int number = int.parse(text!);
              bidRequestController.setPrice(number);
            },
            validator: (_) => bidRequestState.isEmptyPrice,
            errorText: () => L.more.errorEmpty,
          ).paddingOnly(top: 12),
          TextFieldView.outsideBorder(
            title: "Mô tả",
            placeholder: "Nhập mô tả",
            isRequired: true,
            textFieldDidChange: (text) {
              bidRequestController.setDescription(text!);
            },
            validator: (_) => bidRequestState.isEmptyDescription,
            errorText: () => L.more.errorEmpty,
          ).paddingOnly(top: 12),
          !isChangeBudget
            ? const SizedBox()
            : TextFieldView.outsideBorder(
            title: "Lý do thay đổi",
            placeholder: "Nhập lý do",
            isRequired: true,
            textFieldDidChange: (text) {
              bidRequestController.setChangeReason(text!);
            },
            validator: (_) => bidRequestState.isEmptyChangeReason,
            errorText: () => L.more.errorEmpty,
          ).paddingOnly(top: 12),
          Container(
            color: AppColors.white1Color,
            child: AppButton(
              title: "Đồng ý",
              onPressed: () {
                bidRequestController.setRequestId(widget.request.requestId ?? 0);
                if(isChangeBudget == false){
                  bidRequestController.setPrice(widget.request.budget ?? 0);
                }
                bidRequestController.addBidRequest().then((value) {
                  if(value){
                    context.showSuccess("Chào giá thành công!");
                    context.maybePop().then((value) {
                      context.maybePop();
                      NotificationCenter()
                          .postNotification(RawStringNotificationName('reloadGeneral'));
                      NotificationCenter()
                          .postNotification(RawStringNotificationName('reloadMine'));
                    });
                  }
                });
              },
            ),
          ).paddingSymmetric(vertical: 12)
        ],
      ).paddingSymmetric(horizontal: 12)
    );
  }
}
