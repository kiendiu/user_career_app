import 'package:user_career_core/user_career_core.dart';

enum NotificationType
implements ModuleNotificationType, StringRawRepresentable {
  requestDetail,
  none;

  @override
  String get rawValue => switch (this) {
    NotificationType.requestDetail => "request",
    NotificationType.none => ""
  };

  static NotificationType fromString(String? value) {
    return NotificationType.values.firstWhere(
            (element) => element.rawValue == value,
        orElse: () => NotificationType.none);
  }
}
