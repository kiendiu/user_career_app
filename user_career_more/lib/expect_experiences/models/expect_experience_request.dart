import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';

class ExpectExperienceRequest implements Encodable{
  int? userId;
  int? experienceId;
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
   this.experienceId,
  });
  @override
  Map<String, dynamic> encode() {
    return {
    "user_id": Storage.get(POSStorageKey.userId),
    "experience_id": experienceId,
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
    int? experienceId,
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
      experienceId: experienceId ?? this.experienceId,
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

  bool get isEmptyCompany => company != null && company!.isNotEmpty;

  bool get isEmptyCategory => categoryId != null && categoryId! > 0;

  bool get isEmptyPosition => position != null && position!.isNotEmpty;

  bool get isEmptyStartTime => startTime != null && startTime!.isNotEmpty;

  bool get isEmptyEndTime => endTime != null && endTime!.isNotEmpty;

  bool get isEmptyJobDescription => jobDescription != null && jobDescription!.isNotEmpty;

  bool get isValidateTimeRange => DateTime.parse(endTime!).isBefore(DateTime.parse(startTime!));

  bool get canAddExperience => isEmptyCompany
      && isEmptyCategory
      && isEmptyPosition
      && isEmptyStartTime
      && isEmptyEndTime
      && isEmptyJobDescription;
}