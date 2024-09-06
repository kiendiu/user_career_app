import 'package:user_career_core/user_career_core.dart';

enum StatusServiceEnum {
  waiting,
  confirmed,
  happened,
  done;

  String get localizedValue => switch (this) {
    StatusServiceEnum.waiting => L.more.statusServiceWaiting,
    StatusServiceEnum.confirmed => L.more.statusServiceConfirmed,
    StatusServiceEnum.happened => L.more.statusServiceHappened,
    StatusServiceEnum.done => L.more.statusServiceDone,
  };

  int get rawValue => switch (this) {
    StatusServiceEnum.waiting => 0,
    StatusServiceEnum.confirmed => 1,
    StatusServiceEnum.happened => 2,
    StatusServiceEnum.done => 3,
  };
}
