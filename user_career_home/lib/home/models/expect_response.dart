import 'package:user_career_core/user_career_core.dart';
import 'package:intl/intl.dart';

class ExpectResponse implements Decodable{
  int? expectId;
  String? expectName;
  String? expectAvatar;
  String? skillName;
  String? nameCategory;
  int? priceOnline;
  int? priceOffline;
  int? timeOnline;
  int? timeOffline;
  int? averageRating;

  ExpectResponse({
    this.expectId,
    this.expectName,
    this.expectAvatar,
    this.skillName,
    this.nameCategory,
    this.priceOnline,
    this.priceOffline,
    this.timeOnline,
    this.timeOffline,
    this.averageRating,
  });

  ExpectResponse copyWith({
    int? expectId,
    String? expectName,
    String? expectAvatar,
    String? skillName,
    String? nameCategory,
    int? priceOnline,
    int? priceOffline,
    int? timeOnline,
    int? timeOffline,
    int? averageRating,
  }) => ExpectResponse(
    expectId: expectId ?? this.expectId,
    expectName: expectName ?? this.expectName,
    expectAvatar: expectAvatar ?? this.expectAvatar,
    skillName: skillName ?? this.skillName,
    nameCategory: nameCategory ?? this.nameCategory,
    priceOnline: priceOnline ?? this.priceOnline,
    priceOffline: priceOffline ?? this.priceOffline,
    timeOnline: timeOnline ?? this.timeOnline,
    timeOffline: timeOffline ?? this.timeOffline,
    averageRating: averageRating ?? this.averageRating,
  );

  String formatCurrency(int? amount) {
    final formatter = NumberFormat('#,##0', 'vi_VN');
    return '${formatter.format(amount)}đ';
  }

  String get priceOnlineString => formatCurrency(priceOnline);
  String get priceOfflineString => formatCurrency(priceOffline);

  @override
  void decode(json) {
    expectId = json['user_id'];
    expectName = json['username'];
    expectAvatar = json['avatar'];
    skillName = json['skill_name'];
    nameCategory = json['name_category'];
    priceOnline = json['price_online'];
    priceOffline = json['price_offline'];
    timeOnline = json['time_online'];
    timeOffline = json['time_offline'];
    averageRating = json['average_rating'];
  }
}