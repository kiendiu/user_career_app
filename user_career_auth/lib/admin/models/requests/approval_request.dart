import 'package:user_career_auth/admin/models/enums/approval_enum.dart';
import 'package:user_career_core/user_career_core.dart';

class ApprovalRequest implements Encodable{
  final int? userId;
  final ApprovalEnum? approval;
  final String? reason;

  ApprovalRequest({
    this.userId,
    this.approval,
    this.reason,
  });

  ApprovalRequest copyWith({
    int? userId,
    ApprovalEnum? approval,
    String? reason,
  }) {
    return ApprovalRequest(
      userId: userId ?? this.userId,
      approval: approval ?? this.approval,
      reason: reason ?? this.reason,
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      "user_id": userId,
      "status": approval?.rawValue,
      "reason": reason,
    };
  }
}