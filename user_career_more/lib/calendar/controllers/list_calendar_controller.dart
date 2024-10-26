import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/Calendar/models/calendar_model.dart';
import 'package:user_career_more/calendar/models/calendar_params.dart';
import 'package:user_career_more/calendar/repositories/calendar_repository.dart';

import 'calendar_controller.dart';

class ListCalendarController extends AutoDisposeNotifier<void>
    with AlertMixin, MetadataUpdater {
  @override
  void build() {
    return;
  }


  Future<List<CalendarModel>> getListCalendars(int page) async {
    try {
      final calendarState = ref.watch(calendarControllerProvider);
      final result = await ref
          .read(calendarRepositoryProvider)
          .getListCalendars(CalendarParams(
            page: page+1,
            type: calendarState.type?.rawValue,
            endDate: calendarState.endDate.toString(),
            startDate: calendarState.startDate.toString(),
          ))
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result;
    } catch (e) {
      return [];
    }
  }
}

final listCalendarControllerProvider = NotifierProvider.autoDispose<
    ListCalendarController, void>(
      () => ListCalendarController(),
);