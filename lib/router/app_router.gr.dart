// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i1;
import 'package:user_career_auth/core/router.dart' as _i6;
import 'package:user_career_core/user_career_core.dart' as _i7;
import 'package:user_career_home/core/router.dart' as _i2;
import 'package:user_career_message/core/router.dart' as _i4;
import 'package:user_career_more/core/router.dart' as _i5;
import 'package:user_career_request/core/router.dart' as _i3;

abstract class $AppRouter extends _i1.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    ..._i2.HomeRouterModule().pagesMap,
    ..._i3.RequestRouterModule().pagesMap,
    ..._i4.MessageRouterModule().pagesMap,
    ..._i5.MoreRouterModule().pagesMap,
    ..._i6.AuthRouterModule().pagesMap,
    ..._i7.MobileFrameworkRouterModule().pagesMap,
  };
}
