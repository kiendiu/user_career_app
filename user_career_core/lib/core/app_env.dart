import 'package:mobile_framework/packages/env/environment.dart';

enum AppEnvKey implements EnvExtraKey {
  oneSignalAppIdKey,
}

class DevEnv extends Env {
  DevEnv() {
    set(AppEnvKey.oneSignalAppIdKey, "");
  }

  @override
  String get apiVersion => '/api';

  @override
  String get baseUrl => 'http://192.168.5.242:3000';

  @override
  String get fileBaseUrl => '';

  @override
  TargetApp get targetApp => TargetApp.none;

  @override
  EnvType get type => EnvType.dev;
}