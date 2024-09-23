import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
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
  String get baseUrl => 'http://192.168.5.243:3000';

  @override
  String get fileBaseUrl => '';

  @override
  TargetApp get targetApp => TargetApp.none;

  @override
  EnvType get type => EnvType.dev;

  Future<String?> getIpAddress() async {
    try {
      List<NetworkInterface> interfaces = await NetworkInterface.list();
      for (var interface in interfaces) {
        for (var address in interface.addresses) {
          if (address.type == InternetAddressType.IPv4) {
            return address.address;
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}