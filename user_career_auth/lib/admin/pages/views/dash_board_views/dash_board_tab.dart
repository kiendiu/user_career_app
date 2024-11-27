import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/controllers/dash_board_controllers/opportunity_chart_controller.dart';
import 'package:user_career_auth/admin/controllers/dash_board_controllers/sale_chart_controller.dart';
import 'package:user_career_auth/admin/pages/views/dash_board_views/chart_data.dart';
import 'package:user_career_auth/admin/pages/views/dash_board_views/sale_chart_view.dart';
import 'package:user_career_auth/admin/pages/views/dash_board_views/title_with_mark_view.dart';
import 'package:user_career_core/user_career_core.dart';

import 'chart_container.dart';
import 'opportunity_chart_view.dart';

class DashBoardTab extends ConsumerStatefulWidget {
  const DashBoardTab({super.key});

  @override
  ConsumerState createState() => _DashBoardTabState();
}

class _DashBoardTabState extends ConsumerState<DashBoardTab> {
  @override
  Widget build(BuildContext context) {
    final opportunityState = ref.watch(opportunityChartControllerProvider);
    final saleState = ref.watch(saleChartControllerProvider);
    return RefreshableView(
      onRefresh: () async {
        ref.invalidate(opportunityChartControllerProvider);
        ref.invalidate(saleChartControllerProvider);
      },
      child: SingleChildScrollView(
        child: SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          separatorBuilder: (_, __) => const Gap(20),
          children: [
            // DashBoardSummaryView(
            //     title: L.dashboard.home.businessCondition.revenue,
            //     data: [
            //       DashBoardSummaryViewData(
            //           label: L.dashboard.home.businessCondition
            //               .completedOrders,
            //           icon: Assets.icons.icProductWithCheck.svg(),
            //           content: businessState.value?.orderCount
            //               ?.formattedIntegerChartValue ??
            //               "-"),
            //       DashBoardSummaryViewData(
            //           label: L.dashboard.home.businessCondition
            //               .totalCompletedOrders,
            //           icon: Assets.icons.icMoneyRise.svg(),
            //           maxLine: 1,
            //           content: businessState
            //               .value?.orderValue?.formattedMoneyValue ??
            //               "-"),
            //     ]),
            // DashBoardSummaryView(
            //     title: L.dashboard.home.businessCondition.opportunity,
            //     data: [
            //       DashBoardSummaryViewData(
            //           label: L.dashboard.home.businessCondition
            //               .winOpportunities,
            //           icon: Assets.icons.icStar.svg(),
            //           content: businessState.value?.winOpportunityCount
            //               ?.formattedIntegerChartValue ??
            //               "-"),
            //       DashBoardSummaryViewData(
            //           label:
            //           L.dashboard.home.businessCondition.saleForecast,
            //           icon: Assets.icons.icMoneyRise.svg(),
            //           maxLine: 1,
            //           content: businessState
            //               .value?.saleForecast?.formattedMoneyValue ??
            //               "-"),
            //     ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleWithMarkView(
                    title: "Tỷ lệ hoàn thành lịch hẹn"),
                const Gap(8),
                ChartContainer(
                  height: 350,
                  data: opportunityState,
                  reloadData: () => ref
                      .invalidate(opportunityChartControllerProvider),
                  shouldBuildEmptyDataPlaceholder: (data) =>
                  data.isChartEmpty,
                  chartBuilder: (context, ref, data, height) {
                    return OpportunityChartView(
                        data: data, height: height);
                  },)
                // permissions: const []),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleWithMarkView(
                    title: "Số lượng lịch hẹn, chuyên gia và doanh thu"),
                const Gap(8),
                ChartContainer(
                  reloadData: () =>
                      ref.invalidate(saleChartControllerProvider),
                  height: 350,
                  data: saleState,
                  shouldBuildEmptyDataPlaceholder: (data) =>
                  data.isChartEmpty,
                  chartBuilder: (context, ref, data, height) {
                    return SaleChartView(data: data, height: height);
                  },
                  // permissions: const [],
                ),
              ],
            )
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

class SampleData extends ChartData<String, double> {
  SampleData(super.x, super.y);
}
