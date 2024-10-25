import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_more/service/models/service_model.dart';

final serviceItemProvider = StateProvider.family<ServiceModel?, int?>((ref, int? arg) {
  return null;
},);