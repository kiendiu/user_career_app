import 'package:intl/intl.dart' as intl;
import 'package:user_career_core/user_career_core.dart';

enum ChartType {
  spline,
  column,
}

enum YAxisSide { left, right }

abstract class ChartData<X, Y> {
  final X x;
  final Y y;

  ChartData(this.x, this.y);
}

class YAxisConfig {
  final intl.NumberFormat numberFormat;
  final String labelFormat;
  final double? max;
  final double? min;
  final String? labelColorHexString;

  const YAxisConfig({
    required this.numberFormat,
    required this.labelFormat,
    this.max,
    this.min,
    this.labelColorHexString,
  });
}

class ChartDataGroups<X, Y, Data extends ChartData<X, Y>> {
  final List<(GroupConfig legendConfig, List<Data> data)> _groups;

  ChartDataGroups(this._groups);

  List<N> map<N>(
      N Function((GroupConfig legendConfig, List<Data> data) data) mapper) {
    return _groups.map(mapper).toList();
  }

  List<GroupConfig> get groupConfigs => _groups.map((e) => e.$1).toList();

  List<List<Data>> get allData => _groups.map((e) => e.$2).toList();

  bool any(
      bool Function((GroupConfig legendConfig, List<Data> data) data) test) {
    return _groups.any(test);
  }

  bool every(
      bool Function((GroupConfig legendConfig, List<Data> data) data) test) {
    return _groups.every(test);
  }

  int get maxLengthInGroup {
    return _groups.map((e) => e.$2.length).max;
  }

  bool get hasOneChartDataGroup => _groups.length == 1;

  bool get hasData => _groups.isNotEmpty;

  bool get hasRightYAxis =>
      _groups.any((element) => element.$1.sideForValueY == YAxisSide.right);
}

class GroupConfig {
  final String legendText;
  final String lineColorHexString;
  final ChartType chartType;
  final YAxisSide sideForValueY;

  GroupConfig(this.legendText, this.lineColorHexString, this.chartType,
      {this.sideForValueY = YAxisSide.left});
}

@Deprecated("Use DefaultChartData instead")
typedef DefaultSplineChartData = ChartData<String, double>;
@Deprecated("Use DefaultChartDataGroups instead")
typedef DefaultSplineChartDataGroups
= ChartDataGroups<String, double, DefaultSplineChartData>;

typedef DefaultChartData = ChartData<String, double>;
typedef DefaultChartDataGroups
= ChartDataGroups<String, double, DefaultChartData>;
