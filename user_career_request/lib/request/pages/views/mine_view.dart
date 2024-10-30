import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';
import 'package:user_career_request/core/router.gm.dart';
import 'package:user_career_request/request/controllers/mine_controller.dart';
import 'package:user_career_request/request/models/mine_controller_state.dart';
import 'package:user_career_request/request/models/request_model.dart';

@RoutePage()
class MinePage extends ConsumerStatefulWidget {
  const MinePage({super.key});

  @override
  ConsumerState createState() => _MinePageState();
}

class _MinePageState extends ConsumerState<MinePage> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  bool _isOngoing = true;
  final _controller = TableViewController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    NotificationCenter().addObserver(
        RawStringNotificationName('reloadMine'), callback: (_) {
      _controller.refresh();
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.white1Color,
          child: Center(
            child: ToggleButtons(
              isSelected: [_isOngoing, !_isOngoing],
              onPressed: (int index) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _isOngoing = index == 0;
                    if (_isOngoing) {
                      ref.watch(mineControllerProvider.notifier)
                          .setSelected(StatusEnum.open);
                      _controller.refresh();
                    } else {
                      ref.watch(mineControllerProvider.notifier)
                          .setSelected(StatusEnum.closed);
                      _controller.refresh();
                    }
                  });
                });
              },
              selectedColor: AppColors.white1Color,
              color: AppColors.black1Color,
              fillColor: AppColors.mainColor,
              borderColor: AppColors.mainColor,
              selectedBorderColor: AppColors.main1Color,
              borderRadius: BorderRadius.circular(8),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Đang diễn ra'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Đã kết thúc'),
                ),
              ],
            ),
          ).paddingSymmetric(vertical: 5.0).makeColor(AppColors.white1Color),
        ).paddingOnly(top: 5.0),
        ExtendedListView<RequestModel>(
          emptyDataSource: InfiniteListViewEmptyDataSourceBuilder(
              customEmptyViewBuilder: () => CommonEmptyListView(
                onRefresh: () {
                  _controller.refresh();
                },
              )
          ),
          initialRefresh: true,
          controller: _controller,
          metadataUpdater: ref.watch(mineControllerProvider.notifier),
          padding: EdgeInsets.zero,
          onLoadItems: (page) async {
            return ref
                .read(mineControllerProvider.notifier)
                .getListMine(page);
          },
          tableViewItemBuilder: (tableViewItem) {
            final request = tableViewItem.item;
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      request.title ?? "",
                      style: ref.theme.defaultTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                  ).paddingOnly(bottom: 12.0),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on_outlined, color: AppColors.mainColor),
                      Text(
                        "Ngân sách: ${NumberFormat('#,###').format(request.budget ?? 0)}đ",
                        style: ref.theme.defaultTextStyle,
                      ),
                    ],
                  ).paddingOnly(bottom: 12),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined, color: AppColors.mainColor),
                      Text(
                        "Thời hạn: ${request.biddingEndDate.ddMMyyyy2()}",
                        style: ref.theme.defaultTextStyle,
                      ),
                    ],
                  ).paddingOnly(bottom: 12),
                  Row(
                    children: [
                      const Icon(
                          Icons.bookmark_border,
                          color: AppColors.mainColor
                      ),
                      Text(
                        request.totalBids == 0 ? "Chưa có chào giá" : "Đã có ${request.totalBids} chào giá",
                        style: ref.theme.defaultTextStyle,
                      ),
                    ],
                  ).paddingOnly(bottom: 12.0),
                  Text(
                    request.description ?? "",
                    style: ref.theme.defaultTextStyle.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ).paddingAll(12.0),
            ).paddingOnly(bottom: 12).onTapWidget((){
              context.pushRoute(RequestDetailRoute(request: request, isMine: true));
            });
          }
        ).paddingSymmetric(horizontal: 12.0)
          .paddingOnly(top: 5.0).expand()
      ],
    );
  }
}
