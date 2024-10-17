import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'categories_response.dart';

class Request implements Encodable{
  String? title;
  String? description;
  int? categoryId;
  String? contactMethod = "offline";
  DateTime? biddingEndDate;
  String? locationName;
  String? address;
  int? budget;
  List<BaseSelectableItemModel<CategoriesResponse>>? field = [];

  Request({
    this.title,
    this.description,
    this.categoryId,
    this.contactMethod,
    this.biddingEndDate,
    this.locationName,
    this.address,
    this.budget,
    this.field,
  });

  Request copyWith({
    String? title,
    String? description,
    int? categoryId,
    String? contactMethod,
    DateTime? biddingEndDate,
    String? locationName,
    String? address,
    int? budget,
    List<BaseSelectableItemModel<CategoriesResponse>>? field,
  }) {
    return Request(
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      contactMethod: contactMethod ?? this.contactMethod,
      biddingEndDate: biddingEndDate ?? this.biddingEndDate,
      locationName: locationName ?? this.locationName,
      address: address ?? this.address,
      budget: budget ?? this.budget,
      field: field ?? this.field,
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      'user_id': Storage.get(POSStorageKey.userId),
      'title': title,
      'description': description,
      'category_id': categoryId == 0 ? null : categoryId,
      'contact_method': contactMethod,
      'bidding_end_date': biddingEndDate?.toString(),
      'location_name': locationName,
      'address': address,
      'budget': budget,
    };
  }
}

enum ContactMethodEnum{
  offline,
  online;

  String get localizedValue => switch (this) {
    ContactMethodEnum.offline => "Trực tiếp",
    ContactMethodEnum.online => "Gọi điện",
  };

  String get rawValue => switch (this) {
    ContactMethodEnum.offline => "offline",
    ContactMethodEnum.online => "online",
  };
}