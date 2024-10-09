import 'package:user_career_core/user_career_core.dart';

class ServiceUserResponse implements Decodable{
  int? serviceId;
  int? skillId;
  String? nameSkill;
  int? timeOnline;
  int? priceOnline;
  int? timeOffline;
  int? priceOffline;
  List<ServiceFrame>? frames;

  ServiceUserResponse({
    this.serviceId,
    this.skillId,
    this.nameSkill,
    this.timeOnline,
    this.priceOnline,
    this.timeOffline,
    this.priceOffline,
    this.frames,
  });

  ServiceUserResponse copyWith({
    int? serviceId,
    int? skillId,
    String? nameSkill,
    int? timeOnline,
    int? priceOnline,
    int? timeOffline,
    int? priceOffline,
    List<ServiceFrame>? frames,
  }) {
    return ServiceUserResponse(
      serviceId: serviceId ?? this.serviceId,
      skillId: skillId ?? this.skillId,
      nameSkill: nameSkill ?? this.nameSkill,
      timeOnline: timeOnline ?? this.timeOnline,
      priceOnline: priceOnline ?? this.priceOnline,
      timeOffline: timeOffline ?? this.timeOffline,
      priceOffline: priceOffline ?? this.priceOffline,
      frames: frames ?? this.frames,
    );
  }
  @override
  void decode(json) {
    if (json['data'] != null && json['data'] is List && json['data'].isNotEmpty) {
      var data = json['data'][0];
      serviceId = data['service_id'];
      skillId = data['skill_id'];
      nameSkill = data['name_skill'];
      timeOnline = data['time_online'];
      priceOnline = data['price_online'];
      timeOffline = data['time_offline'];
      priceOffline = data['price_offline'];
      frames = data['frames'] == null
          ? null
          : (data['frames'] as List)
          .map((e) => ServiceFrame()..decode(e))
          .toList();
    }
  }
}

class ServiceFrame implements Decodable {
  int? serviceFrameId;
  String? weekDay;
  String? startTime;
  String? endTime;

  ServiceFrame({
    this.serviceFrameId,
    this.weekDay,
    this.startTime,
    this.endTime,
  });

  ServiceFrame copyWith({
    int? serviceFrameId,
    String? weekDay,
    String? startTime,
    String? endTime,
  }) {
    return ServiceFrame(
      serviceFrameId: serviceFrameId ?? this.serviceFrameId,
      weekDay: weekDay ?? this.weekDay,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  void decode(json) {
    serviceFrameId = json['service_frame_id'];
    weekDay = json['week_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }
}

enum WeekDayEnum {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String get localizedValue => switch (this) {
    WeekDayEnum.monday => "Thứ Hai",
    WeekDayEnum.tuesday => "Thứ Ba",
    WeekDayEnum.wednesday => "Thứ Tư",
    WeekDayEnum.thursday => "Thứ Năm",
    WeekDayEnum.friday => "Thứ Sáu",
    WeekDayEnum.saturday => "Thứ Bảy",
    WeekDayEnum.sunday => "Chủ Nhật",

  };

  String get rawValue => switch (this) {
    WeekDayEnum.monday => "T2",
    WeekDayEnum.tuesday => "T3",
    WeekDayEnum.wednesday => "T4",
    WeekDayEnum.thursday => "T5",
    WeekDayEnum.friday => "T6",
    WeekDayEnum.saturday => "T7",
    WeekDayEnum.sunday => "CN",
  };

  int get weekDayId => switch (this) {
    WeekDayEnum.monday => 2,
    WeekDayEnum.tuesday => 3,
    WeekDayEnum.wednesday => 4,
    WeekDayEnum.thursday => 5,
    WeekDayEnum.friday => 6,
    WeekDayEnum.saturday => 7,
    WeekDayEnum.sunday => 8,
  };
}