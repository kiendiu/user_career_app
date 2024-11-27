import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/chart_data.dart';
import 'package:user_career_auth/admin/pages/views/dash_board_views/dash_board_tab.dart';
import 'package:user_career_auth/admin/repositories/admin_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class SaleChartController extends AutoDisposeAsyncNotifier<SaleChartState> with AlertMixin{
  @override
  Future<SaleChartState> build() async {
    final result = await getSaleChart();
    final orders = result
        .map((e) => SampleData(
        e.orderCount?.chartTimeLabel ?? '-', e.orderCount?.value ?? 0))
        .toList();
    final contracts = result
        .map((e) => SampleData(
        e.contract?.chartTimeLabel ?? '-', e.contract?.value ?? 0))
        .toList();
    final quotes = result
        .map((e) => SampleData(e.quoteOrderCount?.chartTimeLabel ?? '-',
        e.quoteOrderCount?.value ?? 0))
        .toList();
    return SaleChartState(orders: orders, contracts: contracts, quotes: quotes);
  }

  Future<List<SaleChartData>> getSaleChart() {
    final result = call();
    return result;
  }

  Future<List<SaleChartData>> call() {
    final result = ref.read(adminRepositoryProvider)
        .getSaleChartData()
        .showErrorBy(this)
        .getItems();

    return result;
  }


}

final saleChartControllerProvider =
AsyncNotifierProvider.autoDispose<SaleChartController, SaleChartState>(
        () => SaleChartController());

class SaleChartState {
  final List<SampleData> orders;
  final List<SampleData> contracts;
  final List<SampleData> quotes;

  SaleChartState(
      {required this.orders, required this.contracts, required this.quotes});

  bool get isChartEmpty =>
      (orders.isNull && contracts.isNull && quotes.isNull) ||
          (orders.isEmpty && contracts.isEmpty && quotes.isEmpty);
}
