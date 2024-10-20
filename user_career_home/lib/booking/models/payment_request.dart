import 'package:user_career_core/user_career_core.dart';

class PaymentRequest implements Encodable{
  int? expertId;
  int? requestId;
  int? bookId;
  int? cost;
  String? methodPayment;

  PaymentRequest({
    this.expertId,
    this.requestId,
    this.bookId,
    this.cost,
    this.methodPayment
  });

  PaymentRequest copyWith({
    int? expertId,
    int? requestId,
    int? bookId,
    int? cost,
    String? methodPayment
  }) {
    return PaymentRequest(
      expertId: expertId ?? this.expertId,
      requestId: requestId ?? this.requestId,
      bookId: bookId ?? this.bookId,
      cost: cost ?? this.cost,
      methodPayment: methodPayment ?? this.methodPayment
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      "expert_id": expertId,
      "request_id": requestId,
      "book_id": bookId,
      "cost": cost,
      "method_payment": methodPayment
    };
  }
}