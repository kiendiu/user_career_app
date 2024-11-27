
import 'package:user_career_core/user_career_core.dart';

import 'chart_data.dart';
import 'entity_decoder.dart';

class ChartDataModel extends ChartData {
  ChartDataModel.fromJson(dynamic json)
      : super(
    fromDate:
    DateTimeMiliseconds.decodeMillisecondsFrom(json?['fromDate']),
    toDate: DateTimeMiliseconds.decodeMillisecondsFrom(json?['toDate']),
    value: DoubleConverter(json?['value']).convert(),
    specificValue: json?['specificValue'],
  );
}

class SaleChartDataModel extends SaleChartData {
  SaleChartDataModel.fromJson(dynamic json)
      : super(
    orderCount:
    EntityDecoder.decodeBy(json?['BOOKING_COUNT'], ChartDataModel.fromJson),
    contract:
    EntityDecoder.decodeBy(json?['REVENUE'], ChartDataModel.fromJson),
    quoteOrderCount: EntityDecoder.decodeBy(
        json?['EXPERT'], ChartDataModel.fromJson),
  );
}

class OpportunityChartDataModel extends OpportunityChartData {
  OpportunityChartDataModel.fromJson(dynamic json)
      : super(
    winOpportunityCount: EntityDecoder.decodeBy(
        json?['COMPLETED_BOOKING_COUNT'], ChartDataModel.fromJson),
    openOpportunityCount: EntityDecoder.decodeBy(
        json?['DOING_BOOKING_COUNT'], ChartDataModel.fromJson),
    lostOpportunityCount: EntityDecoder.decodeBy(
        json?['CANCEL_BOOKING_COUNT'], ChartDataModel.fromJson),
  );
}

// class OrderChartDataModel extends OrderChartData {
//   OrderChartDataModel.fromJson(dynamic json)
//       : super(
//     orderCount:
//     EntityDecoder.decodeBy(json?['ORDER_COUNT'], ChartDataModel.fromJson),
//     orderValue:
//     EntityDecoder.decodeBy(json?['ORDER_VALUE'], ChartDataModel.fromJson),
//   );
// }