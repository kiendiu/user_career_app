import 'package:user_career_core/user_career_core.dart';

class ApprovalRequest implements Encodable{
  final int? userId;
  final String? approval;
  final String? reason;

  ApprovalRequest({
    this.userId,
    this.approval,
    this.reason,
  });

  ApprovalRequest copyWith({
    int? userId,
    String? approval,
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
      "userId": userId,
      "approval": approval,
      "reason": reason,
    };
  }
}