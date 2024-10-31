import 'package:user_career_core/user_career_core.dart';

enum DateTimeEnum {
  today,
  nextSevenDays,
  thisMonth,
  nextMonth,
  customDay;

  String get localizedValue => switch (this) {
    DateTimeEnum.today => L.more.bottomSheetToday,
    DateTimeEnum.nextSevenDays => "7 ngày tới",
    DateTimeEnum.thisMonth => L.more.bottomSheetThisMonth,
    DateTimeEnum.nextMonth => L.more.bottomSheetLastMonth,
    DateTimeEnum.customDay => L.more.bottomSheetCustomDay,
  };

  DateTime get rawValue => switch (this) {
    DateTimeEnum.today => DateTime.now(),
    DateTimeEnum.nextSevenDays =>
        DateTime.now().add(const Duration(days: 7)),
    DateTimeEnum.thisMonth =>
        DateTime(DateTime.now().year, DateTime.now().month, 1),
    DateTimeEnum.nextMonth =>
        DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
    DateTimeEnum.customDay => DateTime.now(),
  };
}
