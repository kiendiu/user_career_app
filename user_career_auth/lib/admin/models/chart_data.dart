import 'dart:ui';
import 'package:intl/intl.dart' as intl;
import 'package:user_career_auth/admin/models/statistical_data.dart';
import 'package:user_career_core/user_career_core.dart';

class ChartData extends StatisticalData {
  final DateTime? fromDate;
  final DateTime? toDate;

  ChartData({this.fromDate, this.toDate, super.value, super.specificValue});

  String get chartTimeLabel {
    final from = DateTimeUtils.stringFormatted(
        time: fromDate, pattern: DateTimeFormatPattern.MMyyyy);
    final fromMonth = intl.DateFormat('MM').format(fromDate ?? DateTime.now());
    final fromDay = intl.DateFormat('dd').format(fromDate ?? DateTime.now());
    final to = DateTimeUtils.stringFormatted(
        time: toDate, pattern: DateTimeFormatPattern.MMyyyy);
    final toDateStringFormatted = DateTimeUtils.stringFormatted(
        time: toDate, pattern: DateTimeFormatPattern.ddMMyyyy2);
    final toYear = intl.DateFormat('yyyy').format(toDate ?? DateTime.now());
    if (fromDate != null &&
        toDate != null &&
        fromDate?.day != toDate?.day &&
        (toDate!.day - fromDate!.day).abs() == 6) {
      return "$fromDay - $toDateStringFormatted";
    }
    if (fromDate != null &&
        toDate != null &&
        (toDate!.month - fromDate!.month) == 11) {
      return toYear;
    }
    if (from != to) {
      return "$fromMonth - $to";
    }
    return "$from";
  }

  String get formattedIntegerChartValue => "${value?.round() ?? "-"}";

  String get formattedMoneyValue =>
      "${value?.formatCurrency(symbol: "", locale: const Locale("en", "EN")) ?? "-"} đ";
}

class SaleChartData {
  final ChartData? orderCount;
  final ChartData? contract;
  final ChartData? quoteOrderCount;

  SaleChartData({this.orderCount, this.contract, this.quoteOrderCount});
}

class OpportunityChartData {
  final ChartData? winOpportunityCount;
  final ChartData? openOpportunityCount;
  final ChartData? lostOpportunityCount;

  OpportunityChartData(
      {this.winOpportunityCount,
        this.openOpportunityCount,
        this.lostOpportunityCount});

  String get totalOpportunityCount =>
      "${((winOpportunityCount?.value ?? 0) + (openOpportunityCount?.value ?? 0) + (lostOpportunityCount?.value ?? 0)).round()}";

  bool get isChartEmpty => totalOpportunityCount == "0";
}

class OrderChartData {
  final ChartData? orderCount;
  final ChartData? orderValue;

  OrderChartData({this.orderCount, this.orderValue});
}
