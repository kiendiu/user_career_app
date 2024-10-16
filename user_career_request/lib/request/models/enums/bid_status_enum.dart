enum BidStatusEnum {
  pending,
  accepted,
  rejected,
  completed;

  String get localizedValue => switch (this) {
    BidStatusEnum.pending => "Chờ xác nhận",
    BidStatusEnum.accepted => "Đã chấp nhận",
    BidStatusEnum.rejected => "Đã từ chối",
    BidStatusEnum.completed => "Đã hoàn thành",
  };

  String get rawValue => switch (this) {
    BidStatusEnum.pending => "pending",
    BidStatusEnum.accepted => "accepted",
    BidStatusEnum.rejected => "rejected",
    BidStatusEnum.completed => "completed",
  };
}


