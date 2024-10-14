// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:user_career_home/core/tab_router.dart' as _i4;
import 'package:user_career_home/home/pages/expect_detail_page.dart' as _i1;
import 'package:user_career_home/home/pages/filter_page.dart' as _i2;
import 'package:user_career_home/home/pages/home_page.dart' as _i3;

abstract class $HomeRouterModule extends _i5.AutoRouterModule {
  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    ExpectDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ExpectDetailRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ExpectDetailPage(
          key: args.key,
          expectId: args.expectId,
        ),
      );
    },
    FilterRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.FilterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    HomeTabRouter.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeTabRouter(),
      );
    },
  };
}

/// generated route for
/// [_i1.ExpectDetailPage]
class ExpectDetailRoute extends _i5.PageRouteInfo<ExpectDetailRouteArgs> {
  ExpectDetailRoute({
    _i6.Key? key,
    required int expectId,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          ExpectDetailRoute.name,
          args: ExpectDetailRouteArgs(
            key: key,
            expectId: expectId,
          ),
          initialChildren: children,
        );

  static const String name = 'ExpectDetailRoute';

  static const _i5.PageInfo<ExpectDetailRouteArgs> page =
      _i5.PageInfo<ExpectDetailRouteArgs>(name);
}

class ExpectDetailRouteArgs {
  const ExpectDetailRouteArgs({
    this.key,
    required this.expectId,
  });

  final _i6.Key? key;

  final int expectId;

  @override
  String toString() {
    return 'ExpectDetailRouteArgs{key: $key, expectId: $expectId}';
  }
}

/// generated route for
/// [_i2.FilterPage]
class FilterRoute extends _i5.PageRouteInfo<void> {
  const FilterRoute({List<_i5.PageRouteInfo>? children})
      : super(
          FilterRoute.name,
          initialChildren: children,
        );

  static const String name = 'FilterRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeTabRouter]
class HomeTabRouter extends _i5.PageRouteInfo<void> {
  const HomeTabRouter({List<_i5.PageRouteInfo>? children})
      : super(
          HomeTabRouter.name,
          initialChildren: children,
        );

  static const String name = 'HomeTabRouter';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
