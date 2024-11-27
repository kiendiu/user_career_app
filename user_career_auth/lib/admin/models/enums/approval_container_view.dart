import 'package:flutter/material.dart';
import 'package:user_career_core/user_career_core.dart';

import 'approval_enum.dart';

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

class PaymentContainerView extends StatelessWidget with GlobalThemePlugin {
  const PaymentContainerView(
      {super.key,
        required this.title,
        this.backgroundColor,
        this.borderColor,
        this.child,
        this.textStyle});

  final String title;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget? child;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.redAccent.withOpacity(0.1),
        border: Border.all(width: 1, color: borderColor ?? Colors.redAccent),
        borderRadius: BorderRadius.circular(4),
      ),
      child: child ??
          Text(title,
              style: textStyle ?? const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              )),
    );
  }
}