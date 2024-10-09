import 'package:user_career_core/user_career_core.dart';

class AddServiceUserRequest implements Encodable{
  int? skillId;
  int? timeOnline;
  int? priceOnline;
  int? timeOffline;
  int? priceOffline;
  List<AddServiceFrameRequest>? frames;

  AddServiceUserRequest({
    this.skillId,
    this.timeOnline,
    this.priceOnline,
    this.timeOffline,
    this.priceOffline,
    this.frames,
  });

  AddServiceUserRequest copyWith({
    int? serviceId,
    int? skillId,
    int? userId,
    int? timeOnline,
    int? priceOnline,
    int? timeOffline,
    int? priceOffline,
    List<AddServiceFrameRequest>? frames,
  }) {
    return AddServiceUserRequest(
      skillId: skillId ?? this.skillId,
      timeOnline: timeOnline ?? this.timeOnline,
      priceOnline: priceOnline ?? this.priceOnline,
      timeOffline: timeOffline ?? this.timeOffline,
      priceOffline: priceOffline ?? this.priceOffline,
      frames: frames ?? this.frames,
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      'skill_id': skillId == 0 ? null : skillId,
      'time_online': timeOnline,
      'price_online': priceOnline,
      'time_offline': timeOffline,
      'price_offline': priceOffline,
      'frames': frames?.map((e) => e.encode()).toList(),
    };
  }
}

class AddServiceFrameRequest implements Encodable {
  String? weekDay;
  String? startTime;
  String? endTime;

  AddServiceFrameRequest({
    this.weekDay,
    this.startTime,
    this.endTime,
  });

  AddServiceFrameRequest copyWith({
    String? weekDay,
    String? startTime,
    String? endTime,
  }) {
    return AddServiceFrameRequest(
      weekDay: weekDay ?? this.weekDay,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      'week_day': weekDay,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}