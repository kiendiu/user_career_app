import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/wallet/controllers/deposit_controller.dart';
import 'package:user_career_more/wallet/controllers/wallet_controller.dart';
import 'package:user_career_more/wallet/models/wallet_request.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

@RoutePage()
class DepositWalletPage extends ConsumerStatefulWidget {
  const DepositWalletPage({super.key});

  @override
  ConsumerState createState() => _DepositWalletPageState();
}

class _DepositWalletPageState extends ConsumerState<DepositWalletPage> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final depositState = ref.watch(depositControllerProvider);
    final depositController = ref.watch(depositControllerProvider.notifier);

    final walletBalanceState = ref.watch(walletBalanceControllerProvider);

    Future<void> onPayment() async{
      final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
        url: ' https://sandbox.vnpayment.vn/paymentv2/vpcpay.html',
        version: '2.0.1',
        tmnCode: 'ZOZZHIZ6',
        txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
        orderInfo: 'Nạp VND vào ví',
        amount: depositState.selectedAmount ?? 0.0,
        returnUrl: 'https://sandbox.vnpayment.vn/merchantv2/',
        ipAdress: '192.168.5.242',
        vnpayHashKey: 'Z9Z4GE83D2DO5P00PXXR2XJ2BJJBK4F8',
        vnPayHashType: VNPayHashType.HMACSHA512,
        vnpayExpireDate: DateTime.now().add(const Duration(hours: 1)),
      );
      await VNPAYFlutter.instance.show(
        paymentUrl: paymentUrl,
        onPaymentSuccess: (params) {
          depositController.updateResponseCode('Success');
          if(!depositState.isLoading){
            depositController.depositWallet(
              WalletRequest(
                amount: depositState.selectedAmount ?? 0.0,
                content: 'Nạp tiền vào ví',
              )
            ).then((result){
              if(result){
                depositController.updateSelectedAmount(0.0);
                depositController.updateIsLoading(true);
                ref.invalidate(walletBalanceControllerProvider);
                ref.invalidate(walletControllerProvider);
                context.showSuccess("Nạp tiền thành công");
              }else{
                context.showError("Nạp tiền thất bại");
              }
            });
          }
        },
        onPaymentError: (params) {
          depositController.updateResponseCode('Error');
        }
      );
    }

    return BaseScaffold(
      customAppBar: BaseAppBarView(
        title: 'Nạp tiền',
        onTapBackButton: () {
          context.router.popUntil((route) => route.settings.name != DepositWalletRoute.name);
        },
      ),
      backgroundColor: AppColors.white3Color,
      bottomView: Container(
        color: AppColors.white1Color,
        child: AppButton(
          title: "Thanh toán",
          onPressed: () {
            onPayment();
          },
        ).paddingSymmetric(horizontal: 16)
          .paddingOnly(top: 12, bottom: 40),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'Số dư trong ví',
              style: ref.theme.defaultTextStyle.copyWith(
                  fontWeight: FontWeight.bold
              ),
            ),
            trailing: walletBalanceState.maybeWhen(
              data: (data) => Text(
                "${NumberFormat("###,###", "vi_VN").format(data.walletBalance ?? 0)} đ",
                style: ref.theme.defaultTextStyle.copyWith(
                  color: AppColors.main1Color,
                ),
              ),
              orElse: () => const SizedBox(),
            ),
          ).makeColor(AppColors.white1Color),
          const Gap(5),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Số tiền cần nạp',
                  style: ref.theme.defaultTextStyle.copyWith(
                      fontWeight: FontWeight.bold
                  ),
                ).paddingOnly(bottom: 4),
                Wrap(
                  spacing: 12.0,
                  children: [50000, 100000, 200000, 500000, 1000000, 2000000].map((price) {
                    final amount = price.toDouble();

                    return ChoiceChip(
                      backgroundColor: depositState.selectedAmount == amount ? AppColors.mainColor : AppColors.white1Color,
                      selectedColor: AppColors.mainColor,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: depositState.selectedAmount == amount
                              ? AppColors.white1Color
                              : AppColors.black1Color
                      ),
                      label: Text('${NumberFormat('#,##0', 'vi_VN').format((amount))} đ'),
                      checkmarkColor: AppColors.white1Color,
                      selected: depositState.selectedAmount == amount,
                      onSelected: (selected) {
                        depositController.updateSelectedAmount(selected ? amount : 0);
                      },
                    );
                  }).toList(),
                ),
              ],
            ).paddingSymmetric(vertical: 12.0).paddingOnly(left: 12)
            .makeColor(AppColors.white1Color),
          ),
          const Gap(5),
          Row(
            children: [
              const ImageView(
                url: 'https://th.bing.com/th/id/OIP.pn3RUm1xk1HiAxWIgC6CIwAAAA?rs=1&pid=ImgDetMain',
                radius: 5.0,
              ).box(w: 50, h: 50).paddingSymmetric(horizontal: 12),
              Text(
                'Thanh toán bằng VNPAY',
                style: ref.theme.bigTextStyle.weight(FontWeight.bold)
              ),
            ]
          ).paddingSymmetric(vertical: 6.0).makeColor(AppColors.white1Color),
        ]
      )
    );
  }
}
