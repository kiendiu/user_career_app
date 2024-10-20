class InfoServiceModel {
  int? serviceId;
  int? expertId;
  int? priceOnline;
  int? timeOnline;
  int? priceOffline;
  int? timeOffline;

  InfoServiceModel({
    this.serviceId,
    this.expertId,
    this.priceOnline,
    this.timeOnline,
    this.priceOffline,
    this.timeOffline,
  });

  InfoServiceModel copyWith({
    int? serviceId,
    int? expertId,
    int? priceOnline,
    int? timeOnline,
    int? priceOffline,
    int? timeOffline,
  }) {
    return InfoServiceModel(
      serviceId: serviceId ?? this.serviceId,
      expertId: expertId ?? this.expertId,
      priceOnline: priceOnline ?? this.priceOnline,
      timeOnline: timeOnline ?? this.timeOnline,
      priceOffline: priceOffline ?? this.priceOffline,
      timeOffline: timeOffline ?? this.timeOffline,
    );
  }
}