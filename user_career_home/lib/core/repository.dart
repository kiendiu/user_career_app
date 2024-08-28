import 'package:user_career_core/user_career_core.dart';

import 'module.dart';

class HomeBaseRepository extends BaseRepository {

  HomeBaseRepository() : super (urlBuilder: CommonURLBuilder.module(HomeModule));
}