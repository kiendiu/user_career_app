import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/controllers/language_controllers/language_controller.dart';
import 'package:user_career_auth/admin/models/language_model.dart';
import 'package:user_career_auth/admin/pages/views/language_views/language_detail_view.dart';
import 'package:user_career_auth/admin/pages/views/language_views/language_info_View.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';

class LanguageTab extends ConsumerStatefulWidget {
  const LanguageTab({super.key});

  @override
  ConsumerState createState() => _LanguageTabState();
}

class _LanguageTabState extends ConsumerState<LanguageTab> {
  final _tableViewController =
  EditableExtendedListViewController<LanguageModel>();

  @override
  void initState() {
    super.initState();
    NotificationCenter().addObserver(RawStringNotificationName("deleteItemLanguage"),
        callback: (item) {
          if (item is LanguageModel) {
            _tableViewController.deleteItem(item);
          }
        });

    NotificationCenter().addObserver(RawStringNotificationName("reloadLanguageListView"),
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
          "+ Thêm ngôn ngữ",
          style: ref.theme.defaultTextStyle.copyWith(
            color: AppColors.mainColor,
          ),
          textAlign: TextAlign.center,
        ).paddingSymmetric(vertical: 10)
            .width(double.infinity)
            .makeColor(AppColors.white1Color)
            .onTapWidget(() {
          context.showOverlay(const LanguageDetailView());
        }),
        const Gap(5),
        ExtendedListView<LanguageModel>(
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
                  .read(languageControllerProvider.notifier)
                  .getLanguages();
            },
            metadataUpdater: ref.watch(languageControllerProvider.notifier),
            separatorBuilder: (_) => const Gap(6,
                crossAxisExtent: double.maxFinite, color: AppColors.white3Color),
            tableViewItemBuilder: (tableViewItem) {
              final item = tableViewItem.item;
              return Consumer(
                  builder: (context, ref, child) {
                    return LanguageInfoView(languageModel: item);
                  }
              );
            }).expand(),
      ],
    );
  }
}
