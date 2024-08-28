// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:user_career_request/core/tab_router.dart' as _i2;
import 'package:user_career_request/request/pages/request_page.dart' as _i1;

abstract class $RequestRouterModule extends _i3.AutoRouterModule {
  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    RequestRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.RequestPage(),
      );
    },
    RequestTabRouter.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.RequestTabRouter(),
      );
    },
  };
}

/// generated route for
/// [_i1.RequestPage]
class RequestRoute extends _i3.PageRouteInfo<void> {
  const RequestRoute({List<_i3.PageRouteInfo>? children})
      : super(
          RequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'RequestRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.RequestTabRouter]
class RequestTabRouter extends _i3.PageRouteInfo<void> {
  const RequestTabRouter({List<_i3.PageRouteInfo>? children})
      : super(
          RequestTabRouter.name,
          initialChildren: children,
        );

  static const String name = 'RequestTabRouter';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
