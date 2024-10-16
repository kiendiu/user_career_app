import 'package:flutter/material.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/request/models/enums/bid_status_enum.dart';

class StatusContainerView extends StatelessWidget with GlobalThemePlugin {
  const StatusContainerView(
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

class StatusBidContainerView extends StatelessWidget {
  final BidStatusEnum status;

  const StatusBidContainerView(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    String title;
    Color backgroundColor;
    Color borderColor;

    switch (status) {
      case BidStatusEnum.pending:
        title = "Chờ xác nhận";
        backgroundColor = const Color(0xFFFFE69B).withOpacity(0.1);
        borderColor = const Color(0xFFFFE69B);
        break;
      case BidStatusEnum.accepted:
        title = "Đã chấp nhận";
        backgroundColor = const Color(0xFF58C35A).withOpacity(0.1);
        borderColor = const Color(0xFF58C35A);
        break;
      case BidStatusEnum.rejected:
        title = "Đã từ chối";
        backgroundColor = const Color(0xFFF32E1B).withOpacity(0.1);
        borderColor = const Color(0xFFF32E1B);
        break;
      case BidStatusEnum.completed:
        title = "Đã hoàn thành";
        backgroundColor = const Color(0xFF4CAF50).withOpacity(0.1);
        borderColor = const Color(0xFF4CAF50);
        break;
    }

    return StatusContainerView(
      title: title,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
    );
  }
}