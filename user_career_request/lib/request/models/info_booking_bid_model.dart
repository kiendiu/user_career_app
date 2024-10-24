class InfoBookingBidModel{
  int? expertId;
  int? requestId;
  String? contactMethod;
  String? locationName;
  String? address;
  int? price;
  String? description;

  InfoBookingBidModel({
    this.expertId,
    this.requestId,
    this.contactMethod,
    this.locationName,
    this.address,
    this.price,
    this.description,
  });

  InfoBookingBidModel copyWith({
    int? expertId,
    int? requestId,
    String? contactMethod,
    String? locationName,
    String? address,
    int? price,
    String? description,
  }){
    return InfoBookingBidModel(
      expertId: expertId ?? this.expertId,
      requestId: requestId ?? this.requestId,
      contactMethod: contactMethod ?? this.contactMethod,
      locationName: locationName ?? this.locationName,
      address: address ?? this.address,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }
}