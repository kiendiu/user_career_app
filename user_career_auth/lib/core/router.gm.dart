// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:user_career_auth/mail_verify_code/pages/mail_verify_code_page.dart'
    as _i1;
import 'package:user_career_auth/reset_password/pages/reset_password_page.dart'
    as _i2;
import 'package:user_career_auth/reset_password/pages/successful_page.dart'
    as _i5;
import 'package:user_career_auth/send_email_verify/pages/send_mail_verify_page.dart'
    as _i3;
import 'package:user_career_auth/sign_in/pages/sign_in_page.dart' as _i4;

abstract class $AuthRouterModule extends _i6.AutoRouterModule {
  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MailVerifyCodeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.MailVerifyCodePage(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ResetPasswordPage(),
      );
    },
    SendMailVerifyRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SendMailVerifyPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SignInPage(),
      );
    },
    SuccessfulRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SuccessfulPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.MailVerifyCodePage]
class MailVerifyCodeRoute extends _i6.PageRouteInfo<void> {
  const MailVerifyCodeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MailVerifyCodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MailVerifyCodeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ResetPasswordPage]
class ResetPasswordRoute extends _i6.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i6.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SendMailVerifyPage]
class SendMailVerifyRoute extends _i6.PageRouteInfo<void> {
  const SendMailVerifyRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SendMailVerifyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SendMailVerifyRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SignInPage]
class SignInRoute extends _i6.PageRouteInfo<void> {
  const SignInRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SuccessfulPage]
class SuccessfulRoute extends _i6.PageRouteInfo<void> {
  const SuccessfulRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SuccessfulRoute.name,
          initialChildren: children,
        );

  static const String name = 'SuccessfulRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
