enum UserExpectEnum {
  allType, expect, user;

  String get localizedValue => switch (this) {
    UserExpectEnum.allType => 'Tất cả',
    UserExpectEnum.expect => 'Chuyên gia',
    UserExpectEnum.user => 'Người dùng',
  };

  int get rawValue => switch (this) {
    UserExpectEnum.allType => 0,
    UserExpectEnum.expect => 1,
    UserExpectEnum.user => 2,
  };
}
