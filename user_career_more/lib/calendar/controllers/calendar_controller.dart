import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/calendar/controllers/report_datetime_picker_controller.dart';
import 'package:user_career_more/calendar/models/report_datetime_picker.dart';
import 'package:user_career_more/calendar/models/calendar_controller_state.dart';
import 'package:user_career_more/calendar/models/date_time_enum.dart';
import 'package:user_career_more/calendar/models/user_expect_enum.dart';

class CalendarController extends AutoDisposeNotifier<CalendarControllerState> {
  final dateTimeNow = DateTime.now();

  @override
  CalendarControllerState build() {
    return CalendarControllerState(
      type: UserExpectEnum.allType,
      endDate: dateTimeNow,
      startDate: dateTimeNow.add(const Duration(days: 7)),
      selectedTimeOption: DateTimeEnum.nextSevenDays,
    );
  }

  String? formatDatetime(DateTime? date) {
    if (date == null) return '';
    return DateTimeUtils.ddMMyyyy2(date);
  }

  void updateSelectedType(UserExpectEnum? selectedType) {
    state = state.copyWith(type: selectedType);
  }

  void updateSelectedSortOption(DateTimeEnum? selectedTimeOption) {
    final option = DateTimeEnum.values.firstWhereOrNull(
          (e) => e == selectedTimeOption,
    );

    if (option == DateTimeEnum.customDay) {
      ref.read(reportDatetimePickerProvider.notifier).state = ReportDatetimePicker(
        firstDate: state.reportDatetimePicker?.firstDate,
        lastDate: state.reportDatetimePicker?.lastDate,
      );
    } else {
      ref.read(reportDatetimePickerProvider.notifier).state = ReportDatetimePicker();
      if (option == DateTimeEnum.nextMonth) {
        state = state.copyWith(
            endDate: DateTime(dateTimeNow.year, dateTimeNow.month, 0));
      } else {
        state = state.copyWith(endDate: dateTimeNow);
      }

      state = state.copyWith(
          startDate: option?.rawValue, selectedTimeOption: option);
    }
  }

  bool updateReportDatetimePicker(List<DateTime?> selectedDates) {
    ReportDatetimePicker homeReportDatetimePicker = ReportDatetimePicker(
      firstDate: selectedDates.first,
      lastDate:selectedDates.length == 1
          ? selectedDates.first
          : selectedDates.last,
    );
    if (homeReportDatetimePicker.checkLimitedReportDatetimePicker) {
      ref.read(reportDatetimePickerProvider.notifier).state = homeReportDatetimePicker;
      return true;
    } else {
      homeReportDatetimePicker.resetDateTime();
      ref.read(reportDatetimePickerProvider.notifier).state = homeReportDatetimePicker;
      return false;
    }
  }

  void setCustomDatetime(List<DateTime?> selectedDates){
    if (selectedDates.length == 1) {
      state = state.copyWith(
        startDate: selectedDates[0]!,
        endDate: selectedDates[0]!,
        selectedTimeOption: DateTimeEnum.customDay,
      );
    } else if (selectedDates.length == 2) {
      if(selectedDates.first == selectedDates.last){
        selectedDates.removeLast();
      }
      state = state.copyWith(
        startDate: selectedDates[0]!,
        endDate: selectedDates[1]!,
        selectedTimeOption: DateTimeEnum.customDay,
      );
    }
  }

}

final calendarControllerProvider =
NotifierProvider.autoDispose<CalendarController, CalendarControllerState>(
      () => CalendarController(),
);
