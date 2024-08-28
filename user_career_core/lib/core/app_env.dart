import 'package:mobile_framework/packages/env/environment.dart';

enum AppEnvKey implements EnvExtraKey {
  oneSignalAppIdKey,
}

class DevEnv extends Env {
  DevEnv() {
    set(AppEnvKey.oneSignalAppIdKey, "");
  }

  @override
  String get apiVersion => '';

  @override
  String get baseUrl => '';

  @override
  String get fileBaseUrl => '';

  @override
  TargetApp get targetApp => TargetApp.none;

  @override
  EnvType get type => EnvType.dev;
}