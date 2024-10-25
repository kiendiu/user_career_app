import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/more/models/total_response.dart';
import 'package:user_career_more/more/repositories/more_repository.dart';

class TotalController
    extends AutoDisposeAsyncNotifier<TotalResponse>
    with AlertMixin, MetadataUpdater {
  @override
  FutureOr<TotalResponse> build() async {
    var qtyNotifications = await _getTotal();
    return qtyNotifications;
  }

  Future<TotalResponse> _getTotal() async {
    try {
      final result = await ref
          .read(moreRepositoryProvider)
          .getTotal()
          .showErrorBy(this)
          .mapToValueOr(defaultValue: TotalResponse())
          .asFuture();
      ref.read(commonQtyControllerProvider.notifier)
          .updateQty("pending", result.totalPending);
      ref.read(commonQtyControllerProvider.notifier)
          .updateQty("confirmed", result.totalConfirmed);
      ref.read(commonQtyControllerProvider.notifier)
          .updateQty("in_progress", result.totalInProgress);
      ref.read(commonQtyControllerProvider.notifier)
          .updateQty("completed", result.totalCompleted);
      return result;
    } catch (e) {
      return TotalResponse();
    }
  }
}

final totalControllerProvider = AsyncNotifierProvider.autoDispose<
    TotalController, TotalResponse>(
      () => TotalController(),
);
