import 'package:flutter/material.dart';
import 'package:user_career_auth/admin/controllers/dash_board_controllers/sale_chart_controller.dart';
import 'package:user_career_auth/admin/pages/views/dash_board_views/tooltip_view.dart';
import 'package:user_career_core/user_career_core.dart';

import 'cartesian_chart_view.dart';
import 'chart_data.dart';

class SaleChartView extends StatelessWidget {
  final double? height;
  final SaleChartState data;
  const SaleChartView({super.key, this.height, required this.data});

  @override
  Widget build(BuildContext context) {
    return CartesianChartView<DefaultSplineChartData,
        DefaultSplineChartDataGroups>(
      tooltipBuilder: (info) {
        if (info == null) return const SizedBox();
        return TooltipView(
          info: info,
          pointDataBuilder: (info) {
            return info.points.mapIndexed(
                  (index, element) {
                if (index == 0) {
                  return PointData(
                    color: const Color(0xff005CF7),
                    label: "Lịch đặt",
                  );
                } else if (index == 1) {
                  return PointData(
                    color: const Color(0xffFF424F),
                    label: "Doanh thu",
                  );
                } else {
                  return PointData(
                    color: const Color(0xff00AB56),
                    label: "Chuyên gia",
                  );
                }
              },
            ).toList();
          },
        );
      },
      height: height ?? context.height,
      data: ChartDataGroups(
        [
          (
          GroupConfig("Lịch đặt", "#005CF7",
              ChartType.spline),
          data.quotes,
          ),
          (
          GroupConfig("Doanh thu",
              "#FF424F", ChartType.spline),
          data.contracts,
          ),
          (
          GroupConfig("Chuyên gia", "#00AB56",
              ChartType.spline),
          data.orders,
          ),
        ],
      ),
    );
  }
}

