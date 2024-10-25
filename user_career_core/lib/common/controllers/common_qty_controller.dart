import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommonQtyController extends StateNotifier<Map<String, int>> {
  CommonQtyController() : super({
    'pending': 0,
    'confirmed': 0,
    'in_progress': 0,
    'completed': 0,
  });

  void updateQty(String status, int? quantity) {
    state = {
      ...state,
      status: quantity ?? 0,
    };
  }

  String getQty(String status) {
    final qty = state[status] ?? 0;
    if (qty == 0) return "0";
    if (qty > 99) return "99+";
    return qty.toString();
  }

  bool checkQty(String status) => (state[status] ?? 0) > 0;
}

final commonQtyControllerProvider =
StateNotifierProvider.autoDispose<CommonQtyController, Map<String, int>>(
      (ref) => CommonQtyController(),
);
