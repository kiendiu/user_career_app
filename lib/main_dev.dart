import 'package:flutter/cupertino.dart';
import 'package:user_career/main.dart';
import 'package:user_career_core/user_career_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await saveIpAddress();

  createApp(DevEnv());
}