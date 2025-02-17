
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';

enum AppEnvKey implements EnvExtraKey {
  oneSignalAppIdKey,
}

class DevEnv extends Env {
  late final String _ipAddress;

  DevEnv() {
    _ipAddress = Storage.get(POSStorageKey.ipAddressKey) ?? 'localhost';
    set(AppEnvKey.oneSignalAppIdKey, "");
  }

  @override
  String get apiVersion => '/api';

  @override
  String get baseUrl => 'http://10.0.2.2:3000';

  @override
  String get fileBaseUrl => '';

  @override
  TargetApp get targetApp => TargetApp.none;

  @override
  EnvType get type => EnvType.dev;
}