enum UserExpectEnum {
  allType, expect, user;

  String get localizedValue => switch (this) {
    UserExpectEnum.allType => 'Tất cả',
    UserExpectEnum.expect => 'Chuyên gia',
    UserExpectEnum.user => 'Người dùng',
  };

  String get rawValue => switch (this) {
    UserExpectEnum.allType => 'all',
    UserExpectEnum.expect => 'expert',
    UserExpectEnum.user => 'user',
  };
}
