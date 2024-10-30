import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/repository.dart';
import 'package:user_career_more/wallet/models/history_response.dart';
import 'package:user_career_more/wallet/models/wallet_request.dart';

abstract interface class IWalletRepository{
  ResultFuture<bool> depositWallet(WalletRequest request);

  ResultFuture<WalletBalance> getWalletBalance();

  ResultFuture<BaseListResponse<HistoryResponse>> getHistoryWallet(BaseParams params);

}

class WalletRepository extends MoreBaseRepository
    implements IWalletRepository{
  @override
  ResultFuture<bool> depositWallet(WalletRequest request) {
    return make.request(
      path: "/wallet/deposit",
      body: request.encode(),
      decoder: const EmptyResponse(),
    ).post().map(
      onValue: (value) {
        return true;
      },
    );
  }

  @override
  ResultFuture<BaseListResponse<HistoryResponse>> getHistoryWallet(BaseParams params) {
    return make.request(
      path: "/wallet/transaction-history",
      params: params,
      decoder: BaseListResponseModel.decodeBy(() => HistoryResponse()),
    ).get();
  }

  @override
  ResultFuture<WalletBalance> getWalletBalance() {
    return make.request(
      path: "/wallet/wallet-balance",
      decoder: WalletBalance(),
    ).get();
  }


}

final walletRepositoryProvider = Provider.autoDispose<IWalletRepository>((ref) {
  return WalletRepository();
});