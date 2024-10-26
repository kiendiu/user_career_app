import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/calendar/models/user_expect_enum.dart';

import 'report_datetime_picker.dart';
import 'date_time_enum.dart';

class CalendarControllerState{
  UserExpectEnum? type;
  DateTime startDate;
  DateTime endDate;
  DateTimeEnum? selectedTimeOption;
  ReportDatetimePicker? reportDatetimePicker;

  CalendarControllerState({
    this.type,
    required this.startDate,
    required this.endDate,
    this.selectedTimeOption,
    this.reportDatetimePicker
  });

  CalendarControllerState copyWith({
    UserExpectEnum? type,
    DateTime? startDate,
    DateTime? endDate,
    DateTimeEnum? selectedTimeOption,
    ReportDatetimePicker? reportDatetimePicker
  }){
    return CalendarControllerState(
        type: type ?? this.type,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        selectedTimeOption: selectedTimeOption ?? this.selectedTimeOption,
        reportDatetimePicker: reportDatetimePicker ?? this.reportDatetimePicker
    );
  }

  String get formatHomeRepostDatetimePicker {
    if (selectedTimeOption == DateTimeEnum.customDay) {
      if (startDate.isNotNull && endDate.isNotNull) {
        if (startDate == endDate) {
          return DateTimeUtils.ddMMyyyy2(startDate) ?? '';
        } else {
          return '${DateTimeUtils.ddMMyyyy2(startDate)} - ${DateTimeUtils.ddMMyyyy2(endDate)}';
        }
      }
    }
    return selectedTimeOption?.localizedValue ?? '';
  }
}