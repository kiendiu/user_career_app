import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/service/controllers/cancel_controller.dart';
import 'package:user_career_more/service/controllers/service_controller.dart';
import 'package:user_career_more/service/models/cancel_reason_enum.dart';
import 'package:user_career_more/service/models/cancel_request.dart';
import 'package:user_career_more/service/models/status_service_enum.dart';

class CancelView extends ConsumerStatefulWidget {
  final int bookId;
  const CancelView({super.key, required this.bookId});

  @override
  ConsumerState<CancelView> createState() => _CancelPopupState();
}

class _CancelPopupState extends ConsumerState<CancelView> with AlertMixin {

  @override
  Widget build(BuildContext context) {
    final cancelState = ref.watch(cancelControllerProvider);
    final cancelController = ref.watch(cancelControllerProvider.notifier);

    return PopupView(
      backgroundColor: AppColors.white1Color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _reviewQuestion(),
          Column(
            children: [
              const Divider(color: AppColors.white4Color),
              ...CancelReasonEnum.values.map((type) {
                return Column(
                  children: [
                    Row(
                      children: [
                        BaseCheckBox.initState(
                          isSelected: cancelState.selectedState == type.localizedValue,
                          checkBoxStyle: CheckBoxStyle.roundedSquare,
                          onTap: (value) {
                            if(type.localizedValue == cancelState.selectedState) {
                              cancelController.updateSelectedState("");
                            }else{
                              cancelController.updateSelectedState(type.localizedValue);
                            }
                          },
                          rightWidget: Text(type.localizedValue,
                              style: ref.theme.mediumTextStyle),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.white4Color),
                  ],
                );
              }),
              cancelState.selectedState == CancelReasonEnum.otherReason.localizedValue
                ? TextFieldView.outsideBorder(
                    title: "Lý do",
                    placeholder: "Vui lòng nhập",
                    isExpanded: true,
                    maxLength: 4,
                    isRequired: true,
                    lengthLimiter: CharacterLengthLimiter(length: 100),
                    textFieldDidChange: (value) {
                      final cancelRequest = CancelRequest(
                        cancelReason: value,
                      );
                      cancelController.updateCancelRequest(cancelRequest);
                    },
                  ).paddingOnly(bottom: 10)
                : const SizedBox(),
            ]
          ),
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
                child: Text("Hoàn tất",
                  style: ref.theme.defaultTextStyle.copyWith(
                    color: AppColors.white1Color,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  )).paddingSymmetric(vertical: 17.5)
                  .center()
                  .onTapWidget(() {
                    cancelController.cancelService(widget.bookId).then((value) {
                      if(value){
                        context.maybePop();
                        ref.watch(serviceControllerProvider(StatusServiceEnum.cancelled).notifier)
                            .updateStatusService(widget.bookId, StatusServiceEnum.cancelled.rawValue);
                        NotificationCenter().postNotification(RawStringNotificationName('reloadCancel'), StatusServiceEnum.cancelled);
                      }
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
    child: const Text(
      "Quay lại",
      style: TextStyle(
        fontSize: 16,
        color: AppColors.black1Color,
        fontWeight: FontWeight.w500,
      ),
    )
        .paddingSymmetric(vertical: 17.5)
        .center()
        .onTapWidget(() => context.maybePop()),
  ).expand();

  Widget _reviewQuestion() => Text(
    "Lý do bạn hủy cuộc hẹn?",
    style: ref.theme.defaultTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.mainColor,
    ),
    textAlign: TextAlign.center,
  ).paddingOnly(top: 12);
}
