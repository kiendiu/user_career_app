import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/wallet/models/balance_fluctuation_enum.dart';
import 'package:user_career_more/wallet/models/history_response.dart';
import 'package:user_career_more/wallet/models/wallet_params.dart';
import 'package:user_career_more/wallet/repositories/wallet_repository.dart';

class WalletController extends AutoDisposeNotifier<WalletControllerState>
    with AlertMixin, MetadataUpdater {
  @override
  WalletControllerState build() {
    return WalletControllerState(type: BalanceFluctuationEnum.all);
  }

  Future<List<HistoryResponse>> getHistory(int page) async {
    try {
      final result = await ref
          .read(walletRepositoryProvider)
          .getHistoryWallet(WalletParams(
            page: page + 1,
            type: state.type.rawValue,
          ))
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result;
    } catch (e) {
      return [];
    }
  }

  void setBalanceFluctuationType(BalanceFluctuationEnum type) {
    state = state.copyWith(type: type);
  }
}

final walletControllerProvider =
    NotifierProvider.autoDispose<WalletController, WalletControllerState>(
        () => WalletController());

class WalletBalanceController extends AutoDisposeAsyncNotifier<WalletBalance>
    with AlertMixin, MetadataUpdater {
  @override
  FutureOr<WalletBalance> build() {
    return getWalletBalance();
  }

  Future<WalletBalance> getWalletBalance() async {
    final result = await ref
        .read(walletRepositoryProvider)
        .getWalletBalance()
        .showErrorBy(this)
        .mapToValueOr(defaultValue: WalletBalance())
        .asFuture();
    return result;
  }
}

final walletBalanceControllerProvider = AsyncNotifierProvider.autoDispose<WalletBalanceController, WalletBalance>(
    () => WalletBalanceController());

class WalletControllerState {
  BalanceFluctuationEnum type;

  WalletControllerState({
    required this.type,
  });

  WalletControllerState copyWith({required BalanceFluctuationEnum type}) {
    return WalletControllerState(type: type);
  }
}
