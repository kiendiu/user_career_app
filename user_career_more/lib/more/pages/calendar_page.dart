import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_action_chip.dart';
import 'package:user_career_more/more/models/enums/date_time_enum.dart';
import 'package:user_career_more/more/models/enums/user_expect_enum.dart';
import 'package:user_career_more/more/pages/views/datetime_picker_view.dart';

@RoutePage()
class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTimeEnum _selectedTimeOption = DateTimeEnum.lastSevenDays;
  final List<DateTimeEnum> _timeOptions = DateTimeEnum.values.toList();

  UserExpectEnum _selectedTypeOption = UserExpectEnum.allType;
  final List<UserExpectEnum> _typeOptions = UserExpectEnum.values.toList();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      customAppBar: AppBar(
        title: Text(
          'Lịch tư vấn của tôi',
          style: const TextStyle(
              color: AppColors.white1Color,
              fontWeight: FontWeight.w500).size(18)
        ),
        centerTitle: true,
        backgroundColor: AppColors.main1Color,
        leading: IconButton(
          icon: const BackButton(color: AppColors.white1Color),
          onPressed: () {
            context.maybePop();
          },
        ),
      ),
      backgroundColor: AppColors.white3Color,
      body: Column(
        children: [
          Container(
            color: AppColors.main1Color,
            child: Row(
              children: [
                CommonActionChip(
                  textTitle: 'Hôm nay',
                  // textTitle: ref
                  //     .watch(homeComponentControllerProvider)
                  //     .formatHomeRepostDatetimePicker,
                  titleStyle: ref.theme.smallTextStyle.textColor(AppColors.main1Color),
                  backgroundColor: AppColors.white1Color,
                  iconTitle: Assets.icons.icDown.svg(color: AppColors.main1Color),
                  onTap: () {
                    _showTimeOptions();
                  },
                ).marginOnly(right: 8),
                CommonActionChip(
                  textTitle: 'Tất cả',
                  // textTitle: ref
                  //     .watch(homeComponentControllerProvider)
                  //     .formatHomeRepostDatetimePicker,
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

        ],
      ),
    );
  }

  void _showTypeOptions(){
    final items = _typeOptions.map((option) {
      return InteractiveListItem.normal(
        isSelected: _selectedTypeOption == option,
        title: option.localizedValue,
        onPressed: () {
          _selectedTypeOption = option;
          // ref
          //     .read(homeComponentControllerProvider.notifier)
          //     .updateSelectedSortOption(_selectedTimeOption);
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
            // ref
            //     .read(homeComponentControllerProvider.notifier)
            //     .updateSelectedSortOption(_selectedTimeOption);
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
