import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/service/models/cancel_request.dart';
import 'package:user_career_more/service/repositories/service_repository.dart';

class CancelController extends AutoDisposeNotifier<CancelControllerState>
    with AlertMixin, MetadataUpdater{
  @override
  CancelControllerState build() {
    return CancelControllerState();
  }

  Future<bool> cancelService(int bookId) async {
    try {
      final result = await ref
          .read(serviceRepositoryProvider)
          .cancelService(bookId, state.cancelRequest ?? CancelRequest(cancelReason: state.selectedState))
          .showErrorBy(this)
          .map(onValue: (value) => value ?? false)
          .mapToValueOr(defaultValue: false).asFuture();
      return result;
    } catch (e) {
      return false;
    }
  }

  void updateSelectedState(String reason) {
    state = state.copyWith(selectedState: reason);
  }

  void updateCancelRequest(CancelRequest cancelRequest) {
    state = state.copyWith(cancelRequest: cancelRequest);
  }
}

final cancelControllerProvider = NotifierProvider.autoDispose<CancelController, CancelControllerState>(() {
  return CancelController();
});

class CancelControllerState{
  String? selectedState;
  CancelRequest? cancelRequest;

  CancelControllerState({this.selectedState, this.cancelRequest});

  CancelControllerState copyWith({
    String? selectedState,
    CancelRequest? cancelRequest,
  }) {
    return CancelControllerState(
      selectedState: selectedState ?? this.selectedState,
      cancelRequest: cancelRequest ?? this.cancelRequest,
    );
  }
}