import 'package:user_career_auth/admin/models/extensions/format_price.dart';

class StatisticalData {
  final double? value;
  final String? specificValue;

  StatisticalData({
    this.value,
    this.specificValue
  });

  String get formattedValue => value?.formatNumber() ?? '-';
}