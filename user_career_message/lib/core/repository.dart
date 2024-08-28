import 'package:user_career_core/user_career_core.dart';

import 'module.dart';

class MessageBaseRepository extends BaseRepository {

  MessageBaseRepository() : super (urlBuilder: CommonURLBuilder.module(MessageModule));
}