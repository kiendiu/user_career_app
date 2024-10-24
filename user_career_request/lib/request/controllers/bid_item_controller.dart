import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_request/request/models/bid_model.dart';
import 'package:user_career_request/request/models/enums/bid_status_enum.dart';

final bidItemControllerProvider = StateProvider.family<BidModel?, BidStatusEnum?>((ref, BidStatusEnum? arg) {
  return null;
});
