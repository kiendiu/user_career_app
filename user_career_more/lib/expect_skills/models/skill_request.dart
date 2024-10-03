import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';

class SkillRequest implements Encodable {
  int? skillId;
  int? userId;
  int? categoryId;
  String? nameCategory;
  String? nameSkill;
  int? experienceYear;
  String? skillDescription;
  int? timeOnline;
  double? priceOnline;
  int? timeOffline;
  double? priceOffline;

  SkillRequest({
    this.skillId,
    this.userId,
    this.categoryId,
    this.nameCategory,
    this.nameSkill,
    this.experienceYear,
    this.skillDescription,
    this.timeOnline,
    this.priceOnline,
    this.timeOffline,
    this.priceOffline,
  });

  @override
  Map<String, dynamic> encode() {
    return {
      "skill_id": skillId,
      "user_id": Storage.get(POSStorageKey.userId),
      "category_id": categoryId,
      "name_skill": nameSkill,
      "experience_year": experienceYear,
      "skill_description": skillDescription,
      "time_online": timeOnline,
      "price_online": priceOnline,
      "time_offline": timeOffline,
      "price_offline": priceOffline,
    };
  }

  SkillRequest copyWith({
    int? skillId,
    int? userId,
    int? categoryId,
    String? nameCategory,
    String? nameSkill,
    int? experienceYear,
    String? skillDescription,
    int? timeOnline,
    double? priceOnline,
    int? timeOffline,
    double? priceOffline,
  }) {
    return SkillRequest(
      skillId: skillId ?? this.skillId,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      nameCategory: nameCategory ?? this.nameCategory,
      nameSkill: nameSkill ?? this.nameSkill,
      experienceYear: experienceYear ?? this.experienceYear,
      skillDescription: skillDescription ?? this.skillDescription,
      timeOnline: timeOnline ?? this.timeOnline,
      priceOnline: priceOnline ?? this.priceOnline,
      timeOffline: timeOffline ?? this.timeOffline,
      priceOffline: priceOffline ?? this.priceOffline,
    );
  }

  bool get isEmptyNameSkill => nameSkill != null && nameSkill!.isNotEmpty;

  bool get isEmptyCategory => categoryId != null && categoryId! > 0;

  bool get isEmptyExperienceYear => experienceYear != null && experienceYear! > 0;

  bool get isEmptySkillDescription => skillDescription != null && skillDescription!.isNotEmpty;

  bool get isEmptyTimeOnline => timeOnline != null && timeOnline! > 0;

  bool get isEmptyPriceOnline => priceOnline != null && priceOnline! > 0;

  bool get isEmptyTimeOffline => timeOffline != null && timeOffline! > 0;

  bool get isEmptyPriceOffline => priceOffline != null && priceOffline! > 0;

  bool get canAddSkill => isEmptyNameSkill
      && isEmptyCategory
      && isEmptyExperienceYear
      && isEmptySkillDescription
      && isEmptyTimeOnline
      && isEmptyPriceOnline
      && isEmptyTimeOffline
      && isEmptyPriceOffline;
}
