import 'package:flutter/material.dart';
import 'package:user_career_core/user_career_core.dart';

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

class StatusPaymentContainerView extends StatelessWidget {
  final PaymentStatusEnum status;

  const StatusPaymentContainerView(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    String title;
    Color backgroundColor;
    Color borderColor;

    switch (status) {
      case PaymentStatusEnum.yes:
        title = status.localizedValue;
        backgroundColor = const Color(0xFF58C35A).withOpacity(0.1);
        borderColor = const Color(0xFF58C35A);
        break;
      case PaymentStatusEnum.no:
        title = status.localizedValue;
        backgroundColor = const Color(0xFFF32E1B).withOpacity(0.1);
        borderColor = const Color(0xFFF32E1B);
        break;
    }

    return PaymentContainerView(
      title: title,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
    );
  }
}

enum PaymentStatusEnum {
  no, yes;

  String get localizedValue => switch (this) {
    PaymentStatusEnum.no => "Chưa thanh toán",
    PaymentStatusEnum.yes => "Đã thanh toán",
  };

  bool get rawValue => switch (this) {
    PaymentStatusEnum.no => false,
    PaymentStatusEnum.yes => true,
  };
}