import 'package:user_career_core/user_career_core.dart';

class WalletRequest implements Encodable {
  double? amount;
  String? content;

  WalletRequest({this.amount, this.content});

  WalletRequest copyWith({double? amount, String? content}) {
    return WalletRequest(
      amount: amount ?? this.amount,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      'amount': amount,
      'content': content,
    };
  }
}