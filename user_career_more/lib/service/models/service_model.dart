import 'package:user_career_core/user_career_core.dart';

class ListServiceData<ServiceModel> extends BaseListResponse<ServiceModel> {
  ServiceMetadata? serviceMetadata;
}

class ServiceData<ServiceModel extends Decodable>
    extends ListServiceData<ServiceModel> implements Decodable{
  late ServiceModel Function() itemHandler;
  late ServiceModel decoder;

  ServiceData.decodeBy(this.itemHandler);

  @override
  void decode(json) {
    if(json == null) return;
    if(json['data'] != null) {
      items.addAll(
        (json['data'] as List).map((e) => itemHandler()..decode(e)).toList()
      );
    }
    if(json['metadata'] != null){
      metadata = PosMetadata()..decode(json['metadata']);
      serviceMetadata = ServiceMetadata()..decode(json['metadata']);
    }
  }


}

class ServiceMetadata extends Metadata{
  int? totalPending;
  int? totalConfirmed;
  int? totalInProgress;
  int? totalCompleted;

  @override
  void decode(json){
    super.decode(json);
    totalPending = json['total_pending'];
    totalConfirmed = json['total_confirmed'];
    totalInProgress = json['total_in_progress'];
    totalCompleted = json['total_completed'];
  }

  bool get checkServiceStatusPending => (totalPending ?? 0) > 0;

  bool get checkServiceStatusConfirmed => (totalConfirmed ?? 0) > 0;

  bool get checkServiceStatusInProgress => (totalInProgress ?? 0) > 0;

  bool get checkServiceStatusCompleted => (totalCompleted ?? 0) > 0;
}

class ServiceModel implements Decodable{
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
  bool? isPaid;

  ServiceModel({
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
    this.serviceName,
    this.isPaid
  });

  ServiceModel copyWith({
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
    String? serviceName,
    bool? isPaid
  }) {
    return ServiceModel(
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
      serviceName: serviceName ?? this.serviceName,
      isPaid: isPaid ?? this.isPaid
    );
  }

  @override
  void decode(json) {
    bookId = json['book_id'];
    serviceId = json['service_id'];
    userId = json['user_id'];
    expertId = json['expert_id'];
    scheduleTime = DateTime.parse(json['schedule_time']);
    duration = json['duration'];
    totalPrice = json['total_price'];
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
    isPaid = json['is_paid'] == 0 ? false : true;
  }
}
