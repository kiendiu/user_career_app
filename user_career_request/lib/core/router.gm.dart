// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/cupertino.dart' as _i10;
import 'package:flutter/material.dart' as _i12;
import 'package:user_career_request/core/tab_router.dart' as _i8;
import 'package:user_career_request/request/models/info_booking_bid_model.dart'
    as _i13;
import 'package:user_career_request/request/models/request_model.dart' as _i11;
import 'package:user_career_request/request/pages/add_request_page.dart' as _i1;
import 'package:user_career_request/request/pages/bid_request_page.dart' as _i2;
import 'package:user_career_request/request/pages/booking_bid_page.dart' as _i3;
import 'package:user_career_request/request/pages/request_detail_page.dart'
    as _i6;
import 'package:user_career_request/request/pages/request_page.dart' as _i7;
import 'package:user_career_request/request/pages/views/general_view.dart'
    as _i4;
import 'package:user_career_request/request/pages/views/mine_view.dart' as _i5;

abstract class $RequestRouterModule extends _i9.AutoRouterModule {
  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    AddRequestRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddRequestPage(),
      );
    },
    BidRequestRoute.name: (routeData) {
      final args = routeData.argsAs<BidRequestRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BidRequestPage(
          key: args.key,
          request: args.request,
        ),
      );
    },
    BookingBidRoute.name: (routeData) {
      final args = routeData.argsAs<BookingBidRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.BookingBidPage(
          key: args.key,
          infoBookingBidModel: args.infoBookingBidModel,
        ),
      );
    },
    GeneralRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.GeneralPage(),
      );
    },
    MineRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MinePage(),
      );
    },
    RequestDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RequestDetailRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.RequestDetailPage(
          key: args.key,
          request: args.request,
          isMine: args.isMine,
        ),
      );
    },
    RequestRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.RequestPage(),
      );
    },
    RequestTabRouter.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.RequestTabRouter(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddRequestPage]
class AddRequestRoute extends _i9.PageRouteInfo<void> {
  const AddRequestRoute({List<_i9.PageRouteInfo>? children})
      : super(
          AddRequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddRequestRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BidRequestPage]
class BidRequestRoute extends _i9.PageRouteInfo<BidRequestRouteArgs> {
  BidRequestRoute({
    _i10.Key? key,
    required _i11.RequestModel request,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          BidRequestRoute.name,
          args: BidRequestRouteArgs(
            key: key,
            request: request,
          ),
          initialChildren: children,
        );

  static const String name = 'BidRequestRoute';

  static const _i9.PageInfo<BidRequestRouteArgs> page =
      _i9.PageInfo<BidRequestRouteArgs>(name);
}

class BidRequestRouteArgs {
  const BidRequestRouteArgs({
    this.key,
    required this.request,
  });

  final _i10.Key? key;

  final _i11.RequestModel request;

  @override
  String toString() {
    return 'BidRequestRouteArgs{key: $key, request: $request}';
  }
}

/// generated route for
/// [_i3.BookingBidPage]
class BookingBidRoute extends _i9.PageRouteInfo<BookingBidRouteArgs> {
  BookingBidRoute({
    _i12.Key? key,
    required _i13.InfoBookingBidModel infoBookingBidModel,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          BookingBidRoute.name,
          args: BookingBidRouteArgs(
            key: key,
            infoBookingBidModel: infoBookingBidModel,
          ),
          initialChildren: children,
        );

  static const String name = 'BookingBidRoute';

  static const _i9.PageInfo<BookingBidRouteArgs> page =
      _i9.PageInfo<BookingBidRouteArgs>(name);
}

class BookingBidRouteArgs {
  const BookingBidRouteArgs({
    this.key,
    required this.infoBookingBidModel,
  });

  final _i12.Key? key;

  final _i13.InfoBookingBidModel infoBookingBidModel;

  @override
  String toString() {
    return 'BookingBidRouteArgs{key: $key, infoBookingBidModel: $infoBookingBidModel}';
  }
}

/// generated route for
/// [_i4.GeneralPage]
class GeneralRoute extends _i9.PageRouteInfo<void> {
  const GeneralRoute({List<_i9.PageRouteInfo>? children})
      : super(
          GeneralRoute.name,
          initialChildren: children,
        );

  static const String name = 'GeneralRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.MinePage]
class MineRoute extends _i9.PageRouteInfo<void> {
  const MineRoute({List<_i9.PageRouteInfo>? children})
      : super(
          MineRoute.name,
          initialChildren: children,
        );

  static const String name = 'MineRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RequestDetailPage]
class RequestDetailRoute extends _i9.PageRouteInfo<RequestDetailRouteArgs> {
  RequestDetailRoute({
    _i12.Key? key,
    required _i11.RequestModel request,
    required bool isMine,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          RequestDetailRoute.name,
          args: RequestDetailRouteArgs(
            key: key,
            request: request,
            isMine: isMine,
          ),
          initialChildren: children,
        );

  static const String name = 'RequestDetailRoute';

  static const _i9.PageInfo<RequestDetailRouteArgs> page =
      _i9.PageInfo<RequestDetailRouteArgs>(name);
}

class RequestDetailRouteArgs {
  const RequestDetailRouteArgs({
    this.key,
    required this.request,
    required this.isMine,
  });

  final _i12.Key? key;

  final _i11.RequestModel request;

  final bool isMine;

  @override
  String toString() {
    return 'RequestDetailRouteArgs{key: $key, request: $request, isMine: $isMine}';
  }
}

/// generated route for
/// [_i7.RequestPage]
class RequestRoute extends _i9.PageRouteInfo<void> {
  const RequestRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.RequestTabRouter]
class RequestTabRouter extends _i9.PageRouteInfo<void> {
  const RequestTabRouter({List<_i9.PageRouteInfo>? children})
      : super(
          RequestTabRouter.name,
          initialChildren: children,
        );

  static const String name = 'RequestTabRouter';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
