import 'package:auto_route/auto_route.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';

typedef DateSelectionCallback = void Function(
    bool applied, List<DateTime?> selectedDates);

class DatetimePickerView extends ConsumerStatefulWidget {
  final DateSelectionCallback onDateSelected;

  const DatetimePickerView({super.key, required this.onDateSelected});

  @override
  ConsumerState createState() => _DatetimePickerViewState();
}

class _DatetimePickerViewState extends ConsumerState<DatetimePickerView> {
  List<DateTime?> selectedDates = [];

  @override
  Widget build(BuildContext context) {
    // final homeReportDatetimePickerState =
    // ref.watch(homeReportDatetimePickerProvider);

    return Column(
      children: [
        Row(
          children: [
            _buildDateContainer(
              label: L.more.bottomSheetCalanderStartdate,
              // date: homeReportDatetimePickerState?.firstDate,
              isSelected:true
              // (homeReportDatetimePickerState?.isNullSelectedDate ?? true),
            ),
            HSpace.h16,
            _buildDateContainer(
              label: L.more.bottomSheetCalanderEnddate,
              // date: homeReportDatetimePickerState?.lastDate,
              isSelected: true,
              // (homeReportDatetimePickerState?.isNullSelectedDate ?? true),
            ),
          ],
        ).box(h: 50).paddingSymmetric(vertical: 12, horizontal: 16),
        CalendarDatePicker2(
          config: CalendarDatePicker2Config(
            calendarType: CalendarDatePicker2Type.range,
            lastDate: DateTime.now().add(const Duration(days: 0)),
            rangeBidirectional: true,
            centerAlignModePicker: true,
            selectedDayHighlightColor: AppColors.main1Color,
            selectedRangeHighlightColor:
            const Color(0xFF6777EF).withOpacity(0.2),
            weekdayLabels: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
            controlsTextStyle:
            ref.theme.defaultTextStyle.weight(FontWeight.w600),
            disableMonthPicker: true,
            disableModePicker: true,
            modePickerTextHandler: (
                {bool? isMonthPicker, DateTime? monthDate}) {
              final date = monthDate ?? DateTime.now();
              return "${date.month}, ${date.year}";
            },
          ),
          value: selectedDates,
          onValueChanged: (dates) {
            // if (ref
            //     .read(homeComponentControllerProvider.notifier)
            //     .updateReportDatetimePicker(dates)) {
            //   selectedDates = dates;
            // } else {
            //   context.showError(L.home.errorLimitedCustomDatetime);
            // }
          },
        ).box(h: 300),
        _buildButtonControl()
      ],
    );
  }

  Widget _buildDateContainer({
    String? label,
    DateTime? date,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.white4Color,
      ),
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: isSelected
                      ? Assets.icons.icCalendarBottomHome.svg(height: 16, width: 16)
                      : Assets.icons.icCalendarBottomHome
                      .svg(height: 16, width: 16, color: AppColors.main1Color),
                )),
            TextSpan(
              text: date == null ? label : DateTimeUtils.ddMMyyyy2(date),
              style: isSelected
                  ? ref.theme.smallTextStyle
                  : ref.theme.smallTextStyle.textColor(AppColors.main1Color),
            ),
          ],
        ),
      ).paddingSymmetric(vertical: 7, horizontal: 8),
    ).expand();
  }

  Widget _buildButtonControl() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.min,
    children: [
      AppButton.custom(
        title: L.more.bottomSheetCalanderButtonReturn,
        onPressed: () {
          widget.onDateSelected(false, selectedDates);
          context.maybePop();
        },
        titleTextStyle: const TextStyle(
          color: AppColors.black1Color,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        color: AppColors.white4Color,
      ).marginOnly(right: 8).expand(),
      AppButton(
        title: L.more.bottomSheetCalanderButtonApply,
        onPressed: () {
          // widget.onDateSelected(true, selectedDates);
          // ref
          //     .read(homeComponentControllerProvider.notifier)
          //     .setCustomDatetime(selectedDates);
          // context.maybePop();
        },
      ).expand(),
    ],
  ).paddingSymmetric(horizontal: 16).paddingOnly(bottom: 20);
}