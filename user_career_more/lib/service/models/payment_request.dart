import 'package:user_career_core/user_career_core.dart';

class PaymentRequest implements Encodable{
  int? expertId;
  int? bookId;
  int? cost;
  String? methodPayment;

  PaymentRequest({
    this.expertId,
    this.bookId,
    this.cost,
    this.methodPayment
  });

  PaymentRequest copyWith({
    int? expertId,
    int? bookId,
    int? cost,
    String? methodPayment
  }) {
    return PaymentRequest(
        expertId: expertId ?? this.expertId,
        bookId: bookId ?? this.bookId,
        cost: cost ?? this.cost,
        methodPayment: methodPayment ?? this.methodPayment
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      "expert_id": expertId,
      "book_id": bookId,
      "cost": cost,
      "method_payment": methodPayment
    };
  }
}