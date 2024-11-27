import 'package:user_career_auth/admin/models/enums/approval_enum.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:intl/intl.dart';

class UserResponse implements Decodable {
  int? userId;
  String? username;
  String? avatar;
  ApprovalEnum? approval;
  String? reasonReject;
  String? skillName;
  String? nameCategory;
  int? priceOnline;
  int? priceOffline;
  int? timeOnline;
  int? timeOffline;

  UserResponse({
    this.userId,
    this.username,
    this.avatar,
    this.approval,
    this.reasonReject,
    this.skillName,
    this.nameCategory,
    this.priceOnline,
    this.priceOffline,
    this.timeOnline,
    this.timeOffline,
  });

  UserResponse copyWith({
    int? userId,
    String? username,
    String? avatar,
    ApprovalEnum? approval,
    String? reasonReject,
    String? skillName,
    String? nameCategory,
    int? priceOnline,
    int? priceOffline,
    int? timeOnline,
    int? timeOffline,
  }) =>
      UserResponse(
        userId: userId ?? this.userId,
        username: username ?? this.username,
        avatar: avatar ?? this.avatar,
        approval: approval ?? this.approval,
        reasonReject: reasonReject ?? this.reasonReject,
        skillName: skillName ?? this.skillName,
        nameCategory: nameCategory ?? this.nameCategory,
        priceOnline: priceOnline ?? this.priceOnline,
        priceOffline: priceOffline ?? this.priceOffline,
        timeOnline: timeOnline ?? this.timeOnline,
        timeOffline: timeOffline ?? this.timeOffline,
      );

  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,##0', 'vi_VN');
    return '${formatter.format(amount)}đ';
  }

  String get priceOnlineString => formatCurrency(priceOnline ?? 0);
  String get priceOfflineString => formatCurrency(priceOffline ?? 0);

  @override
  void decode(json) {
    userId = json?['user_id'];
    username = json?['username'];
    avatar = json?['avatar'];
    approval = ApprovalEnum.values.firstWhereOrNull(
          (element) => element.rawValue == json?['approval'],
    );
    reasonReject = json?['reason_reject'];
    skillName = json?['skill_name'];
    nameCategory = json?['name_category'];
    priceOnline = json?['price_online'];
    priceOffline = json?['price_offline'];
    timeOnline = json?['time_online'];
    timeOffline = json?['time_offline'];
  }
}
