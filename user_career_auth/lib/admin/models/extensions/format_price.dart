import 'package:intl/intl.dart';
import 'package:user_career_core/user_career_core.dart';

extension FormatedPriceExts on double {
  String formatDecimalPrice() => format("###,###,###.## đ");

  String formatPrice() => format("###,###,### đ");

  String formatPercent() => '${round2()}%';
}

extension FormattedNumberExts on double {
  String formatNumber() => format('#,###,###,###');
}

extension FormattedCurrencyExts on NumberFormat {
  static NumberFormat formattedVietnamese() {
    return NumberFormat.currency(
      locale: "en_US",
      symbol: "đ",
      decimalDigits: 0,
      customPattern: "#,### \u00a4",
    );
  }

  String formatCurrency(num value) => formattedVietnamese().format(value);
}
