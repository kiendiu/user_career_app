import 'package:user_career_core/user_career_core.dart';

import 'module.dart';

class UserBaseRepository extends BaseRepository {
  UserBaseRepository() : super(urlBuilder: CommonURLBuilder.module(UserModule));
}