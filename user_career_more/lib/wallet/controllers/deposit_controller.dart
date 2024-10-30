import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/wallet/models/wallet_request.dart';
import 'package:user_career_more/wallet/repositories/wallet_repository.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

class DepositController extends Notifier<DepositState>
    with AlertMixin, MetadataUpdater {
  @override
  DepositState build() {
    return DepositState(isLoading: false);
  }

  Future<void> onPayment() async{
    final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      url: ' https://sandbox.vnpayment.vn/paymentv2/vpcpay.html',
      version: '2.0.1',
      tmnCode: 'ZOZZHIZ6',
      txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
      orderInfo: 'Nạp vào ví',
      amount: state.selectedAmount ?? 0.0,
      returnUrl: 'https://sandbox.vnpayment.vn/merchantv2/',
      ipAdress: '192.168.5.242',
      vnpayHashKey: 'Z9Z4GE83D2DO5P00PXXR2XJ2BJJBK4F8',
      vnPayHashType: VNPayHashType.HMACSHA512,
      vnpayExpireDate: DateTime.now().add(const Duration(hours: 1)),
    );
    await VNPAYFlutter.instance.show(
        paymentUrl: paymentUrl,
        onPaymentSuccess: (params) {
          updateResponseCode('Success');
          state = state.copyWith(isLoading: true);
        },
        onPaymentError: (params) {
          updateResponseCode('Error');
          state = state.copyWith(isLoading: false);
        }
    );
  }

  Future<bool> depositWallet(WalletRequest request) async {
    try {
      final result = await ref
          .read(walletRepositoryProvider)
          .depositWallet(request)
          .showErrorBy(this)
          .map(onValue: (value) => value ?? false)
          .mapToValueOr(defaultValue: false).asFuture();
      return result;
    } catch (e) {
      return false;
    }
  }

  void updateSelectedAmount(double amount){
    state = state.copyWith(selectedAmount: amount);
  }

  void updateResponseCode(String code){
    state = state.copyWith(responseCode: code);
  }

  void updateIsLoading(bool isLoading){
    state = state.copyWith(isLoading: isLoading);
  }
}

final depositControllerProvider = NotifierProvider<DepositController, DepositState>(() => DepositController());

class DepositState {
  bool isLoading;
  double? selectedAmount;
  String? responseCode;

  DepositState({
    required this.isLoading,
    this.selectedAmount = 0,
    this.responseCode,
  });

  DepositState copyWith({
    bool? isLoading,
    double? selectedAmount,
    String? responseCode,
  }) {
    return DepositState(
      isLoading: isLoading ?? this.isLoading,
      selectedAmount: selectedAmount ?? this.selectedAmount,
      responseCode: responseCode ?? this.responseCode,
    );
  }
}
