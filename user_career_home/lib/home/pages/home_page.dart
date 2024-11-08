import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';
import 'package:user_career_home/core/router.gm.dart';
import 'package:user_career_home/home/controllers/home_controller.dart';
import 'package:user_career_home/home/models/expect_response.dart';
import 'package:user_career_home/home/pages/views/star_rating_view.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _controller = TableViewController();
  final _appBarController = BaseAppBarController();

  @override
  void initState() {
    super.initState();

    NotificationCenter()
      .addObserver(RawStringNotificationName("reloadListExpectView"),
      callback: (notification) {
        _controller.refresh();
      });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      customAppBar: BaseAppBarView(
        title: "Danh sách chuyên gia",
        controller: _appBarController,
        shouldShowLeading: false,
        actions: [
          AppBarActionButton(
              child: Assets.icons.icFilter.svg(),
              onTap: () {
                context.pushRoute(const FilterRoute());
              }),
          AppBarActionButton(
              child: Assets.icons.icSearch.svg(),
              onTap: () {
                _appBarController.changeAppBarState(false);
              })
        ],
        onSearchTextChanged: (text) async {
          final searchText = text;
          ref.watch(homeControllerProvider.notifier).setSearchText(searchText);
          _controller.refresh();
        },
      ),
      body: ExtendedListView<ExpectResponse>(
          emptyDataSource: InfiniteListViewEmptyDataSourceBuilder(
              customEmptyViewBuilder: () => CommonEmptyListView(
                onRefresh: () {
                  _controller.refresh();
                },
              )
          ),
          initialRefresh: true,
          controller: _controller,
          metadataUpdater: ref.watch(homeControllerProvider.notifier),
          padding: EdgeInsets.zero,
          onLoadItems: (page) async {
            return ref
                .read(homeControllerProvider.notifier)
                .getListExpects(page);
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
                    url: expect.expectAvatar ?? "",
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
                              expect.expectName ?? '',
                              style: ref.theme.bigTextStyle.weight(FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ).expand(),
                            StarRating(
                              rating: (expect.averageRating ?? 0).toDouble()
                            ).paddingOnly(right: 10.0),
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
                              expect.nameCategory ?? '',
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
                              '${expect.priceOnlineString} / ${expect.timeOnline ?? ''} phút',
                              style: ref.theme.itemTextStyle,
                            ),
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
                              '${expect.priceOfflineString} / ${expect.timeOffline ?? ''} phút',
                              style: ref.theme.itemTextStyle,
                            ).expand(),
                            Text(
                              "Xem chi tiết >> ",
                              style: ref.theme.itemTextStyle.copyWith(color: AppColors.mainColor),
                            ).paddingOnly(right: 10.0).onTapWidget(() {
                              context.pushRoute(ExpectDetailRoute(expectId: expect.expectId ?? 0));
                            }),
                          ],
                        ),
                      ],
                    ).paddingSymmetric(vertical: 10.0)
                  ),
                ],
              )
            ).paddingOnly(bottom: 12);
          }
      ).paddingSymmetric(horizontal: 10.0)
          .paddingOnly(top: 10.0),
    );
  }
}
