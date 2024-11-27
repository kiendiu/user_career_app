import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:user_career_core/user_career_core.dart';

class BasePieChart extends ConsumerStatefulWidget {
  final List<BasePieChartData> chartData;

  const BasePieChart({
    super.key,
    required this.chartData
  });

  @override
  ConsumerState createState() => _BasePieChartState();
}

class _BasePieChartState extends ConsumerState<BasePieChart> {
  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
        legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.wrap,
            legendItemBuilder: (name, _, __, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: widget.chartData[index].color,
                    ),
                  ),
                  const Gap(4),
                  Text(name, style: ref.theme.smallTextStyle.textColor(AppColors.black1Color), textAlign: TextAlign.center).flexible(),
                ],
              );
            }
        ),
        tooltipBehavior: TooltipBehavior(
            enable: true,
            builder: (data, point, series, pointIndex, seriesIndex) {
              return Text(
                '${data.label} : ${(data.value / _totalAmount * 100).toStringAsFixed(2)}%',
                style: ref.theme.smallTextStyle.textColor(Colors.white),
              ).paddingAll(5);
            }
        ),
        series: <CircularSeries>[
          // Render pie chart
          PieSeries<BasePieChartData, String>(
              dataSource: widget.chartData,
              pointColorMapper:(BasePieChartData data,  _) => data.color,
              xValueMapper: (BasePieChartData data, _) => data.label,
              yValueMapper: (BasePieChartData data, _) => data.value,
              dataLabelMapper: (BasePieChartData data, _) => '${(data.value / _totalAmount * 100).toStringAsFixed(2)}%',
              // explode: true,
              // explodeOffset: '5%',
              radius: '80%',
              enableTooltip: true,
              dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  useSeriesColor: true,
                  textStyle: ref.theme.smallTextStyle.textColor(Colors.white),
                  overflowMode: OverflowMode.none,
                  labelPosition: ChartDataLabelPosition.outside
                // overflowMode: OverflowMode.shift
              )),
        ]
    );
  }

  double get _totalAmount {
    final result = widget.chartData.map((element) => element.value).reduce((value, element) => value + element);

    return result == 0 ? 1 : result;
  }
}

class BasePieChartData {
  BasePieChartData(this.label, this.value, [this.color]);
  final String label;
  final double value;
  final Color? color;
}
