import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/responses/user_detail_response.dart';
import 'package:user_career_auth/admin/repositories/admin_repository.dart';
import 'package:user_career_core/user_career_core.dart';

class ExpectDetailController extends AutoDisposeFamilyAsyncNotifier<UserDetailResponse, int>
    with AlertMixin {
  @override
  FutureOr<UserDetailResponse> build(int arg) {
    return getDetailExpect(arg);
  }

  Future<UserDetailResponse> getDetailExpect(int id) async {
    try {
      final result = await ref
          .read(adminRepositoryProvider)
          .getUserDetail(id)
          .showErrorBy(this)
          .map(onValue: (value) => value ?? UserDetailResponse())
          .mapToValueOr(defaultValue: UserDetailResponse()).asFuture();
      return result;
    } catch (e) {
      return UserDetailResponse();
    }
  }
}

final expectDetailControllerProvider =
AsyncNotifierProvider.autoDispose.family<ExpectDetailController, UserDetailResponse,int>(() {
  return ExpectDetailController();
});