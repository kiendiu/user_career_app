import 'package:user_career_core/user_career_core.dart';

class CalendarModel implements Decodable{
  int? bookId;
  int? serviceId;
  int? userId;
  int? expertId;
  DateTime? scheduleTime;
  int? duration;
  int? totalPrice;
  String? noteMessage;
  String? contactMethod;
  String? locationName;
  String? address;
  DateTime? createdAt;
  String? status;
  int? requestId;
  String? userName;
  String? expertName;
  String? serviceName;

  CalendarModel({
    this.bookId,
    this.serviceId,
    this.userId,
    this.expertId,
    this.scheduleTime,
    this.duration,
    this.totalPrice,
    this.noteMessage,
    this.contactMethod,
    this.locationName,
    this.address,
    this.createdAt,
    this.status,
    this.requestId,
    this.userName,
    this.expertName,
    this.serviceName
  });

  CalendarModel copyWith({
    int? bookId,
    int? serviceId,
    int? userId,
    int? expertId,
    DateTime? scheduleTime,
    int? duration,
    int? totalPrice,
    String? noteMessage,
    String? contactMethod,
    String? locationName,
    String? address,
    DateTime? createdAt,
    String? status,
    int? requestId,
    String? userName,
    String? expertName,
    String? serviceName
  }) => CalendarModel(
    bookId: bookId ?? this.bookId,
    serviceId: serviceId ?? this.serviceId,
    userId: userId ?? this.userId,
    expertId: expertId ?? this.expertId,
    scheduleTime: scheduleTime ?? this.scheduleTime,
    duration: duration ?? this.duration,
    totalPrice: totalPrice ?? this.totalPrice,
    noteMessage: noteMessage ?? this.noteMessage,
    contactMethod: contactMethod ?? this.contactMethod,
    locationName: locationName ?? this.locationName,
    address: address ?? this.address,
    createdAt: createdAt ?? this.createdAt,
    status: status ?? this.status,
    requestId: requestId ?? this.requestId,
    userName: userName ?? this.userName,
    expertName: expertName ?? this.expertName,
    serviceName: serviceName ?? this.serviceName
  );
  @override
  void decode(json) {
    bookId = json['book_id'];
    serviceId = json['service_id'];
    userId = json['user_id'];
    expertId = json['expert_id'];
    scheduleTime = DateTime.parse(json['schedule_time']);
    duration = json['duration'];
    totalPrice = (json['total_price']).toInt();
    noteMessage = json['note_message'];
    contactMethod = json['contact_method'];
    locationName = json['location_name'];
    address = json['address'];
    createdAt = DateTime.parse(json['created_at']);
    status = json['status'];
    requestId = json['request_id'];
    userName = json['user_name'];
    expertName = json['expert_name'];
    serviceName = json['service_name'];
  }
}