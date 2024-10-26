import 'package:user_career_core/user_career_core.dart';

enum DateTimeEnum {
  today,
  yesterday,
  lastSevenDays,
  thisMonth,
  lastMonth,
  customDay;

  String get localizedValue => switch (this) {
    DateTimeEnum.today => L.more.bottomSheetToday,
    DateTimeEnum.yesterday => L.more.bottomSheetYesterday,
    DateTimeEnum.lastSevenDays => "7 ngày tới",
    DateTimeEnum.thisMonth => L.more.bottomSheetThisMonth,
    DateTimeEnum.lastMonth => L.more.bottomSheetLastMonth,
    DateTimeEnum.customDay => L.more.bottomSheetCustomDay,
  };

  DateTime get rawValue => switch (this) {
    DateTimeEnum.today => DateTime.now(),
    DateTimeEnum.yesterday =>
        DateTime.now().subtract(const Duration(days: 1)),
    DateTimeEnum.lastSevenDays =>
        DateTime.now().add(const Duration(days: 7)),
    DateTimeEnum.thisMonth =>
        DateTime(DateTime.now().year, DateTime.now().month, 1),
    DateTimeEnum.lastMonth =>
        DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
    DateTimeEnum.customDay => DateTime.now(),
  };
}
