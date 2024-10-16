import 'package:user_career_core/user_career_core.dart';

import 'bid_model.dart';

class RequestModel implements Decodable{
  int? requestId;
  String? title;
  String? description;
  int? categoryId;
  String? nameCategory;
  String? contactMethod;
  DateTime? biddingEndDate;
  String? locationName;
  String? address;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? totalBids;
  int? budget;
  List<BidModel>? expectBids;

  RequestModel({
    this.requestId,
    this.title,
    this.description,
    this.categoryId,
    this.nameCategory,
    this.contactMethod,
    this.biddingEndDate,
    this.locationName,
    this.address,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.totalBids,
    this.budget,
    this.expectBids,
  });

  RequestModel copyWith({
    int? requestId,
    String? title,
    String? description,
    int? categoryId,
    String? nameCategory,
    String? contactMethod,
    DateTime? biddingEndDate,
    String? locationName,
    String? address,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalBids,
    int? budget,
    List<BidModel>? expectBids,
  }) {
    return RequestModel(
      requestId: requestId ?? this.requestId,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      nameCategory: nameCategory ?? this.nameCategory,
      contactMethod: contactMethod ?? this.contactMethod,
      biddingEndDate: biddingEndDate ?? this.biddingEndDate,
      locationName: locationName ?? this.locationName,
      address: address ?? this.address,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalBids: totalBids ?? this.totalBids,
      budget: budget ?? this.budget,
      expectBids: expectBids ?? this.expectBids,
    );
  }
  @override
  void decode(json) {
    requestId = json['request_id'];
    title = json['title'];
    description = json['description'];
    categoryId = json['category_id'];
    nameCategory = json['name_category'];
    contactMethod = json['contact_method'];
    biddingEndDate = json['bidding_end_date'] == null ? null : DateTime.parse(json['bidding_end_date']);
    locationName = json['location_name'];
    address = json['address'];
    status = json['status'];
    createdAt = json['created_at'] == null ? null : DateTime.parse(json['created_at']);
    updatedAt = json['updated_at'] == null ? null : DateTime.parse(json['updated_at']);
    totalBids = json['total_bids'];
    budget = json['budget'];
    expectBids = json['expert_bids'] == null
        ? null
        : (json['expert_bids'] as List)
        .map((e) => BidModel()..decode(e))
        .toList();
  }
}
