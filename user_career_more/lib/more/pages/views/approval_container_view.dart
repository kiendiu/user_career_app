import 'package:flutter/material.dart';
import 'package:user_career_more/more/models/approval_enum.dart';
import 'package:user_career_more/service/pages/payment_container_view.dart';

class ApprovalContainerView extends StatelessWidget {
  final ApprovalEnum status;

  const ApprovalContainerView(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    String title;
    Color backgroundColor;
    Color borderColor;

    switch (status) {
      case ApprovalEnum.user:
        title = status.localizedValue;
        backgroundColor = Colors.grey.withOpacity(0.1);
        borderColor = Colors.grey;
        break;
      case ApprovalEnum.pending:
        title = status.localizedValue;
        backgroundColor = Colors.yellow.withOpacity(0.1);
        borderColor = Colors.yellow;
        break;
      case ApprovalEnum.rejected:
        title = status.localizedValue;
        backgroundColor = const Color(0xFFF32E1B).withOpacity(0.1);
        borderColor = const Color(0xFFF32E1B);
        break;
      case ApprovalEnum.accepted:
        title = status.localizedValue;
        backgroundColor = const Color(0xFF58C35A).withOpacity(0.1);
        borderColor = const Color(0xFF58C35A);
        break;
    }

    return PaymentContainerView(
      title: title,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
    );
  }
}