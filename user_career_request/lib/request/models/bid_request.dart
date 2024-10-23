import 'package:user_career_core/user_career_core.dart';

class BidRequest implements Encodable{
  int? requestId;
  int? price;
  String? description;
  String? changeReason;

  BidRequest({this.requestId, this.price, this.description, this.changeReason});

  BidRequest copyWith({int? requestId, int? price, String? description, String? changeReason}) {
    return BidRequest(
      requestId: requestId ?? this.requestId,
      price: price ?? this.price,
      description: description ?? this.description,
      changeReason: changeReason ?? this.changeReason,
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      "request_id": requestId,
      "price": price,
      "description": description,
      "change_reason": changeReason,
    };
  }

  bool get isEmptyPrice => price != null && price! >= 10000;

  bool get isEmptyDescription => description != null && description!.isNotEmpty;

  bool get isEmptyChangeReason => changeReason != null && changeReason!.isNotEmpty;
}