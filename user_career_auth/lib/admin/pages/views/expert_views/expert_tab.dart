import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/controllers/expert_controllers/expert_controller.dart';
import 'package:user_career_auth/admin/controllers/expert_controllers/expert_list_controller.dart';
import 'package:user_career_auth/admin/models/enums/approval_container_view.dart';
import 'package:user_career_auth/admin/models/enums/approval_enum.dart';
import 'package:user_career_auth/admin/models/responses/user_response.dart';
import 'package:user_career_auth/core/router.gm.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_action_chip.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';

class ExpertTab extends ConsumerStatefulWidget {
  const ExpertTab({super.key});

  @override
  ConsumerState createState() => _ExpertTabState();
}

class _ExpertTabState extends ConsumerState<ExpertTab> {
  final List<ApprovalEnum> _typeOptions = ApprovalEnum.values.toList();

  final controller = TableViewController();

  @override
  void initState() {
    super.initState();
    NotificationCenter().addObserver(
        RawStringNotificationName('adminExpert'), callback: (_) {
      controller.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(expertControllerProvider);

    return Column(
      children: [
        CommonActionChip(
          textTitle: userState.approval?.localizedValue,
          titleStyle: ref.theme.smallTextStyle.textColor(AppColors.main1Color),
          backgroundColor: AppColors.white1Color,
          iconTitle: Assets.icons.icDown.svg(color: AppColors.main1Color),
          onTap: () {
            _showTypeOptions();
          },
        ),
        Expanded(
          child: ExtendedListView<UserResponse>(
              emptyDataSource: InfiniteListViewEmptyDataSourceBuilder(
                  customEmptyViewBuilder: () => CommonEmptyListView(
                    onRefresh: () {
                      controller.refresh();
                    },
                  )
              ),
              initialRefresh: true,
              controller: controller,
              metadataUpdater: ref.watch(expertListControllerProvider.notifier),
              padding: EdgeInsets.zero,
              onLoadItems: (page) async {
                return ref
                    .read(expertListControllerProvider.notifier)
                    .getUser(page);
              },
              tableViewItemBuilder: (tableViewItem) {
                final expect = tableViewItem.item;
                return Container(
                    decoration: BoxDecoration(
                      color: AppColors.white1Color,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageView(
                          url: expect.avatar ?? "",
                          fit: BoxFit.cover,
                          radius: 50,
                          placeholder: Assets.icons.icAvatarDefault
                              .svg(height: 50, width: 50)
                        ).box(w: 50, h: 50).paddingSymmetric(horizontal: 10.0),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    expect.username ?? '-',
                                    style: ref.theme.bigTextStyle.weight(FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ).expand(),
                                  ApprovalContainerView(expect.approval ?? ApprovalEnum.user).paddingOnly(right: 8),
                                ],
                              ).paddingOnly(bottom: 5.0),
                              Row(
                                children: [
                                  const Icon(
                                      Icons.local_library_outlined,
                                      size: 15,
                                      color: AppColors.mainColor
                                  ).paddingOnly(right: 5.0),
                                  Text(
                                    expect.nameCategory ?? '-',
                                    style: ref.theme.mediumTextStyle.weight(FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                      Icons.phone_in_talk_outlined,
                                      size: 15,
                                      color: AppColors.mainColor
                                  ).paddingOnly(right: 5.0),
                                  Text(
                                    '${expect.priceOnlineString} / ${expect.timeOnline ?? '-'} phút',
                                    style: ref.theme.itemTextStyle,
                                  ).expand(),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                      Icons.people_outline,
                                      size: 15,
                                      color: AppColors.mainColor
                                  ).paddingOnly(right: 5.0),
                                  Text(
                                    '${expect.priceOfflineString} / ${expect.timeOffline ?? '-'} phút',
                                    style: ref.theme.itemTextStyle,
                                  ).expand(),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                      Icons.app_blocking_outlined,
                                      size: 15,
                                      color: AppColors.mainColor
                                  ).paddingOnly(right: 5.0),
                                  Text(
                                    expect.reasonReject ?? '-',
                                    style: ref.theme.itemTextStyle,
                                  ).expand(),
                                  Visibility(
                                    visible: !(expect.approval == ApprovalEnum.user),
                                    child: Text(
                                      expect.approval == ApprovalEnum.pending ? "Duyệt chuyên gia" : "Xem thông tin",
                                      style: ref.theme.itemTextStyle.copyWith(color: AppColors.mainColor),
                                    ).paddingOnly(right: 10.0).onTapWidget(() {
                                      context.pushRoute(UserDetailRoute(
                                          userId: expect.userId ?? 0,
                                          approvalEnum: expect.approval ?? ApprovalEnum.user
                                      ));
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ).paddingSymmetric(vertical: 10.0)
                        ),
                      ],
                    )
                ).paddingOnly(bottom: 12);
              }
          ),
        )
      ],
    ).paddingSymmetric(horizontal: 12).expand();
  }

  void _showTypeOptions(){
    final items = _typeOptions.map((option) {
      return InteractiveListItem.normal(
        isSelected: ref.watch(expertControllerProvider).approval == option,
        title: option.localizedValue,
        onPressed: () {
          ref.read(expertControllerProvider.notifier)
              .setApproval(option);
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
