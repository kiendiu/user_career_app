import 'package:user_career_core/user_career_core.dart';

class BookingRequest implements Encodable{
  int? bookId;
  int? serviceId;
  int? expertId;
  DateTime? scheduleTime;
  int? duration;
  double? totalPrice;
  String? noteMessage;
  String? contactMethod;
  String? locationName;
  String? address;

  BookingRequest({
    this.bookId,
    this.serviceId,
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
    int? serviceId,
    int? expertId,
    DateTime? scheduleTime,
    int? duration,
    double? totalPrice,
    String? noteMessage,
    String? contactMethod,
    String? locationName,
    String? address
  }) {
    return BookingRequest(
      serviceId: serviceId ?? this.serviceId,
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
      "service_id": serviceId,
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