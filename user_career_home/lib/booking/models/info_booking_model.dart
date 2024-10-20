class InfoBookingModel {
  int? serviceId;
  int? expertId;
  int? requestId;
  String? contactMethod;
  int? price;
  int? time;

  InfoBookingModel({
    this.serviceId,
    this.expertId,
    this.requestId,
    this.contactMethod,
    this.price,
    this.time
  });

  InfoBookingModel copyWith({
    int? serviceId,
    int? expertId,
    int? requestId,
    String? contactMethod,
    int? price,
    int? time
  }) {
    return InfoBookingModel(
      serviceId: serviceId ?? this.serviceId,
      expertId: expertId ?? this.expertId,
      requestId: requestId ?? this.requestId,
      contactMethod: contactMethod ?? this.contactMethod,
      price: price ?? this.price,
      time: time ?? this.time
    );
  }
}