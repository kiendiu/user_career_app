import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/controllers/expert_controllers/approval_controller.dart';
import 'package:user_career_auth/admin/models/enums/approval_enum.dart';
import 'package:user_career_core/user_career_core.dart';

class ApprovalView extends ConsumerStatefulWidget {
  final int userId;
  const ApprovalView({super.key, required this.userId});

  @override
  ConsumerState createState() => _ApprovalViewState();
}

class _ApprovalViewState extends ConsumerState<ApprovalView> {
  bool isReject = false;
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(approvalControllerProvider(widget.userId).notifier);
    return PopupView(
      child: Column(
        children: [
          Text(
            "Duyệt chuyên gia",
            style: ref.theme.bigTextStyle.weight(FontWeight.bold),
            textAlign: TextAlign.center,
          ).paddingSymmetric(vertical: 5.0).paddingOnly(top: 5),
          const Divider(color: Colors.grey),
          const Gap(12),
          BaseCheckBox.initState(
            checkBoxStyle: CheckBoxStyle.circle,
            isSelected: isReject,
            rightWidget: Text(
              "Từ chối",
              style: ref.theme.bigTextStyle,
            ),
            onTap: (value){
              setState(() {
                isReject = true;
              });
              controller.setApproval(ApprovalEnum.rejected);
            },
          ).paddingOnly(bottom: 12),
          BaseCheckBox.initState(
            checkBoxStyle: CheckBoxStyle.circle,
            isSelected: !isReject,
            rightWidget: Text(
              "Duyệt",
              style: ref.theme.bigTextStyle,
            ),
            onTap: (value){
              setState(() {
                isReject = false;
              });
              controller.setApproval(ApprovalEnum.accepted);
            },
          ).paddingOnly(bottom: 12),
          TextFieldView.outsideBorder(
            title: "Lý do",
            placeholder: "Vui lòng nhập",
            textFieldDidChange: (value){
              controller.setReason(value ?? '');
            },
          ).paddingOnly(bottom: 12),
          AppButton(
            title: 'Hoàn tất',
            onPressed: () {
              controller.approvalExpert().then((value) {
                if(value){
                  context.maybePop();
                  NotificationCenter()
                      .postNotification(RawStringNotificationName('adminExpert'));
                  context.showSuccess("Duyệt chuyên gia thành công!");
                }
              });
            },
          ).paddingOnly(bottom: 12)
        ],
      ).paddingSymmetric(horizontal: 20),
    ).paddingSymmetric(horizontal: 50);
  }
}