import 'package:user_career_core/user_career_core.dart';

class SkillResponse implements Decodable {
  int? skillId;
  int? userId;
  int? categoryId;
  String? nameSkill;
  int? experienceYear;
  String? skillDescription;
  String? nameCategory;
  int? timeOnline;
  int? priceOnline;
  int? timeOffline;
  int? priceOffline;

  SkillResponse({
    this.skillId,
    this.userId,
    this.categoryId,
    this.nameSkill,
    this.experienceYear,
    this.skillDescription,
    this.nameCategory,
    this.timeOnline,
    this.priceOnline,
    this.timeOffline,
    this.priceOffline,
  });

  @override
  void decode(json) {
    skillId = json['skill_id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    nameSkill = json['name_skill'];
    experienceYear = json['experience_year'];
    skillDescription = json['skill_description'];
    nameCategory = json['name_category'];
    timeOnline = json['time_online'];
    priceOnline = (json['price_online'] as num?)?.toInt();
    timeOffline = json['time_offline'];
    priceOffline = (json['price_offline'] as num?)?.toInt();
  }

  bool get isSkillOnlineAvailable => timeOnline != null && timeOnline! > 0 && priceOnline != null && priceOnline! > 0;

  bool get isSkillOfflineAvailable => timeOffline != null && timeOffline! > 0 && priceOffline != null && priceOffline! > 0;

  String get formattedOnlinePrice => priceOnline != null ? '\$${priceOnline!.toStringAsFixed(2)}' : 'N/A';

  String get formattedOfflinePrice => priceOffline != null ? '\$${priceOffline!.toStringAsFixed(2)}' : 'N/A';

  String? get takeSkillExperience => '$experienceYear years of experience in $nameSkill';
}
