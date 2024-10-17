// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:user_career_request/core/tab_router.dart' as _i6;
import 'package:user_career_request/request/models/request_model.dart' as _i9;
import 'package:user_career_request/request/pages/add_request_page.dart' as _i1;
import 'package:user_career_request/request/pages/request_detail_page.dart'
    as _i4;
import 'package:user_career_request/request/pages/request_page.dart' as _i5;
import 'package:user_career_request/request/pages/views/general_view.dart'
    as _i2;
import 'package:user_career_request/request/pages/views/mine_view.dart' as _i3;

abstract class $RequestRouterModule extends _i7.AutoRouterModule {
  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AddRequestRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddRequestPage(),
      );
    },
    GeneralRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.GeneralPage(),
      );
    },
    MineRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MinePage(),
      );
    },
    RequestDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RequestDetailRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.RequestDetailPage(
          key: args.key,
          request: args.request,
        ),
      );
    },
    RequestRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.RequestPage(),
      );
    },
    RequestTabRouter.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RequestTabRouter(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddRequestPage]
class AddRequestRoute extends _i7.PageRouteInfo<void> {
  const AddRequestRoute({List<_i7.PageRouteInfo>? children})
      : super(
          AddRequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddRequestRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.GeneralPage]
class GeneralRoute extends _i7.PageRouteInfo<void> {
  const GeneralRoute({List<_i7.PageRouteInfo>? children})
      : super(
          GeneralRoute.name,
          initialChildren: children,
        );

  static const String name = 'GeneralRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.MinePage]
class MineRoute extends _i7.PageRouteInfo<void> {
  const MineRoute({List<_i7.PageRouteInfo>? children})
      : super(
          MineRoute.name,
          initialChildren: children,
        );

  static const String name = 'MineRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.RequestDetailPage]
class RequestDetailRoute extends _i7.PageRouteInfo<RequestDetailRouteArgs> {
  RequestDetailRoute({
    _i8.Key? key,
    required _i9.RequestModel request,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          RequestDetailRoute.name,
          args: RequestDetailRouteArgs(
            key: key,
            request: request,
          ),
          initialChildren: children,
        );

  static const String name = 'RequestDetailRoute';

  static const _i7.PageInfo<RequestDetailRouteArgs> page =
      _i7.PageInfo<RequestDetailRouteArgs>(name);
}

class RequestDetailRouteArgs {
  const RequestDetailRouteArgs({
    this.key,
    required this.request,
  });

  final _i8.Key? key;

  final _i9.RequestModel request;

  @override
  String toString() {
    return 'RequestDetailRouteArgs{key: $key, request: $request}';
  }
}

/// generated route for
/// [_i5.RequestPage]
class RequestRoute extends _i7.PageRouteInfo<void> {
  const RequestRoute({List<_i7.PageRouteInfo>? children})
      : super(
          RequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RequestTabRouter]
class RequestTabRouter extends _i7.PageRouteInfo<void> {
  const RequestTabRouter({List<_i7.PageRouteInfo>? children})
      : super(
          RequestTabRouter.name,
          initialChildren: children,
        );

  static const String name = 'RequestTabRouter';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
