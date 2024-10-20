// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:user_career_home/booking/models/info_booking_model.dart' as _i8;
import 'package:user_career_home/booking/pages/booking_page.dart' as _i1;
import 'package:user_career_home/core/tab_router.dart' as _i5;
import 'package:user_career_home/home/pages/expect_detail_page.dart' as _i2;
import 'package:user_career_home/home/pages/filter_page.dart' as _i3;
import 'package:user_career_home/home/pages/home_page.dart' as _i4;

abstract class $HomeRouterModule extends _i6.AutoRouterModule {
  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    BookingRoute.name: (routeData) {
      final args = routeData.argsAs<BookingRouteArgs>(
          orElse: () => const BookingRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BookingPage(
          key: args.key,
          infoBookingModel: args.infoBookingModel,
        ),
      );
    },
    ExpectDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ExpectDetailRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ExpectDetailPage(
          key: args.key,
          expectId: args.expectId,
        ),
      );
    },
    FilterRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.FilterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomePage(),
      );
    },
    HomeTabRouter.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeTabRouter(),
      );
    },
  };
}

/// generated route for
/// [_i1.BookingPage]
class BookingRoute extends _i6.PageRouteInfo<BookingRouteArgs> {
  BookingRoute({
    _i7.Key? key,
    _i8.InfoBookingModel? infoBookingModel,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          BookingRoute.name,
          args: BookingRouteArgs(
            key: key,
            infoBookingModel: infoBookingModel,
          ),
          initialChildren: children,
        );

  static const String name = 'BookingRoute';

  static const _i6.PageInfo<BookingRouteArgs> page =
      _i6.PageInfo<BookingRouteArgs>(name);
}

class BookingRouteArgs {
  const BookingRouteArgs({
    this.key,
    this.infoBookingModel,
  });

  final _i7.Key? key;

  final _i8.InfoBookingModel? infoBookingModel;

  @override
  String toString() {
    return 'BookingRouteArgs{key: $key, infoBookingModel: $infoBookingModel}';
  }
}

/// generated route for
/// [_i2.ExpectDetailPage]
class ExpectDetailRoute extends _i6.PageRouteInfo<ExpectDetailRouteArgs> {
  ExpectDetailRoute({
    _i7.Key? key,
    required int expectId,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          ExpectDetailRoute.name,
          args: ExpectDetailRouteArgs(
            key: key,
            expectId: expectId,
          ),
          initialChildren: children,
        );

  static const String name = 'ExpectDetailRoute';

  static const _i6.PageInfo<ExpectDetailRouteArgs> page =
      _i6.PageInfo<ExpectDetailRouteArgs>(name);
}

class ExpectDetailRouteArgs {
  const ExpectDetailRouteArgs({
    this.key,
    required this.expectId,
  });

  final _i7.Key? key;

  final int expectId;

  @override
  String toString() {
    return 'ExpectDetailRouteArgs{key: $key, expectId: $expectId}';
  }
}

/// generated route for
/// [_i3.FilterPage]
class FilterRoute extends _i6.PageRouteInfo<void> {
  const FilterRoute({List<_i6.PageRouteInfo>? children})
      : super(
          FilterRoute.name,
          initialChildren: children,
        );

  static const String name = 'FilterRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomeTabRouter]
class HomeTabRouter extends _i6.PageRouteInfo<void> {
  const HomeTabRouter({List<_i6.PageRouteInfo>? children})
      : super(
          HomeTabRouter.name,
          initialChildren: children,
        );

  static const String name = 'HomeTabRouter';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
