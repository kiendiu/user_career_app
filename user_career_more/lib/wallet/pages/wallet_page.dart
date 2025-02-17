import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_action_chip.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/wallet/controllers/wallet_controller.dart';
import 'package:user_career_more/wallet/models/balance_fluctuation_enum.dart';
import 'package:user_career_more/wallet/models/history_response.dart';

@RoutePage()
class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({super.key});

  @override
  ConsumerState createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {

  final List<BalanceFluctuationEnum> _balanceOptions = BalanceFluctuationEnum.values.toList();

  final controller = TableViewController();

  @override
  Widget build(BuildContext context) {
    final walletBalanceState = ref.watch(walletBalanceControllerProvider);
    final walletController = ref.watch(walletControllerProvider);

    return BaseScaffold(
      customAppBar: BaseAppBarView(
        title: "Ví của tôi",
      ),
      backgroundColor: AppColors.white3Color,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: AppColors.white1Color,
                child: ListTile(
                  title: const Text('Số dư'),
                  trailing: walletBalanceState.maybeWhen(
                    data: (data) => Text(
                      "${NumberFormat("###,###", "vi_VN").format(data.walletBalance ?? 0)} đ",
                      style: ref.theme.defaultTextStyle.copyWith(
                        color: AppColors.main1Color,
                      ),
                    ),
                    orElse: () => const SizedBox(),
                  ),
                ),
              ).paddingSymmetric(vertical: 5.0),

              Container(
                color: AppColors.white1Color,
                child: const ListTile(
                  title: Text('Nạp tiền'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ).paddingOnly(bottom: 5.0).onTapWidget(() {
                context.router.push(const DepositWalletRoute());
              }),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Biến động số dư',
                      style: ref.theme.defaultTextStyle,
                    ),
                  ),
                  CommonActionChip(
                    textTitle: ref.watch(walletControllerProvider).type.localizedValue,
                    titleStyle: ref.theme.smallTextStyle.textColor(AppColors.main1Color),
                    backgroundColor: AppColors.white3Color,
                    iconTitle: Assets.icons.icDown.svg(color: AppColors.main1Color),
                    onTap: () {
                      _showTypeOptions();
                    },
                  ).marginOnly(right: 8)
                ],
              ).paddingOnly(bottom: 5.0),
            ],
          ).paddingSymmetric(horizontal: 12.0).makeColor(AppColors.white1Color),
          const Gap(5),
          ExtendedListView<HistoryResponse>(
              emptyDataSource: InfiniteListViewEmptyDataSourceBuilder(
                  customEmptyViewBuilder: () => CommonEmptyListView(
                    onRefresh: () {
                      controller.refresh();
                    },
                    emptyResultMessage: "Chưa có giao dịch nào!",
                  ),
              ),
              initialRefresh: true,
              controller: controller,
              metadataUpdater: ref.watch(walletControllerProvider.notifier),
              padding: EdgeInsets.zero,
              onLoadItems: (page) async {
                return ref
                    .read(walletControllerProvider.notifier)
                    .getHistory(page);
              },
              tableViewItemBuilder: (tableViewItem) {
                final item = tableViewItem.item;
                return Container(
                  color: AppColors.white1Color,
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          item.content ?? '',
                          style: ref.theme.mediumTextStyle.weight(FontWeight.w600),
                        ).paddingOnly(bottom: 5.0),
                        Text(
                          item.createdAt.hhMMddyyyy1() ?? "",
                          style: ref.theme.defaultTextStyle.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children:[
                            (item.isAdd ?? false )
                              ? const Icon(Icons.add, size: 12, color: Colors.green)
                              : const Icon(Icons.remove, size: 12, color: Colors.red),
                            Text(
                              "${NumberFormat("###,###", "vi_VN").format(item.amount ?? 0)} đ",
                              style: ref.theme.defaultTextStyle.copyWith(
                                color: (item.isAdd ?? false) ? Colors.green : Colors.red,
                              ),
                            ),
                          ]
                        )
                      ]
                  ).paddingSymmetric(horizontal: 12, vertical: 8),
                ).paddingOnly(bottom: 5.0);
              }
          ).expand()
        ],
      ),
    );
  }

  void _showTypeOptions(){
    final items = _balanceOptions.map((option) {
      return InteractiveListItem.normal(
        isSelected: ref.watch(walletControllerProvider).type == option,
        title: option.localizedValue,
        onPressed: () {
          ref.read(walletControllerProvider.notifier)
              .setBalanceFluctuationType(option);
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