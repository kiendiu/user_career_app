import 'package:user_career_core/user_career_core.dart';

import 'enums/bid_status_enum.dart';

class BidModel implements Decodable{
  int? bidId;
  int? expertId;
  int? requestId;
  int? price;
  String? description;
  String? changeReason;
  DateTime? createdAt;
  BidStatusEnum? status;
  String? requestTitle;
  int? categoryId;
  String? nameCategory;

  BidModel({
    this.bidId,
    this.expertId,
    this.requestId,
    this.price,
    this.description,
    this.changeReason,
    this.createdAt,
    this.status,
    this.requestTitle,
    this.categoryId,
    this.nameCategory,
  });

  BidModel copyWith({
    int? bidId,
    int? expertId,
    int? requestId,
    int? price,
    String? description,
    String? changeReason,
    DateTime? createdAt,
    BidStatusEnum? status,
    String? requestTitle,
    int? categoryId,
    String? nameCategory,
  }) {
    return BidModel(
      bidId: bidId ?? this.bidId,
      expertId: expertId ?? this.expertId,
      requestId: requestId ?? this.requestId,
      price: price ?? this.price,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      requestTitle: requestTitle ?? this.requestTitle,
      categoryId: categoryId ?? this.categoryId,
      nameCategory: nameCategory ?? this.nameCategory,
    );
  }
  @override
  void decode(json) {
    bidId = json['bid_id'];
    expertId = json['expert_id'];
    requestId = json['request_id'];
    price = json['price'];
    description = json['description'];
    changeReason = json['change_reason'];
    createdAt = DateTime.parse(json['created_at']);
    status = BidStatusEnum.values.firstWhere((element) => element.rawValue == json['status']);
    requestTitle = json['request_title'];
    categoryId = json['category_id'];
    nameCategory = json['name_category'];
  }
}