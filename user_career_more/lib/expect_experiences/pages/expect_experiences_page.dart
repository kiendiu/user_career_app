import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/expect_experiences/controllers/expect_experiences_controller.dart';
import 'package:user_career_more/expect_experiences/models/expect_experience_response.dart';

@RoutePage()
class ExpectExperiencesPage extends ConsumerStatefulWidget {
  const ExpectExperiencesPage({super.key});

  @override
  ConsumerState createState() => _ExpectExperiencesPageState();
}

class _ExpectExperiencesPageState extends ConsumerState<ExpectExperiencesPage> {
  final _controller = TableViewController();
  late final stringDebouncer = StringDebouncer(
    const Duration(milliseconds: 500),
        (value) {
      _controller.refresh();
    },
  );

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      customAppBar: AppBar(
        title: Text(
          L.more.expectListTileExperiences,
          style: const TextStyle(
            color: AppColors.white1Color,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        leading: const BackButton(color: AppColors.white1Color),
      ),
      fab: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () {
          context.router.push(const AddExperienceRoute());
        },
        child: const Icon(Icons.add, color: AppColors.white1Color,),
      ),
      body: ExtendedListView<ExpectExperienceResponse>(
          emptyDataSource: InfiniteListViewEmptyDataSourceBuilder(
              customEmptyViewBuilder: () => CommonEmptyListView(
                onRefresh: () {
                  _controller.refresh();
                },
              )
          ),
          initialRefresh: true,
          controller: _controller,
          metadataUpdater: ref.watch(expectExperiencesControllerProvider.notifier),
          padding: EdgeInsets.zero,
          onLoadItems: (page) async {
            return ref
                .read(expectExperiencesControllerProvider.notifier)
                .getExpectExperiences(page);
          },
          tableViewItemBuilder: (tableViewItem) {
            final experience = tableViewItem.item;
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
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        experience.nameCategory ?? "",
                        style: ref.theme.bigTextStyle.weight(FontWeight.bold),
                        maxLines: 2,
                      ).paddingOnly(bottom: 5),
                      Text(
                          experience.company ?? "",
                          style: ref.theme.defaultTextStyle
                      ).paddingOnly(bottom: 5),
                      Text(
                          experience.takeWorkingTime ?? "",
                          style: ref.theme.smallTextStyle.weight(FontWeight.w400)
                      ),
                    ],
                  ).paddingOnly(left: 10.0).expand(),
                  CupertinoMenuButton(
                    child: const Icon(Icons.menu),
                    itemsBuilder: (BuildContext context) {
                      return [
                        const CupertinoMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(width: 10),
                                Text("Chỉnh sửa"),
                              ],
                            )
                        ),
                        CupertinoMenuItem(
                          onTap: () {
                            ref.read(expectExperiencesControllerProvider.notifier)
                                .deleteExpectExperiences(experience.experienceId).then((value) {
                                  if(value == true){
                                    _controller.refresh();
                                  }
                            });
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 10),
                              Text("Xóa"),
                            ],
                          )
                        ),
                      ];
                    },
                  ).paddingOnly(right: 10.0),
                ],
              ).marginSymmetric(horizontal: 5, vertical: 5),
            ).paddingOnly(bottom: 12);
          }
      ).paddingSymmetric(horizontal: 10.0)
          .paddingOnly(top: 10.0),
    );
  }
}