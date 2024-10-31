enum BidStatusEnum {
  pending,
  accepted,
  rejected,
  completed;

  String get localizedValue => switch (this) {
    BidStatusEnum.pending => "Chờ xác nhận",
    BidStatusEnum.accepted => "Chấp nhận",
    BidStatusEnum.rejected => "Từ chối",
    BidStatusEnum.completed => "Hoàn thành",
  };

  String get rawValue => switch (this) {
    BidStatusEnum.pending => "pending",
    BidStatusEnum.accepted => "accepted",
    BidStatusEnum.rejected => "rejected",
    BidStatusEnum.completed => "completed",
  };
}


