import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';
import 'package:user_career_request/core/router.gm.dart';
import 'package:user_career_request/request/controllers/general_controller.dart';
import 'package:user_career_request/request/models/request_model.dart';

@RoutePage()
class GeneralPage extends ConsumerStatefulWidget {
  const GeneralPage({super.key});

  @override
  ConsumerState createState() => _GeneralPageState();
}

class _GeneralPageState extends ConsumerState<GeneralPage> {
  final _controller = TableViewController();

  @override
  Widget build(BuildContext context) {
    return ExtendedListView<RequestModel>(
        emptyDataSource: InfiniteListViewEmptyDataSourceBuilder(
            customEmptyViewBuilder: () => CommonEmptyListView(
              onRefresh: () {
                _controller.refresh();
              },
            )
        ),
        initialRefresh: true,
        controller: _controller,
        metadataUpdater: ref.watch(generalControllerProvider.notifier),
        padding: EdgeInsets.zero,
        onLoadItems: (page) async {
          return ref
              .read(generalControllerProvider.notifier)
              .getListExpects(page);
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
                ).paddingOnly(bottom: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.monetization_on_outlined, color: AppColors.mainColor),
                        Text(
                          "Ngân sách: ${request.budget ?? 0}",
                          style: ref.theme.defaultTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined, color: AppColors.mainColor),
                        Text(
                          "Thời hạn: ${request.biddingEndDate.ddMMyyyy2()}",
                          style: ref.theme.defaultTextStyle,
                        ),
                      ],
                    )
                  ],
                ).paddingOnly(bottom: 5.0),
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
                )
              ],
            ).paddingAll(10.0),
          ).paddingOnly(bottom: 12).onTapWidget((){
            context.pushRoute(RequestDetailRoute(request: request));
          });
        }
    ).paddingSymmetric(horizontal: 10.0)
        .paddingOnly(top: 10.0);
  }
}
