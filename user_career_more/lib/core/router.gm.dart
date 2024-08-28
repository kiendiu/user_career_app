// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:user_career_more/core/tab_router.dart' as _i2;
import 'package:user_career_more/more/pages/more_page.dart' as _i1;

abstract class $MoreRouterModule extends _i3.AutoRouterModule {
  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    MoreRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.MorePage(),
      );
    },
    MoreTabRouter.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MoreTabRouter(),
      );
    },
  };
}

/// generated route for
/// [_i1.MorePage]
class MoreRoute extends _i3.PageRouteInfo<void> {
  const MoreRoute({List<_i3.PageRouteInfo>? children})
      : super(
          MoreRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoreRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MoreTabRouter]
class MoreTabRouter extends _i3.PageRouteInfo<void> {
  const MoreTabRouter({List<_i3.PageRouteInfo>? children})
      : super(
          MoreTabRouter.name,
          initialChildren: children,
        );

  static const String name = 'MoreTabRouter';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
