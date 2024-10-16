// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:user_career_request/core/tab_router.dart' as _i5;
import 'package:user_career_request/request/models/request_model.dart' as _i8;
import 'package:user_career_request/request/pages/request_detail_page.dart'
    as _i3;
import 'package:user_career_request/request/pages/request_page.dart' as _i4;
import 'package:user_career_request/request/pages/views/general_view.dart'
    as _i1;
import 'package:user_career_request/request/pages/views/mine_view.dart' as _i2;

abstract class $RequestRouterModule extends _i6.AutoRouterModule {
  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    GeneralRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.GeneralPage(),
      );
    },
    MineRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MinePage(),
      );
    },
    RequestDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RequestDetailRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.RequestDetailPage(
          key: args.key,
          request: args.request,
        ),
      );
    },
    RequestRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.RequestPage(),
      );
    },
    RequestTabRouter.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.RequestTabRouter(),
      );
    },
  };
}

/// generated route for
/// [_i1.GeneralPage]
class GeneralRoute extends _i6.PageRouteInfo<void> {
  const GeneralRoute({List<_i6.PageRouteInfo>? children})
      : super(
          GeneralRoute.name,
          initialChildren: children,
        );

  static const String name = 'GeneralRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MinePage]
class MineRoute extends _i6.PageRouteInfo<void> {
  const MineRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MineRoute.name,
          initialChildren: children,
        );

  static const String name = 'MineRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.RequestDetailPage]
class RequestDetailRoute extends _i6.PageRouteInfo<RequestDetailRouteArgs> {
  RequestDetailRoute({
    _i7.Key? key,
    required _i8.RequestModel request,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          RequestDetailRoute.name,
          args: RequestDetailRouteArgs(
            key: key,
            request: request,
          ),
          initialChildren: children,
        );

  static const String name = 'RequestDetailRoute';

  static const _i6.PageInfo<RequestDetailRouteArgs> page =
      _i6.PageInfo<RequestDetailRouteArgs>(name);
}

class RequestDetailRouteArgs {
  const RequestDetailRouteArgs({
    this.key,
    required this.request,
  });

  final _i7.Key? key;

  final _i8.RequestModel request;

  @override
  String toString() {
    return 'RequestDetailRouteArgs{key: $key, request: $request}';
  }
}

/// generated route for
/// [_i4.RequestPage]
class RequestRoute extends _i6.PageRouteInfo<void> {
  const RequestRoute({List<_i6.PageRouteInfo>? children})
      : super(
          RequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.RequestTabRouter]
class RequestTabRouter extends _i6.PageRouteInfo<void> {
  const RequestTabRouter({List<_i6.PageRouteInfo>? children})
      : super(
          RequestTabRouter.name,
          initialChildren: children,
        );

  static const String name = 'RequestTabRouter';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
