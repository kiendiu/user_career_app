import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/chart_data.dart';
import 'package:user_career_auth/admin/repositories/admin_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class OpportunityChartController
    extends AutoDisposeAsyncNotifier<OpportunityChartData>  with AlertMixin{
  @override
  Future<OpportunityChartData> build() async {
    final result = await call();
    return result;
  }

  Future<OpportunityChartData> call() {
    final result = ref.read(adminRepositoryProvider)
        .getOpportunityChartData()
        .showErrorBy(this)
        .mapToValueOr(defaultValue: OpportunityChartData())
        .asFuture();

    return result;
  }
}

final opportunityChartControllerProvider = AsyncNotifierProvider.autoDispose<
    OpportunityChartController,
    OpportunityChartData>(() => OpportunityChartController());
