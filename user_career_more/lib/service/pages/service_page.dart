import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_action_chip.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';
import 'package:user_career_more/service/controllers/service_controller.dart';
import 'package:user_career_more/service/controllers/service_item_controller.dart';
import 'package:user_career_more/service/models/review_model.dart';
import 'package:user_career_more/service/models/service_model.dart';
import 'package:user_career_more/service/models/status_service_enum.dart';
import 'package:user_career_more/calendar/models/user_expect_enum.dart';
import 'package:user_career_more/service/pages/payment_container_view.dart';
import 'package:user_career_more/service/pages/payment_view.dart';
import 'package:user_career_more/service/pages/review_view.dart';
import 'package:user_career_more/wallet/pages/star_rating_view.dart';

@RoutePage()
class ServicePage extends ConsumerStatefulWidget {
  StatusServiceEnum? selectedStatusOption;
   ServicePage({super.key, this.selectedStatusOption});

  @override
  ConsumerState createState() => _ServicePageState();
}

class _ServicePageState extends ConsumerState<ServicePage> {
  final List<StatusServiceEnum> _statusOptions = StatusServiceEnum.values.toList();

  UserExpectEnum _selectedTypeOption = UserExpectEnum.allType;
  final List<UserExpectEnum> _typeOptions = UserExpectEnum.values.toList();

  final controller = TableViewController();

