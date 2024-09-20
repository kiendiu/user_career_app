import 'package:user_career_core/user_career_core.dart';

enum POSStorageKey implements StorageKey {
  userId,
  userNameKey,
  idKey,
  mailKey,
  passwordKey,
  infoUserNameKey,
  infoEmailKey,
  infoFullNameKey,
  infoAvatarPath,
  infoPhoneKey,
  infoAddressKey;

  @override
  String get rawKey => name;
}
