import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:user_career_auth/admin/pages/views/dash_board_views/cartesian_chart_view.dart';
import 'package:user_career_core/user_career_core.dart';

class PointData {
  final Color color;
  final String label;
  final intl.NumberFormat? numberFormat;
  final String? labelFormat;

  PointData(
      {required this.color,
        required this.label,
        this.numberFormat,
        this.labelFormat});
}

class TooltipView extends StatelessWidget with GlobalThemePlugin {
  final TrackballGroupingModeInfo _info;
  late final List<PointData> _pointsData;

  TooltipView(
      {super.key,
        required TrackballGroupingModeInfo info,
        required List<PointData> Function(TrackballGroupingModeInfo info)
        pointDataBuilder})
      : _info = info.copyWith(
    points: info.points.toList(),
    visibleSeriesList: info.visibleSeriesList.toList(),
    visibleSeriesIndices: info.visibleSeriesIndices.toList(),
    currentPointIndices: info.currentPointIndices.toList(),
  ) {
    _pointsData = pointDataBuilder(_info);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tooltipItems = _info.points.asMap().entries.map((e) {
      final int index = e.key;
      final pointInfo = e.value;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: 5.0.borderAll(),
              color: _pointsData[index].color,
            ),
            margin: const EdgeInsets.only(right: 8.0),
          ),
          Text(
            '${_pointsData[index].label}: ${_pointsData[index].numberFormat?.format(pointInfo.y) ?? (pointInfo.y)?.round()} ${_pointsData[index].labelFormat ?? ''}',
            style: conf
                .smallTextStyle
                .textColor(Colors.white),
          ).flexible(),
        ],
      );
    }).toList();

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(4)),
      child: IntrinsicWidth(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 250),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_info.points.firstOrNull?.x ?? "-"}',
                style: conf
                    .smallTextStyle
                    .textColor(Colors.white),
              ).center(),
              const Gap(4),
              const Divider(
                height: 1,
                color: Colors.white,
              ),
              const Gap(4),
              ...tooltipItems
            ],
          ),
        ),
      ),
    );
  }
}
