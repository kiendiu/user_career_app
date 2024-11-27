import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:user_career_auth/admin/pages/views/dash_board_views/chart_data.dart';
import 'package:user_career_core/user_career_core.dart';

/// Biểu đồ cột và đường
class CartesianChartView<D extends ChartData<String, double>,
M extends ChartDataGroups<String, double, D>>
    extends ConsumerStatefulWidget {
  final double height;
  final int maxXAxisLabels;
  final bool shouldGroupDuplicateXAxisValues;
  final YAxisConfig? leftYAxisConfig;
  final YAxisConfig? rightYAxisConfig;
  final M data;
  final Widget Function(TrackballGroupingModeInfo? info)? tooltipBuilder;

  CartesianChartView(
      {super.key,
        required this.data,
        required this.height,
        this.maxXAxisLabels = 12,
        this.leftYAxisConfig,
        this.rightYAxisConfig,
        this.shouldGroupDuplicateXAxisValues = true,
        this.tooltipBuilder}) {
    assert(data.hasData, "[data] must not be empty");
  }

  @override
  ConsumerState createState() => _CartesianChartViewState();
}

class _CartesianChartViewState<D extends ChartData<String, double>,
M extends ChartDataGroups<String, double, D>>
    extends ConsumerState<CartesianChartView<D, M>> {
  bool get isColumnChart =>
      widget.data.every((element) => element.$1.chartType == ChartType.column);

  bool get isSplineChart =>
      widget.data.every((element) => element.$1.chartType == ChartType.spline);

  bool get isColumnAndSplineChart =>
      widget.data.any((element) =>
      element.$1.chartType == ChartType.spline ||
          element.$1.chartType == ChartType.column) &&
          !isSplineChart &&
          !isColumnChart;

  bool get shouldShowLegend => !widget.data.hasOneChartDataGroup;

  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _updateTrackballBehavior();
  }

  @override
  void didUpdateWidget(covariant CartesianChartView<D, M> oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (kDebugMode) {
      _updateTrackballBehavior();
    }
  }

  void _updateTrackballBehavior() {
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipAlignment: ChartAlignment.near,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      lineDashArray: const [5, 5],
      lineColor: Colors.grey.shade500,
      builder: widget.tooltipBuilder == null
          ? null
          : (context, trackballDetails) {
        return widget.tooltipBuilder!(trackballDetails.groupingModeInfo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: widget.height),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 1, dashArray: [5, 5]),
          labelPosition: ChartDataLabelPosition.outside,
          labelRotation: 0,
          labelIntersectAction: AxisLabelIntersectAction.rotate45,
          maximumLabels: widget.maxXAxisLabels,
          labelPlacement: LabelPlacement.betweenTicks,
          autoScrollingMode: AutoScrollingMode.start,
          desiredIntervals: widget.data.maxLengthInGroup,
          interval: 1,
          maximumLabelWidth: 80,
          arrangeByIndex: !widget.shouldGroupDuplicateXAxisValues,
          labelAlignment: LabelAlignment.end,
        ),
        onMarkerRender: (markerArgs) {
          markerArgs.markerHeight = 10;
          markerArgs.markerWidth = 10;
          markerArgs.color = Colors.white;
        },
        trackballBehavior: _trackballBehavior,
        plotAreaBorderWidth: 0,
        plotAreaBackgroundColor: Colors.transparent,
        legend: Legend(
          isVisible: shouldShowLegend,
          position: LegendPosition.bottom,
          height: "15%",
          legendItemBuilder: (legendText, series, point, seriesIndex) {
            return createLegendItem(legendText, series?.color);
          },
        ),
        plotAreaBorderColor: Colors.transparent,
        borderColor: Colors.transparent,
        axes: [
          if (widget.data.hasRightYAxis)
            NumericAxis(
              axisLine: const AxisLine(width: 1, dashArray: [5, 5]),
              opposedPosition: true,
              majorGridLines: const MajorGridLines(width: 1, dashArray: [5, 5]),
              minorGridLines: const MinorGridLines(width: 1, dashArray: [5, 5]),
              labelFormat: widget.rightYAxisConfig?.labelFormat,
              numberFormat: widget.rightYAxisConfig?.numberFormat,
              name: YAxisSide.right.toString(),
              minimum: widget.rightYAxisConfig?.min,
              maximum: widget.rightYAxisConfig?.max,
              labelStyle: ref.theme
                  .smallTextStyle
                  .copyWith(
                  color: getColor(
                      widget.rightYAxisConfig?.labelColorHexString)),
            ),
        ],
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 1, dashArray: [5, 5]),
          minorGridLines: const MinorGridLines(width: 1, dashArray: [5, 5]),
          majorGridLines: const MajorGridLines(width: 1, dashArray: [5, 5]),
          labelFormat: widget.leftYAxisConfig?.labelFormat,
          numberFormat: widget.leftYAxisConfig?.numberFormat,
          name: YAxisSide.left.toString(),
          minimum: widget.leftYAxisConfig?.min,
          maximum: widget.leftYAxisConfig?.max,
          labelStyle: ref.theme.smallTextStyle.copyWith(
              color: getColor(widget.leftYAxisConfig?.labelColorHexString)),
        ),
        enableAxisAnimation: true,
        series: widget.data.map(
              (data) {
            var legendConfig = data.$1;
            var seriesData = data.$2;
            if (legendConfig.chartType == ChartType.spline) {
              return SplineSeries<D, String>(
                markerSettings: const MarkerSettings(
                    isVisible: true,
                    shape: DataMarkerType.circle,
                    color: Colors.white,
                    borderWidth: 1),
                width: 1,
                legendIconType: LegendIconType.horizontalLine,
                legendItemText: legendConfig.legendText,
                splineType: SplineType.cardinal,
                dataSource: seriesData,
                color: getColor(legendConfig.lineColorHexString),
                xValueMapper: (datum, index) {
                  return seriesData[index].x;
                },
                yValueMapper: (datum, index) {
                  return datum.y;
                },
                enableTooltip: true,
                yAxisName: legendConfig.sideForValueY.toString(),
              );
            }

            return ColumnSeries<D, String>(
              width: 1,
              legendIconType: LegendIconType.horizontalLine,
              legendItemText: legendConfig.legendText,
              dataSource: seriesData,
              spacing: 0.2,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: getColor(legendConfig.lineColorHexString),
              xValueMapper: (datum, index) {
                return seriesData[index].x;
              },
              yValueMapper: (datum, index) {
                return datum.y;
              },
              yAxisName: legendConfig.sideForValueY.toString(),
            );
          },
        ).toList(),
      ).paddingOnly(left: 12, right: 12, bottom: 0),
    );
  }

  Color? getColor(String? hexString) {
    if (hexString == null) {
      return null;
    }
    return Color(
        0xFF000000 + int.parse(hexString.removeCharacter("#"), radix: 16));
  }

  Widget createLegendItem(String legendText, Color? color) {
    if (isSplineChart) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 16,
                height: 1,
                color: color,
              ).center(),
              Container(
                width: 8,
                height: 8,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: CircleBorder(
                      side: BorderSide(
                          color: color ?? Colors.transparent, width: 1),
                    )),
              ).center(),
            ],
          ).box(h: 16, w: 16).paddingOnly(top: 2),
          const Gap(4),
          Text(
            legendText,
            style: ref.theme.smallTextStyle,
          ),
        ],
      );
    }

    if (isColumnChart) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 16,
            height: 16,
            color: color,
          ).center().paddingOnly(top: 2),
          const Gap(8),
          Text(
            legendText,
            style: ref.theme.smallTextStyle,
          ),
        ],
      );
    }

    if (isColumnAndSplineChart) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 6,
            height: 6,
            color: color,
          ).center().paddingOnly(top: 2),
          const Gap(8),
          Text(
            legendText,
            style: ref.theme.smallTextStyle,
          ),
        ],
      );
    }

    return const SizedBox();
  }
}

class BaseChartData extends ChartData<String, double> {
  BaseChartData(super.x, super.y);
}

extension TrackballGroupingModeInfoCopyWith on TrackballGroupingModeInfo {
  TrackballGroupingModeInfo copyWith({
    List<CartesianChartPoint>? points,
    List<int>? currentPointIndices,
    List<int>? visibleSeriesIndices,
    List<dynamic>? visibleSeriesList,
  }) {
    return TrackballGroupingModeInfo(
      points ?? this.points,
      currentPointIndices ?? this.currentPointIndices,
      visibleSeriesIndices ?? this.visibleSeriesIndices,
      visibleSeriesList ?? this.visibleSeriesList,
    );
  }
}
