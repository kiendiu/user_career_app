enum CancelReasonEnum{
  noLongerNeeded,
  wrongDateOrTime,
  personalReason,
  otherReason;

  String get localizedValue => switch (this) {
    CancelReasonEnum.noLongerNeeded => "Không còn nhu cầu nữa",
    CancelReasonEnum.wrongDateOrTime => "Đã đặt lịch nhầm",
    CancelReasonEnum.personalReason => "Lý do cá nhân",
    CancelReasonEnum.otherReason => "Lý do khác",
  };
}