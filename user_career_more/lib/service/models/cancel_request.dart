import 'package:user_career_core/user_career_core.dart';

class CancelRequest implements Encodable{
  String? cancelReason;

  CancelRequest({
    this.cancelReason,
  });

  CancelRequest copyWith({
    String? cancelReason,
  }) {
    return CancelRequest(
      cancelReason: cancelReason ?? this.cancelReason,
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      'cancel_reason': cancelReason,
    };
  }

  bool get isEmptyCancelReason => cancelReason != null && cancelReason!.isNotEmpty;

}