  @override
  void initState() {
    super.initState();
    NotificationCenter().addObserver(
        RawStringNotificationName('reloadService'), callback: (_) {
      controller.refresh();
    });
  }

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
            ).marginSymmetric(horizontal: 12.0),
          ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.serviceName ?? '',
                                  style: ref.theme.bigTextStyle.weight(FontWeight.w600),
                                ),
                                Storage.get(POSStorageKey.userId) == item.userId
                                    ? const SizedBox()
                                    : CupertinoMenuButton(
                                  buttonPadding: const EdgeInsets.all(8),
                                  child: const Icon(Icons.menu_outlined),
                                  itemsBuilder: (_) {
                                    final nextStatuses = getNextStatuses(StatusServiceEnum.values.firstWhere((e) => e.rawValue == item.status));
                                    return nextStatuses.map((status) {
                                      return CupertinoMenuItem(
                                        trailing: Icon(status.icon, color: Colors.green),
                                        child: Text(
                                          status.localizedValue,
                                          style: ref.theme.defaultTextStyle.copyWith(
                                            color: Colors.green,
                                          ),
                                        ),
                                        onTap: () {
                                          serviceController.updateStatusService(item.bookId ?? 0, status.rawValue).then((value){
                                            if(value){
                                              switch (status) {
                                                case StatusServiceEnum.pending:
                                                  serviceController.updateStatusSelected(StatusServiceEnum.pending);
                                                  controller.refresh();
                                                  break;
                                                case StatusServiceEnum.inProgress:
                                                  serviceController.updateStatusSelected(StatusServiceEnum.inProgress);
                                                  controller.refresh();
                                                  break;
                                                case StatusServiceEnum.confirmed:
                                                  serviceController.updateStatusSelected(StatusServiceEnum.confirmed);
                                                  controller.refresh();
                                                  break;
                                                case StatusServiceEnum.completed:
                                                  serviceController.updateStatusSelected(StatusServiceEnum.completed);
                                                  controller.refresh();
                                                  break;
                                                default:
                                                  break;
                                              }
                                              context.showSuccess("Cập nhật trạng thái thành công!");
                                            }
                                          });
                                        },
                                      );
                                    }).toList();
                                  },
                                ),
                              ],
                            ),
                            Storage.get(POSStorageKey.userId) == item.userId
                                ? RichText(
                              text: TextSpan(
                                text: 'Chuyên gia: ',
                                style: ref.theme.defaultTextStyle,
                                children: [
                                  TextSpan(
                                    text: item.expertName ?? '',
                                    style: ref.theme.defaultTextStyle.copyWith(
                                      color: AppColors.mainColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        NotificationCenter()
                                            .postNotification(openNotification, {
                                          "type": "request",
                                          "expert_id": item.expertId
                                        });
                                      },
                                  ),
                                ],
                              ),
                            )
                                : RichText(
                              text: TextSpan(
                                text: 'Khách hàng: ',
                                style: ref.theme.defaultTextStyle,
                                children: [
                                  TextSpan(
                                    text: item.userName ?? '',
                                    style: ref.theme.defaultTextStyle.copyWith(
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Ngày hẹn: ${(item.scheduleTime.hhMMddyyyy2() ?? '')}",
                              style: ref.theme.defaultTextStyle,
                            ).paddingOnly(bottom: 5),
                            Text(
                              "Thời gian: ${(item.duration ?? '')} phút",
                            ).paddingOnly(bottom: 5),
                            Text(
                              "Hinh thức: ${(item.contactMethod ?? '')}",
                            ).paddingOnly(bottom: 5),
                            item.contactMethod == 'offline'
                              ? Text(
                                  "Địa chỉ: ${(item.address ?? '')}",
                                  style: ref.theme.defaultTextStyle
                                ).paddingOnly(bottom: 5)
                              : const SizedBox.shrink(),
                            item.contactMethod == 'offline'
                                ? Text(
                                    "Tên địa điểm: ${(item.locationName ?? '')}",
                                    style: ref.theme.defaultTextStyle
                                  ).paddingOnly(bottom: 5)
                                : const SizedBox.shrink(),
                            item.isReviewed == true
                              ? Row(
                                  children: [
                                    StarRating(rating: (item.review?.rating ?? 0).toDouble(), sizeStar: 18),
                                    Text(
                                      item.review?.comment ?? '',
                                      maxLines: 2,
                                      style: ref.theme.defaultTextStyle
                                    ).paddingOnly(left: 8).expand(),
                                  ],
                                ).paddingOnly(bottom: 5)
                              : const SizedBox.shrink(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    StatusPaymentContainerView(PaymentStatusEnum.values.firstWhere((e) => e.rawValue == item.isPaid)),
                                    Storage.get(POSStorageKey.userId) != item.userId || item.isPaid == true
                                        ? const SizedBox()
                                        : Text(
                                            "Thanh toán tại đây",
                                            style: ref.theme.smallTextStyle.copyWith(
                                              color: AppColors.mainColor,
                                            ),
                                          ),
                                  ]
                                ).onTapWidget(() => context.showOverlay(PaymentView(serviceModel: item))).paddingOnly(bottom: 5),
                                Storage.get(POSStorageKey.userId) == item.userId &&serviceState.statusSelected == StatusServiceEnum.completed
                                 ? item.isReviewed == false
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          border: Border.all(width: 1, color: AppColors.mainColor),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: child ??
                                            const Text("Đánh giá",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                )),
                                      ).onTapWidget(() => context.showOverlay(ReviewView(bookId: item.bookId ?? 0)))
                                    : Row(
                                        children: [
                                          const Icon(Icons.check, size: 20, color: AppColors.mainColor),
                                          Text(
                                            "Đã đánh giá",
                                            style: ref.theme.mediumTextStyle.copyWith(
                                              color: AppColors.mainColor,
                                            ),
                                          )
                                        ],
                                      )
                                : const SizedBox.shrink(),
                              ],
                            ),
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

  List<StatusServiceEnum> getNextStatuses(StatusServiceEnum currentStatus) {
    switch (currentStatus) {
      case StatusServiceEnum.pending:
        return [StatusServiceEnum.confirmed];
      case StatusServiceEnum.confirmed:
        return [StatusServiceEnum.inProgress];
      case StatusServiceEnum.inProgress:
        return [StatusServiceEnum.completed];
      default:
        return [];
    }
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