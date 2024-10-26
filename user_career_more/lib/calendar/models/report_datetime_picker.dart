import 'package:user_career_core/user_career_core.dart';

class ReportDatetimePicker{
  DateTime? firstDate;
  DateTime? lastDate;

  ReportDatetimePicker({this.firstDate, this.lastDate});

  void setStartDate(DateTime? firstDate){
    this.firstDate = firstDate;
  }

  void setEndDate(DateTime? lastDate){
    this.lastDate = lastDate;
  }

  void resetDateTime(){
    firstDate = null;
    lastDate = null;
  }

  ReportDatetimePicker copyWith({
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return ReportDatetimePicker(
      firstDate: firstDate ?? this.firstDate,
      lastDate: lastDate ?? this.lastDate,
    );
  }

  bool get isNullSelectedDate => firstDate.isNull && lastDate.isNull;

  bool get hasOnlyOneSelectedDate => (firstDate.isNotNull && lastDate.isNull)
      || (firstDate.isNull && lastDate.isNotNull);

  bool get hasFullSelectedDate => firstDate.isNotNull && lastDate.isNotNull;

  bool get hasSameValueSelectedDate => firstDate == lastDate;

  bool get checkLimitedReportDatetimePicker => hasFullSelectedDate
      && lastDate!.difference(firstDate!).inDays < 31;
}