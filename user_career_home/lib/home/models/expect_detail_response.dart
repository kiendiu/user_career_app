import 'package:intl/intl.dart';
import 'package:user_career_core/user_career_core.dart';

class ExpectDetailResponse implements Decodable {
  int? userId;
  String? username;
  String? avatar;
  String? skillName;
  String? nameCategory;
  int? priceOnline;
  int? priceOffline;
  int? timeOnline;
  int? timeOffline;
  double? averageRating;
  Information? information;
  List<Experience>? experience;
  List<Skill>? skill;
  Review? review;

  ExpectDetailResponse({
    this.userId,
    this.username,
    this.avatar,
    this.skillName,
    this.nameCategory,
    this.priceOnline,
    this.priceOffline,
    this.timeOnline,
    this.timeOffline,
    this.averageRating,
    this.information,
    this.experience,
    this.skill,
    this.review,
  });

  ExpectDetailResponse copyWith({
    int? userId,
    String? username,
    String? avatar,
    String? skillName,
    String? nameCategory,
    int? priceOnline,
    int? priceOffline,
    int? timeOnline,
    int? timeOffline,
    double? averageRating,
    Information? information,
    List<Experience>? experience,
    List<Skill>? skill,
    Review? review,
  }) {
    return ExpectDetailResponse(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      skillName: skillName ?? this.skillName,
      nameCategory: nameCategory ?? this.nameCategory,
      priceOnline: priceOnline ?? this.priceOnline,
      priceOffline: priceOffline ?? this.priceOffline,
      timeOnline: timeOnline ?? this.timeOnline,
      timeOffline: timeOffline ?? this.timeOffline,
      averageRating: averageRating ?? this.averageRating,
      information: information ?? this.information,
      experience: experience ?? this.experience,
      skill: skill ?? this.skill,
      review: review ?? this.review,
    );
  }

  @override
  void decode(json) {
    userId =  json['user_id'];
    username = json['username'];
    avatar = json['avatar'];
    skillName = json['skill_name'];
    nameCategory = json['name_category'];
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
    review = json['review'] == null
        ? null
        : Review()?..decode(json['review']);
  }

  String formatCurrency(int? amount) {
    final formatter = NumberFormat('#,##0', 'vi_VN');
    return '${formatter.format(amount)}đ';
  }

  String get priceOnlineString => formatCurrency(priceOnline);
  String get priceOfflineString => formatCurrency(priceOffline);
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
  String? avatar;
  String? skillName;
  String? nameCategory;
  int? priceOnline;
  int? priceOffline;
  int? timeOnline;
  int? timeOffline;
  double? averageRating;

  Skill({
    this.avatar,
    this.skillName,
    this.nameCategory,
    this.priceOnline,
    this.priceOffline,
    this.timeOnline,
    this.timeOffline,
    this.averageRating,
  });
  
  Skill copyWith({
    String? avatar,
    String? skillName,
    String? nameCategory,
    int? priceOnline,
    int? priceOffline,
    int? timeOnline,
    int? timeOffline,
    double? averageRating,
  }) {
    return Skill(
      avatar: avatar ?? this.avatar,
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
    avatar = json['avatar'];
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

class Review implements Decodable{
  double? averageRating;
  int? totalReview;
  List<Evaluate>? evaluate;

  Review({
    this.averageRating,
    this.totalReview,
    this.evaluate,
  });

  Review copyWith({
    double? averageRating,
    int? totalReview,
    List<Evaluate>? evaluate,
  }) {
    return Review(
      averageRating: averageRating ?? this.averageRating,
      totalReview: totalReview ?? this.totalReview,
      evaluate: evaluate ?? this.evaluate
    );
  }

  @override
  void decode(json) {
    averageRating = (json['average_rating'] ?? 0).toDouble();
    totalReview = json['total_review'];
    evaluate = json['evaluate'] == null
        ? null
        : (json['evaluate'] as List)
        .map((e) => Evaluate()..decode(e))
        .toList();
  }
}

class Evaluate implements Decodable{
  String? customerName;
  String? customerAvatar;
  int? rating;
  DateTime? createAt;
  String? reviewDescription;

  Evaluate({
    this.customerName,
    this.customerAvatar,
    this.rating,
    this.createAt,
    this.reviewDescription,
  });

  Evaluate copyWith({
    String? customerName,
    String? customerAvatar,
    int? rating,
    DateTime? createAt,
    String? reviewDescription,
  }) {
    return Evaluate(
      customerName: customerName ?? this.customerName,
      customerAvatar: customerAvatar ?? this.customerAvatar,
      rating: rating ?? this.rating,
      createAt: createAt ?? this.createAt,
      reviewDescription: reviewDescription ?? this.reviewDescription,
    );
  }

  @override
  void decode(json) {
    customerName = json['customer_name'];
    customerAvatar = json['customer_avatar'];
    rating = json['rating'];
    createAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    reviewDescription = json['review_description'];
  }

  String? get createAtString => createAt.hhMMddyyyy2();

}