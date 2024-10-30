enum BalanceFluctuationEnum {
  all, add, sub;

  String get localizedValue => switch (this) {
    BalanceFluctuationEnum.all => "Tất cả",
    BalanceFluctuationEnum.add => "Tiền nhận",
    BalanceFluctuationEnum.sub => "Tiền gửi",
  };

  String get rawValue => switch (this) {
    BalanceFluctuationEnum.all => 'all',
    BalanceFluctuationEnum.add => 'add',
    BalanceFluctuationEnum.sub => 'sub',
  };
}