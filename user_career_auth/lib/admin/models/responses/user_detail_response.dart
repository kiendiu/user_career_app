import 'package:intl/intl.dart';
import 'package:user_career_core/user_career_core.dart';

class UserDetailResponse implements Decodable {
  int? userId;
  String? username;
  String? avatar;
  String? skillName;
  String? nameCategory;
  int? serviceId;
  int? priceOnline;
  int? priceOffline;
  int? timeOnline;
  int? timeOffline;
  double? averageRating;
  Information? information;
  List<Experience>? experience;
  List<Skill>? skill;

  UserDetailResponse({
    this.userId,
    this.username,
    this.avatar,
    this.skillName,
    this.nameCategory,
    this.serviceId,
    this.priceOnline,
    this.priceOffline,
    this.timeOnline,
    this.timeOffline,
    this.averageRating,
    this.information,
    this.experience,
    this.skill,
  });

  UserDetailResponse copyWith({
    int? userId,
    String? username,
    String? avatar,
    String? skillName,
    String? nameCategory,
    int? serviceId,
    int? priceOnline,
    int? priceOffline,
    int? timeOnline,
    int? timeOffline,
    double? averageRating,
    Information? information,
    List<Experience>? experience,
    List<Skill>? skill,
  }) {
    return UserDetailResponse(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      skillName: skillName ?? this.skillName,
      nameCategory: nameCategory ?? this.nameCategory,
      serviceId: serviceId ?? this.serviceId,
      priceOnline: priceOnline ?? this.priceOnline,
      priceOffline: priceOffline ?? this.priceOffline,
      timeOnline: timeOnline ?? this.timeOnline,
      timeOffline: timeOffline ?? this.timeOffline,
      averageRating: averageRating ?? this.averageRating,
      information: information ?? this.information,
      experience: experience ?? this.experience,
      skill: skill ?? this.skill,
    );
  }

  @override
  void decode(json) {
    userId =  json['user_id'];
    username = json['username'];
    avatar = json['avatar'];
    skillName = json['skill_name'];
    nameCategory = json['name_category'];
    serviceId = json['service_id'];
    priceOnline = json['price_online'];
    priceOffline = json['price_offline'];
    timeOnline = json['time_online'];
    timeOffline = json['time_offline'];
    averageRating = (json['average_rating'] ?? 0).toDouble();
    information = json['infor'] == null
        ? null
        : Information()?..decode(json['infor']);
    skill = json['skill'] == null
        ? null
        : (json['skill'] as List)
        .map((e) => Skill()..decode(e))
        .toList();
    experience = json['experience'] == null
        ? null
        : (json['experience'] as List)
        .map((e) => Experience()..decode(e))
        .toList();
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,##0', 'vi_VN');
    return '${formatter.format(amount)}đ';
  }

  String get priceOnlineString => formatCurrency(priceOnline ?? 0);
  String get priceOfflineString => formatCurrency(priceOffline ?? 0);
}

class Information implements Decodable{
  String? language;
  int? experienceYear;
  String? skillDescription;

  Information({
    this.language,
    this.experienceYear,
    this.skillDescription,
  });

  Information copyWith({
    String? language,
    int? experienceYear,
    String? skillDescription,
  }) {
    return Information(
      language: language ?? this.language,
      experienceYear: experienceYear ?? this.experienceYear,
      skillDescription: skillDescription ?? this.skillDescription,
    );
  }

  @override
  void decode(json) {
    language = json['language'];
    experienceYear = json['experience_year'];
    skillDescription = json['skill_description'];
  }
}

class Skill implements Decodable {
  int? expertId;
  String? avatar;
  int? serviceId;
  String? skillName;
  String? nameCategory;
  int? priceOnline;
  int? priceOffline;
  int? timeOnline;
  int? timeOffline;
  double? averageRating;

  Skill({
    this.expertId,
    this.avatar,
    this.serviceId,
    this.skillName,
    this.nameCategory,
    this.priceOnline,
    this.priceOffline,
    this.timeOnline,
    this.timeOffline,
    this.averageRating,
  });

  Skill copyWith({
    int? expertId,
    String? avatar,
    int? serviceId,
    String? skillName,
    String? nameCategory,
    int? priceOnline,
    int? priceOffline,
    int? timeOnline,
    int? timeOffline,
    double? averageRating,
  }) {
    return Skill(
        expertId: expertId ?? this.expertId,
        avatar: avatar ?? this.avatar,
        serviceId: serviceId ?? this.serviceId,
        skillName: skillName ?? this.skillName,
        nameCategory: nameCategory ?? this.nameCategory,
        priceOnline: priceOnline ?? this.priceOnline,
        priceOffline: priceOffline ?? this.priceOffline,
        timeOnline: timeOnline ?? this.timeOnline,
        timeOffline: timeOffline ?? this.timeOffline,
        averageRating: averageRating ?? this.averageRating
    );
  }

  @override
  void decode(json) {
    expertId = json['user_id'];
    avatar = json['avatar'];
    serviceId = json['service_id'];
    skillName = json['skill_name'];
    nameCategory = json['name_category'];
    priceOnline = json['price_online'];
    priceOffline = json['price_offline'];
    timeOnline = json['time_online'];
    timeOffline = json['time_offline'];
    averageRating = (json['average_rating'] ?? 0).toDouble();
  }

  String formatCurrency(int? amount) {
    final formatter = NumberFormat('#,##0', 'vi_VN');
    return '${formatter.format(amount)}đ';
  }

  String get priceOnlineString => formatCurrency(priceOnline);
  String get priceOfflineString => formatCurrency(priceOffline);
}

class Experience implements Decodable{
  String? company;
  String? position;
  String? categoryName;
  DateTime? startTime;
  DateTime? endTime;
  String? jobDescription;

  Experience({
    this.company,
    this.position,
    this.categoryName,
    this.startTime,
    this.endTime,
    this.jobDescription,
  });

  Experience copyWith({
    String? company,
    String? position,
    String? categoryName,
    DateTime? startTime,
    DateTime? endTime,
    String? jobDescription,
  }) {
    return Experience(
      company: company ?? this.company,
      position: position ?? this.position,
      categoryName: categoryName ?? this.categoryName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      jobDescription: jobDescription ?? this.jobDescription,
    );
  }

  @override
  void decode(json) {
    company = json['company'];
    position = json['position'];
    categoryName = json['category_name'];
    startTime = json['start_time'] != null ? DateTime.parse(json['start_time']) : null;
    endTime = json['end_time'] != null ? DateTime.parse(json['end_time']) : null;
    jobDescription = json['job_description'];
  }

  String get timeText {
    final start = '${startTime?.month}/${startTime?.year}';
    final end = endTime == null ? 'Hiện nay' : '${endTime?.month}/${endTime?.year}';
    return '$start - $end';
  }
}