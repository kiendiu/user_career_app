import 'package:user_career_core/user_career_core.dart';

import 'module.dart';

class MoreBaseRepository extends BaseRepository {

  MoreBaseRepository() : super (urlBuilder: CommonURLBuilder.module(MoreModule));
}