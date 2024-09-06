import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_action_chip.dart';
import 'package:user_career_core/views/common_appbar.dart';
import 'package:user_career_more/more/models/enums/date_time_enum.dart';
import 'package:user_career_more/more/pages/views/datetime_picker_view.dart';

@RoutePage()
class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({super.key});

  @override
  ConsumerState createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {

  DateTimeEnum _selectedTimeOption = DateTimeEnum.lastSevenDays;
  final List<DateTimeEnum> _timeOptions = DateTimeEnum.values.toList();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      customAppBar: CommonAppBar(
        centerTitle: true,
        titleText: " Ví của tôi",
      ),
      backgroundColor: AppColors.white3Color,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: AppColors.white1Color,
                child: const ListTile(
                  title: Text('Số dư'),
                  trailing: Text('0đ', style: TextStyle(fontSize: 16.0)),
                ),
              ).paddingSymmetric(vertical: 5.0),

              Container(
                color: AppColors.white1Color,
                child: const ListTile(
                  title: Text('Nạp tiền'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ).paddingOnly(bottom: 5.0),

              Container(
                color: AppColors.white1Color,
                child: const ListTile(
                  title: Text('Thu nhập'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ).paddingOnly(bottom: 5.0),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Lịch sử giao dịch',
                  style: ref.theme.bigTextStyle,
                ),
              ).paddingOnly(bottom: 5.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tìm kiếm giao dịch',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonActionChip(
                    textTitle: 'Hôm nay',
                    // textTitle: ref
                    //     .watch(homeComponentControllerProvider)
                    //     .formatHomeRepostDatetimePicker,
                    titleStyle: ref.theme.smallTextStyle.textColor(AppColors.main1Color),
                    backgroundColor: AppColors.white3Color,
                    iconTitle: Assets.icons.icDown.svg(color: AppColors.main1Color),
                    onTap: () {
                      _showTimeOptions();
                    },
                  ).marginOnly(right: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.main1Color, // Màu chữ của nút
                    ),
                    child: const Text('Tìm kiếm'),
                  ).box(h: 33.0)
                ],
              ),
            ],
          ).paddingAll(12.0).makeColor(AppColors.white1Color),
        ],
      ),
    );
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