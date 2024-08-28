import 'package:user_career_core/user_career_core.dart';

import 'module.dart';

class RequestBaseRepository extends BaseRepository {

  RequestBaseRepository() : super (urlBuilder: CommonURLBuilder.module(RequestModule));
}