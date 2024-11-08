import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/controllers/category_controller.dart';
import 'package:user_career_auth/admin/controllers/category_info_controller.dart';
import 'package:user_career_auth/admin/models/category_model.dart';
import 'package:user_career_auth/admin/pages/views/category_views/category_detail_view.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';

import 'category_info_view.dart';

class CategoryTab extends ConsumerStatefulWidget {
  const CategoryTab({super.key});

  @override
  ConsumerState createState() => _CategoryTabState();
}

class _CategoryTabState extends ConsumerState<CategoryTab> {
  final _tableViewController =
  EditableExtendedListViewController<CategoryModel>();

  @override
  void initState() {
    super.initState();
    NotificationCenter().addObserver(RawStringNotificationName("deleteItemCategory"),
        callback: (item) {
          if (item is CategoryModel) {
            _tableViewController.deleteItem(item);
          }
        });

    NotificationCenter().addObserver(RawStringNotificationName("reloadCategoryListView"),
        callback: (notification) {
          _tableViewController.refresh();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(5),
        Text(
          "+ Thêm danh mục",
          style: ref.theme.defaultTextStyle.copyWith(
            color: AppColors.mainColor,
          ),
          textAlign: TextAlign.center,
        ).paddingSymmetric(vertical: 10)
            .width(double.infinity)
            .makeColor(AppColors.white1Color)
            .onTapWidget(() {
              context.showOverlay(const CategoryDetailView());
            }),
        const Gap(5),
        ExtendedListView<CategoryModel>(
            padding: EdgeInsets.zero,
            emptyDataSource: InfiniteListViewEmptyDataSourceBuilder(
                customEmptyViewBuilder: () => CommonEmptyListView(
                  onRefresh: () {
                    _tableViewController.refresh();
                  },
                )
            ),
            controller: _tableViewController,
            onLoadItems: (int page) {
              return ref
                .read(categoryControllerProvider.notifier)
                .getCategories();
            },
            metadataUpdater: ref.watch(categoryControllerProvider.notifier),
            separatorBuilder: (_) => const Gap(6,
                crossAxisExtent: double.maxFinite, color: AppColors.white3Color),
            tableViewItemBuilder: (tableViewItem) {
              final item = tableViewItem.item;
              return Consumer(
                  builder: (context, ref, child) {
                    var itemParent = ref.watch(categoryItemsProvider(item.parentId));
                    return CategoryInfoView(category: CategoryFullModel(
                        categoryModel: item,
                        parentCategoryModel: itemParent
                      ),
                    );
                  }
              );
            }).expand(),
      ],
    );
  }
}
