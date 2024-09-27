import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_action_chip.dart';
import 'package:user_career_more/service/models/status_service_enum.dart';
import 'package:user_career_more/calendar/models/user_expect_enum.dart';

@RoutePage()
class ServicePage extends ConsumerStatefulWidget {
  const ServicePage({super.key});

  @override
  ConsumerState createState() => _ServicePageState();
}

class _ServicePageState extends ConsumerState<ServicePage> {
  StatusServiceEnum _selectedStatusOption = StatusServiceEnum.waiting;
  final List<StatusServiceEnum> _statusOptions = StatusServiceEnum.values.toList();

  UserExpectEnum _selectedTypeOption = UserExpectEnum.allType;
  final List<UserExpectEnum> _typeOptions = UserExpectEnum.values.toList();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      customAppBar: AppBar(
        title: Text(
            'Quản lý dịch vụ của tôi',
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
      body: Column(
        children: [
          Container(
            color: AppColors.main1Color,
            child: Row(
              children: [
                CommonActionChip(
                  textTitle: 'Chờ xác nhận',
                  // textTitle: ref
                  //     .watch(homeComponentControllerProvider)
                  //     .formatHomeRepostDatetimePicker,
                  titleStyle: ref.theme.smallTextStyle.textColor(AppColors.main1Color),
                  backgroundColor: AppColors.white1Color,
                  iconTitle: Assets.icons.icDown.svg(color: AppColors.main1Color),
                  onTap: () {
                    _showStatusOptions();
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

  void _showStatusOptions(){
    final items = _statusOptions.map((option) {
      return InteractiveListItem.normal(
        isSelected: _selectedStatusOption == option,
        title: option.localizedValue,
        onPressed: () {
          _selectedStatusOption = option;
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
}