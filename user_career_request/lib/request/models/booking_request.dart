import 'package:user_career_core/user_career_core.dart';

class BookingRequest implements Encodable{
  int? bookId;
  int? requestId;
  int? expertId;
  DateTime? scheduleTime;
  int? duration;
  int? totalPrice;
  String? noteMessage;
  String? contactMethod;
  String? locationName;
  String? address;

  BookingRequest({
    this.bookId,
    this.requestId,
    this.expertId,
    this.scheduleTime,
    this.duration,
    this.totalPrice,
    this.noteMessage,
    this.contactMethod,
    this.locationName,
    this.address
  });

  BookingRequest copyWith({
    int? bookId,
    int? requestId,
    int? expertId,
    DateTime? scheduleTime,
    int? duration,
    int? totalPrice,
    String? noteMessage,
    String? contactMethod,
    String? locationName,
    String? address
  }) {
    return BookingRequest(
        requestId: requestId ?? this.requestId,
      expertId: expertId ?? this.expertId,
      scheduleTime: scheduleTime ?? this.scheduleTime,
      duration: duration ?? this.duration,
      totalPrice: totalPrice ?? this.totalPrice,
      noteMessage: noteMessage ?? this.noteMessage,
      contactMethod: contactMethod ?? this.contactMethod,
      locationName: locationName ?? this.locationName,
      address: address ?? this.address
    );
  }
  @override
  Map<String, dynamic> encode() {
    return {
      "request_id": requestId,
      "expert_id": expertId,
      "schedule_time": scheduleTime.toString(),
      "duration": duration,
      "total_price": totalPrice,
      "note_message": noteMessage,
      "contact_method": contactMethod,
      "location_name": locationName,
      "address": address
    };
  }

  bool get isEmptyMessage => noteMessage != null && noteMessage!.isNotEmpty;

  bool get isEmptyLocation => locationName != null && locationName!.isNotEmpty;

  bool get isEmptyAddress => address != null && address!.isNotEmpty;
}

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