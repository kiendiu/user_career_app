import 'package:user_career_core/user_career_core.dart';

class CalendarParams extends BaseParams{
  int? page;
  int? size;
  String? type;
  String? startDate;
  String? endDate;

  CalendarParams({
    this.page,
    this.type,
    this.startDate,
    this.endDate
  }): size = 10;


  @override
  Map<String, dynamic> buildParams() {
    return super.buildParams()
      ..addAll({
        "page": page,
        "size": size,
        "type": type,
        "start_date": startDate,
        "end_date": endDate
      });
  }
}