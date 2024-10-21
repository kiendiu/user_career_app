import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/expect_price_service/models/skill_response.dart';

class ServiceUserRequest implements Encodable{
  int? serviceId;
  int? skillId;
  int? userId;
  int? timeOnline;
  int? priceOnline;
  int? timeOffline;
  int? priceOffline;
  List<ServiceFrameRequest>? frames;
  List<BaseSelectableItemModel<SkillResponse>>? skill;

  ServiceUserRequest({
    this.serviceId,
    this.skillId,
    this.userId,
    this.timeOnline,
    this.priceOnline,
    this.timeOffline,
    this.priceOffline,
    this.frames,
    this.skill,
  });

  ServiceUserRequest copyWith({
    int? serviceId,
    int? skillId,
    int? userId,
    int? timeOnline,
    int? priceOnline,
    int? timeOffline,
    int? priceOffline,
    List<ServiceFrameRequest>? frames,
    List<BaseSelectableItemModel<SkillResponse>>? skill,
  }) {
    return ServiceUserRequest(
      serviceId: serviceId ?? this.serviceId,
      skillId: skillId ?? this.skillId,
      userId: userId ?? this.userId,
      timeOnline: timeOnline ?? this.timeOnline,
      priceOnline: priceOnline ?? this.priceOnline,
      timeOffline: timeOffline ?? this.timeOffline,
      priceOffline: priceOffline ?? this.priceOffline,
      frames: frames ?? this.frames,
      skill: skill ?? this.skill,
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      'service_id': serviceId,
      'skill_id': skillId == 0 ? null : skillId,
      'user_id': Storage.get(POSStorageKey.userId),
      'time_online': timeOnline,
      'price_online': priceOnline,
      'time_offline': timeOffline,
      'price_offline': priceOffline,
      'frames': frames?.map((e) => e.encode()).toList(),
    };
  }

  bool get isEmptyTimeOnline => timeOnline != null && timeOnline! > 0 && timeOnline! % 15 == 0;

  bool get isEmptyPriceOnline => priceOnline != null && priceOnline! >= 10000;

  bool get isEmptyTimeOffline => timeOffline != null && timeOffline! > 0  && timeOffline! % 15 == 0;

  bool get isEmptyPriceOffline => priceOffline != null && priceOffline! >= 10000;
}

class ServiceFrameRequest implements Encodable {
  int? serviceFrameId;
  String? weekDay;
  String? startTime;
  String? endTime;

  ServiceFrameRequest({
    this.serviceFrameId,
    this.weekDay,
    this.startTime,
    this.endTime,
  });

  ServiceFrameRequest copyWith({
    int? serviceFrameId,
    String? weekDay,
    String? startTime,
    String? endTime,
  }) {
    return ServiceFrameRequest(
      serviceFrameId: serviceFrameId ?? this.serviceFrameId,
      weekDay: weekDay ?? this.weekDay,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      'service_frame_id': serviceFrameId,
      'week_day': weekDay,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}