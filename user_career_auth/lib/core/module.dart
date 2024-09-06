import 'package:user_career_auth/core/router.gm.dart';
import 'package:user_career_core/user_career_core.dart';

class AuthModule extends Module {
  AuthModule(super.env);

  @override
  void prepare() {
    super.prepare();
    NotificationCenter().addObserver(RawStringNotificationName("log_out"), callback: (_){
      appRouter.replaceAll(const [SignInRoute()]);
    });
  }
}