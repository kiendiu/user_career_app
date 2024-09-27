import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';

class ExpectExperienceRequest implements Encodable{
  int? userId;
  String? company;
  int? categoryId;
  String? nameCategory;
  String? startTime;
  String? endTime;
  bool? currentlyWorking;
  String? jobDescription;
  String? position;

  ExpectExperienceRequest({
   this.userId,
   this.company,
   this.categoryId,
   this.nameCategory,
   this.startTime,
   this.endTime,
   this.currentlyWorking,
   this.jobDescription,
   this.position,
  });

  @override
  Map<String, dynamic> encode() {
    return {
    "user_id": Storage.get(POSStorageKey.userId),
    "company": company,
    "category_id": categoryId,
    "start_time": startTime,
    "end_time": endTime,
    "currently_working": currentlyWorking,
    "job_description": jobDescription,
    "position": position,
    };
  }

  ExpectExperienceRequest copyWith({
    int? userId,
    String? company,
    int? categoryId,
    String? nameCategory,
    String? startTime,
    String? endTime,
    bool? currentlyWorking,
    String? jobDescription,
    String? position,
  }) {
    return ExpectExperienceRequest(
      userId: userId ?? this.userId,
      company: company ?? this.company,
      categoryId: categoryId ?? this.categoryId,
      nameCategory: nameCategory ?? this.nameCategory,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      currentlyWorking: currentlyWorking ?? this.currentlyWorking,
      jobDescription: jobDescription ?? this.jobDescription,
      position: position ?? this.position,
    );
  }

  bool get isCurrentlyWorking => currentlyWorking ?? false;

  bool get isEmptyCompany => company == null;

  bool get isEmptyCategory => categoryId == null;

  bool get isEmptyPosition => position == null;

  bool get isEmptyStartTime => startTime == null;

  bool get isEmptyEndTime => endTime == null;

  bool get canAddExperience => !isEmptyCompany
      && !isEmptyCategory
      && !isEmptyPosition
      && !isEmptyStartTime
      && !isEmptyEndTime;
}