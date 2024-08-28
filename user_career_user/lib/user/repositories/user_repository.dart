// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:user_career_core/user_career_core.dart';
// import 'package:user_career_user/core/repository.dart';
// import 'package:user_career_user/user/models/user.dart';
//
// abstract interface class IUserRepository {
//   ResultFuture<User> getUserInfo();
// }
//
// class UserRepository extends UserBaseRepository implements IUserRepository {
//   @override
//   ResultFuture<User> getUserInfo() {
//     return make
//         .request(path: "/auth/me", body: {}, decoder: UserModel())
//         .post();
//   }
// }
//
// final userRepositoryProvider = Provider.autoDispose<IUserRepository>((ref) {
//   return UserRepository();
// });
