import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';
import 'package:user_career_request/request/controllers/bid_controller.dart';
import 'package:user_career_request/request/models/bid_model.dart';
import 'package:user_career_request/request/models/enums/bid_status_enum.dart';
import 'package:user_career_request/request/models/mine_controller_state.dart';
import 'package:user_career_request/request/pages/views/status_container_view.dart';

class BidPage extends ConsumerStatefulWidget {
  const BidPage({super.key});

  @override
  ConsumerState createState() => _BidPageState();
}
class _BidPageState extends ConsumerState<BidPage> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  bool _isOngoing = true;
  final _controller = TableViewController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                      ref.watch(bidControllerProvider.notifier)
                          .setSelected(StatusEnum.open);
                      _controller.refresh();
                    } else {
                      ref.watch(bidControllerProvider.notifier)
                          .setSelected(StatusEnum.closed);
                      _controller.refresh();
                    }
                  });
                });
              },
              selectedColor: AppColors.white1Color,
              color: AppColors.black1Color,
              fillColor: AppColors.main1Color,
              borderColor: AppColors.main1Color,
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
          ).paddingSymmetric(vertical: 8.0).makeColor(AppColors.white1Color),
        ).paddingSymmetric(vertical: 5.0),
        ExtendedListView<BidModel>(
          emptyDataSource: InfiniteListViewEmptyDataSourceBuilder(
              customEmptyViewBuilder: () => CommonEmptyListView(
                onRefresh: () {
                  _controller.refresh();
                },
              )
          ),
          initialRefresh: true,
          controller: _controller,
          metadataUpdater: ref.watch(bidControllerProvider.notifier),
          padding: EdgeInsets.zero,
          onLoadItems: (page) async {
            return ref
                .read(bidControllerProvider.notifier)
                .getListBid(page);
          },
          tableViewItemBuilder: (tableViewItem) {
            final bid = tableViewItem.item;
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
                    bid.requestTitle ?? "",
                    style: ref.theme.defaultTextStyle.weight(FontWeight.bold),
                  ).paddingOnly(bottom: 5),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on_outlined, color: AppColors.mainColor),
                      Text(
                        "Giá: ${bid.price ?? 0}",
                        style: ref.theme.defaultTextStyle,
                      ).paddingOnly(left: 5.0),
                    ],
                  ).paddingOnly(bottom: 5.0),
                  Row(
                    children: [
                      const Icon(Icons.note_alt_outlined, color: AppColors.mainColor),
                      Text(
                        "Mô tả: ${bid.description ?? ""}",
                        style: ref.theme.defaultTextStyle,
                      ).paddingOnly(left: 5.0),
                    ],
                  ).paddingOnly(bottom: 5.0),
                  StatusBidContainerView(bid.status ?? BidStatusEnum.pending),
                ],
              ).paddingSymmetric(horizontal: 10.0, vertical: 10.0),
            ).paddingOnly(bottom: 12);
          }
        ).paddingSymmetric(horizontal: 10.0)
            .paddingOnly(top: 10.0).expand()
      ],
    );
  }
}
