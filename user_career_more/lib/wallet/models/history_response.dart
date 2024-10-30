import 'package:user_career_core/user_career_core.dart';

class HistoryResponse implements Decodable{
  int? transactionId;
  int? amount;
  String? type;
  DateTime? createdAt;
  String? content;
  bool? isAdd;

  HistoryResponse({
    this.transactionId,
    this.amount,
    this.type,
    this.createdAt,
    this.content,
    this.isAdd
  });

  HistoryResponse copyWith({
    int? transactionId,
    int? amount,
    String? type,
    DateTime? createdAt,
    String? content,
    bool? isAdd
  }) {
    return HistoryResponse(
        transactionId: transactionId ?? this.transactionId,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        content: content ?? this.content,
        isAdd: isAdd ?? this.isAdd
    );
  }

  @override
  void decode(dynamic data) {
    transactionId = data["transaction_id"];
    amount = data["amount"];
    type = data["type"];
    createdAt = DateTime.parse(data["created_at"]);
    content = data["content"];
    isAdd = data["is_add"] == 0 ? false : true;
  }
}

class WalletBalance implements Decodable{
  int? walletBalance;

  WalletBalance({this.walletBalance});

  WalletBalance copyWith({int? walletBalance}) {
    return WalletBalance(
      walletBalance: walletBalance ?? this.walletBalance
    );
  }

  @override
  void decode(dynamic data) {
    walletBalance = data["wallet_balance"];
  }
}