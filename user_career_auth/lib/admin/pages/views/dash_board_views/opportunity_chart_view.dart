import 'package:flutter/material.dart';
import 'package:user_career_auth/admin/models/chart_data.dart';
import 'package:user_career_core/user_career_core.dart';

import 'base_pie_chart.dart';

class OpportunityChartView extends StatelessWidget {
  final OpportunityChartData data;
  final double? height;

  const OpportunityChartView({super.key, required this.data, this.height});

  @override
  Widget build(BuildContext context) {
    return BasePieChart(
      chartData: [
        BasePieChartData("Hoàn thành",
            data.winOpportunityCount?.value ?? 0, Colors.green),
        BasePieChartData("Số lượng",
            data.lostOpportunityCount?.value ?? 0, const Color(0xffff424f)),
        BasePieChartData("Hủy bỏ",
            data.openOpportunityCount?.value ?? 0, AppColors.mainColor),
      ],
    ).squareBox(edgeSize: height ?? context.height);
  }
}
