import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_action_chip.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';
import 'package:user_career_more/service/controllers/service_controller.dart';
import 'package:user_career_more/service/controllers/service_item_controller.dart';
import 'package:user_career_more/service/models/service_model.dart';
import 'package:user_career_more/service/models/status_service_enum.dart';
import 'package:user_career_more/calendar/models/user_expect_enum.dart';
import 'package:user_career_more/service/pages/payment_container_view.dart';

@RoutePage()
class ServicePage extends ConsumerStatefulWidget {
  StatusServiceEnum? selectedStatusOption;
   ServicePage({super.key, this.selectedStatusOption});

  @override
  ConsumerState createState() => _ServicePageState();
}

class _ServicePageState extends ConsumerState<ServicePage> {
  //StatusServiceEnum _selectedStatusOption = StatusServiceEnum.pending;
  final List<StatusServiceEnum> _statusOptions = StatusServiceEnum.values.toList();

  UserExpectEnum _selectedTypeOption = UserExpectEnum.allType;
  final List<UserExpectEnum> _typeOptions = UserExpectEnum.values.toList();

  final controller = TableViewController();

  @override
  Widget build(BuildContext context) {
    final serviceController = ref.watch(serviceControllerProvider(widget.selectedStatusOption).notifier);
    final serviceState = ref.watch(serviceControllerProvider(widget.selectedStatusOption));

    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      customAppBar: BaseAppBarView(
        title: "Quản lý dịch vụ",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CommonActionChip(
                  textTitle: serviceState.statusSelected?.localizedValue ?? '',
                  titleStyle: ref.theme.smallTextStyle.textColor(AppColors.main1Color),
                  backgroundColor: AppColors.white1Color,
                  iconTitle: Assets.icons.icDown.svg(color: AppColors.main1Color),
                  onTap: () {
                    _showStatusOptions();
                  },
                ).marginOnly(right: 12),
                CommonActionChip(
                  textTitle: serviceState.typeSelected?.localizedValue ?? '',
                  titleStyle: ref.theme.smallTextStyle.textColor(AppColors.main1Color),
                  backgroundColor: AppColors.white1Color,
                  iconTitle: Assets.icons.icDown.svg(color: AppColors.main1Color),
                  onTap: () {
                    _showTypeOptions();
                  },
                ).marginOnly(right: 8)

              ],
            ).marginSymmetric(horizontal: 12.0, vertical: 8.0),
          ).paddingSymmetric(vertical: 5.0),
          TableView<ServiceModel>(
            emptyDataSource: InfiniteListViewEmptyDataSourceBuilder(
                customEmptyViewBuilder: () => CommonEmptyListView(
                  onRefresh: () {
                    controller.refresh();
                  }, emptyResultMessage: "Chưa có dịch vụ nào!",
                )),
            controller: controller,
            padding: EdgeInsets.zero,
            metadataUpdater: serviceController,
            onLoadItems: (int page) async {
              return serviceController.getListServices(page);
            },
            itemBuilder: (service) {
              return Consumer(
                builder: (context, ref, child) {
                  var item = ref.watch(serviceItemProvider(service.bookId));

                  if (item == null) return const SizedBox.shrink();

                  return Column(
                    children: [
                      Container(
                        color: AppColors.white1Color,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              item.serviceName ?? '',
                              style: ref.theme.bigTextStyle.weight(FontWeight.w600),
                            ),
                            Text(
                              "Chuyên gia: ${(item.expertName ?? '')}",
                              style: ref.theme.defaultTextStyle.copyWith(
                                color: AppColors.mainColor,
                              ),
                            ).onTapWidget((){
                              NotificationCenter()
                                  .postNotification(openNotification, {
                                "type": "request",
                                "expert_id": item.expertId
                              });
                            }),
                            Text(
                              "Ngày hẹn: ${(item.scheduleTime.hhMMddyyyy2() ?? '')}",
                              style: ref.theme.defaultTextStyle,
                            ),
                            Text(
                              "Thời gian: ${(item.duration ?? '')} phút",
                            ),
                            Text(
                              "Hinh thức: ${(item.contactMethod ?? '')}",
                            ),
                            item.contactMethod == 'offline'
                              ? Text(
                                  "Địa chỉ: ${(item.address ?? '')}",
                                  style: ref.theme.defaultTextStyle
                                )
                              : const SizedBox.shrink(),
                            item.contactMethod == 'offline'
                                ? Text(
                                    "Tên địa điểm: ${(item.locationName ?? '')}",
                                    style: ref.theme.defaultTextStyle
                                  )
                                : const SizedBox.shrink(),
                            StatusPaymentContainerView(PaymentStatusEnum.values.firstWhere((e) => e.rawValue == item.isPaid)),
                          ]
                        ).paddingSymmetric(horizontal: 12, vertical: 8),
                      ),
                      Container(
                        height: 5,
                        color: AppColors.white3Color,
                      ),
                    ],
                  );
                },
              );
            },
          ).expand()
        ],
      ),
    );
  }

  void _showStatusOptions(){
    final items = _statusOptions.map((option) {
      return InteractiveListItem.normal(
        isSelected: ref.watch(serviceControllerProvider(widget.selectedStatusOption)).statusSelected == option,
        title: option.localizedValue,
        onPressed: () {
          ref.read(serviceControllerProvider(widget.selectedStatusOption).notifier).updateStatusSelected(option);
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

  void _showTypeOptions(){
    final items = _typeOptions.map((option) {
      return InteractiveListItem.normal(
        isSelected: _selectedTypeOption == option,
        title: option.localizedValue,
        onPressed: () {
          _selectedTypeOption = option;
          ref.read(serviceControllerProvider(widget.selectedStatusOption).notifier).updateTypeSelected(_selectedTypeOption);
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
}