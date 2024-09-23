import 'package:user_career_core/user_career_core.dart';

class ExpectExperienceResponse implements Decodable{
  int? experienceId;
  int? userId;
  String? company;
  int? categoryId;
  DateTime? startTime;
  DateTime? endTime;
  int? currentlyWorking;
  String? jobDescription;
  String? position;
  String? nameCategory;

  ExpectExperienceResponse({
    this.experienceId,
    this.userId,
    this.company,
    this.categoryId,
    this.startTime,
    this.endTime,
    this.currentlyWorking,
    this.jobDescription,
    this.position,
    this.nameCategory
  });

  @override
  void decode(json) {
    experienceId = json['experience_id'];
    userId = json['user_id'];
    company = json['company'];
    categoryId = json['category_id'];
    startTime = json['start_time'] == null ? null : DateTime.parse(json['start_time']);
    endTime = json['end_time'] == null ? null : DateTime.parse(json['end_time']);
    currentlyWorking = json['currently_working'];
    jobDescription = json['job_description'];
    position = json['position'];
    nameCategory = json['name_category'];
  }

  bool get isWorkingInCompany => currentlyWorking == 1;

  String? get takeWorkingTime {
    final stringEndTime = isWorkingInCompany ? "Hiện nay" : '${endTime?.month}/${endTime?.year}';
    return '${startTime?.month}/${startTime?.year} - $stringEndTime';
  }
}