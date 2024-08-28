

import 'package:user_career_core/user_career_core.dart';

enum POSStorageKey implements StorageKey {
  domainKey,
  userId,
  userNameKey,
  idKey,
  storeIdKey,
  mailKey,
  passwordKey,
  infoUserNameKey,
  infoEmailKey,
  infoAvatarPath;

  @override
  String get rawKey => name;
}
