import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_action_chip.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';
import 'package:user_career_more/Calendar/models/calendar_model.dart';
import 'package:user_career_more/calendar/controllers/calendar_controller.dart';
import 'package:user_career_more/calendar/controllers/list_calendar_controller.dart';
import 'package:user_career_more/calendar/models/date_time_enum.dart';
import 'package:user_career_more/calendar/models/user_expect_enum.dart';
import 'package:user_career_more/more/pages/views/datetime_picker_view.dart';

@RoutePage()
class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTimeEnum _selectedTimeOption = DateTimeEnum.nextSevenDays;
  final List<DateTimeEnum> _timeOptions = DateTimeEnum.values.toList();

  final List<UserExpectEnum> _typeOptions = UserExpectEnum.values.toList();

  final controller = TableViewController();

  @override
  Widget build(BuildContext context) {
    final calendarState = ref.watch(calendarControllerProvider);
    final listCalendarsState = ref.watch(listCalendarControllerProvider);

    ref.listen(calendarControllerProvider, (previous, next) {
      if (previous?.startDate != next.startDate) {
        ref.invalidate(listCalendarControllerProvider);
      }
    });

    ref.listen(calendarControllerProvider, (previous, next) {
      if (previous?.endDate != next.endDate) {
        ref.invalidate(listCalendarControllerProvider);
      }
    });

    ref.listen(calendarControllerProvider, (previous, next) {
      if (previous?.type != next.type) {
        ref.invalidate(listCalendarControllerProvider);
      }
    });

    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      customAppBar: BaseAppBarView(
        title: "Lịch tư vấn",
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.white3Color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonActionChip(
                  textTitle: ref
                      .watch(calendarControllerProvider)
                      .formatHomeRepostDatetimePicker,
                  titleStyle: ref.theme.smallTextStyle.textColor(AppColors.main1Color),
                  backgroundColor: AppColors.white1Color,
                  iconTitle: Assets.icons.icDown.svg(color: AppColors.main1Color),
                  onTap: () {
                    _showTimeOptions();
                  },
                ).marginOnly(right: 8),
                CommonActionChip(
                  textTitle: calendarState.type?.localizedValue ?? '',
                  titleStyle: ref.theme.smallTextStyle.textColor(AppColors.main1Color),
                  backgroundColor: AppColors.white1Color,
                  iconTitle: Assets.icons.icDown.svg(color: AppColors.main1Color),
                  onTap: () {
                    _showTypeOptions();
                  },
                ).marginOnly(right: 8)

              ],
            ).marginSymmetric(horizontal: 14.0),
          ),
          ExtendedListView<CalendarModel>(
              emptyDataSource: InfiniteListViewEmptyDataSourceBuilder(
                  customEmptyViewBuilder: () => CommonEmptyListView(
                    onRefresh: () {
                      controller.refresh();
                    },
                  )
              ),
              initialRefresh: true,
              controller: controller,
              metadataUpdater: ref.watch(listCalendarControllerProvider.notifier),
              padding: EdgeInsets.zero,
              onLoadItems: (page) async {
                return ref
                    .read(listCalendarControllerProvider.notifier)
                    .getListCalendars(page);
              },
              tableViewItemBuilder: (tableViewItem) {
                final calendar = tableViewItem.item;
                return Container(
                  color: AppColors.white1Color,
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          calendar.serviceName ?? '',
                          style: ref.theme.bigTextStyle.weight(FontWeight.w600),
                        ).paddingOnly(bottom: 10.0),
                        Storage.get(POSStorageKey.userId) == calendar.userId
                          ? RichText(
                            text: TextSpan(
                              text: 'Lịch hẹn với chuyên gia ',
                              style: ref.theme.defaultTextStyle,
                              children: [
                                TextSpan(
                                  text: calendar.expertName ?? '',
                                  style: ref.theme.defaultTextStyle.copyWith(
                                    color: AppColors.mainColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      NotificationCenter()
                                          .postNotification(openNotification, {
                                        "type": "request",
                                        "expert_id": calendar.expertId
                                      });
                                    },
                                ),
                              ],
                            ),
                          )
                          : RichText(
                          text: TextSpan(
                            text: 'Lịch hẹn với khách hàng ',
                            style: ref.theme.defaultTextStyle,
                            children: [
                              TextSpan(
                                text: calendar.userName ?? '',
                                style: ref.theme.defaultTextStyle.copyWith(
                                  color: AppColors.mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  calendar.contactMethod == 'offline'
                                    ? Icons.people_outline
                                    : Icons.call_outlined,
                                  color: AppColors.mainColor,
                                  size: 18,
                                ),
                                Text(
                                  calendar.contactMethod == 'offline'
                                    ? 'Gặp mặt'
                                    : 'Gọi điện',
                                  style: ref.theme.defaultTextStyle.copyWith(
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              ]
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  color: AppColors.mainColor,size: 18,
                                ),
                                Text(
                                  calendar.scheduleTime.ddMMyyyy2() ?? '',
                                  style: ref.theme.defaultTextStyle.copyWith(
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              ]
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: AppColors.mainColor,
                                  size: 18,
                                ),
                                Text(
                                  '${calendar.scheduleTime.clock2() ?? ''} - ${calendar.scheduleTime?.add(Duration(minutes: calendar.duration ?? 0)).clock2() ?? ''}',
                                  style: ref.theme.defaultTextStyle.copyWith(
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              ]
                            )
                          ]
                        ).paddingSymmetric(vertical: 12),
                        calendar.contactMethod == 'offline'
                            ? Text(
                            "Địa chỉ: ${(calendar.address ?? '')}",
                            style: ref.theme.defaultTextStyle
                        ).paddingOnly(bottom: 5.0)
                            : const SizedBox.shrink(),
                        calendar.contactMethod == 'offline'
                            ? Text(
                            "Tên địa điểm: ${(calendar.locationName ?? '')}",
                            style: ref.theme.defaultTextStyle
                        ).paddingOnly(bottom: 5.0)
                            : const SizedBox.shrink(),
                      ]
                  ).paddingSymmetric(horizontal: 12, vertical: 8),
                ).paddingOnly(bottom: 5.0);
              }
          ).expand()
        ],
      ),
    );
  }

  void _showTypeOptions(){
    final items = _typeOptions.map((option) {
      return InteractiveListItem.normal(
        isSelected: ref.watch(calendarControllerProvider).type == option,
        title: option.localizedValue,
        onPressed: () {
          ref
              .read(calendarControllerProvider.notifier)
              .updateSelectedType(option);
          controller.refresh();
          context.maybePop();
        },
      );
    }).toList();

    InteractiveSheet.fixedList(
      canShowIndicator: false,
      isFloating: false,
      header: Text(L.more.bottomSheetTitle, style: ref.theme.bigTextStyle)
          .align(Alignment.topLeft)
          .marginOnly(left: 12, top: 16),
      items: items,
    ).show();
  }

  void _showTimeOptions() {
    final items = _timeOptions.map((option) {
      return InteractiveListItem.normal(
        isSelected: _selectedTimeOption == option,
        title: option.localizedValue,
        onPressed: () {
          if (option == DateTimeEnum.customDay) {
            context.maybePop().then((value) {
              if (value == true) {
                InteractiveSheet.fixedContent(
                  DatetimePickerView(onDateSelected: (applied, selectedDates) {
                    if (applied) {
                      _selectedTimeOption = option;
                    }
                  }),
                  isFloating: false,
                  canShowIndicator: false,
                ).show();
              }
            });
          } else {
            _selectedTimeOption = option;
            ref.read(calendarControllerProvider.notifier)
                .updateSelectedSortOption(_selectedTimeOption);
            controller.refresh();
            context.maybePop();
          }
        },
      );
    }).toList();

    InteractiveSheet.fixedList(
      canShowIndicator: false,
      isFloating: false,
      header: Text(L.more.bottomSheetTitle, style: ref.theme.bigTextStyle)
          .align(Alignment.topLeft)
          .marginOnly(left: 12, top: 16),
      items: items,
    ).show();
  }
}
