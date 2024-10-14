import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/home/models/expect_detail_response.dart';
import 'package:user_career_home/home/repositories/home_repository.dart';


class ExpectDetailController extends AutoDisposeFamilyAsyncNotifier<ExpectDetailResponse, int>
with AlertMixin {
  @override
  FutureOr<ExpectDetailResponse> build(int arg) {
    return getDetailExpect(arg);
  }

  Future<ExpectDetailResponse> getDetailExpect(int id) async {
    try {
      final result = await ref
        .read(homeRepositoryProvider)
        .getDetailExpect(id)
        .showErrorBy(this)
        .map(onValue: (value) => value ?? ExpectDetailResponse())
        .mapToValueOr(defaultValue: ExpectDetailResponse()).asFuture();
      return result;
    } catch (e) {
      return ExpectDetailResponse();
    }
  }
}

final expectDetailControllerProvider =
AsyncNotifierProvider.autoDispose.family<ExpectDetailController, ExpectDetailResponse,int>(() {
  return ExpectDetailController();
});