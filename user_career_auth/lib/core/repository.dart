import 'package:user_career_core/user_career_core.dart';

import 'module.dart';

class AuthBaseRepository extends BaseRepository {

  AuthBaseRepository() : super (urlBuilder: CommonURLBuilder.module(AuthModule));
}