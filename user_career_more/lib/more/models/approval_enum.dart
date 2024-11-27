import 'package:flutter/material.dart';

enum ApprovalEnum{
  user,
  pending,
  rejected,
  accepted;

  String get localizedValue => switch (this) {
    ApprovalEnum.user => "Người dùng",
    ApprovalEnum.pending => "Chờ xác nhận",
    ApprovalEnum.rejected => "Từ chối",
    ApprovalEnum.accepted => "Chấp nhận",
  };

  String get rawValue => switch (this) {
    ApprovalEnum.user => "user",
    ApprovalEnum.pending => "pending",
    ApprovalEnum.rejected => "rejected",
    ApprovalEnum.accepted => "accepted",
  };
}
