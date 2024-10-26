import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/Calendar/models/calendar_model.dart';
import 'package:user_career_more/core/repository.dart';

abstract interface class ICalendarRepository{
  ResultFuture<BaseListResponse<CalendarModel>> getListCalendars(BaseParams params);
}

class CalendarRepository extends MoreBaseRepository
    implements ICalendarRepository{
  @override
  ResultFuture<BaseListResponse<CalendarModel>> getListCalendars(BaseParams params) {
    return make.request(
      path: '/manages/consultation_schedule',
      params: params,
      decoder: BaseListResponseModel.decodeBy(() => CalendarModel()),
    ).get();
  }
}

final calendarRepositoryProvider = Provider.autoDispose<ICalendarRepository>((ref) {
  return CalendarRepository();
});