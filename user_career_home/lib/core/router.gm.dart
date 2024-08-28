// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:user_career_home/core/tab_router.dart' as _i2;
import 'package:user_career_home/home/pages/home_page.dart' as _i1;

abstract class $HomeRouterModule extends _i3.AutoRouterModule {
  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    HomeTabRouter.name: (routeData) {
      final args = routeData.argsAs<HomeTabRouterArgs>(
          orElse: () => const HomeTabRouterArgs());
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.HomeTabRouter(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeTabRouter]
class HomeTabRouter extends _i3.PageRouteInfo<HomeTabRouterArgs> {
  HomeTabRouter({
    dynamic key,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          HomeTabRouter.name,
          args: HomeTabRouterArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeTabRouter';

  static const _i3.PageInfo<HomeTabRouterArgs> page =
      _i3.PageInfo<HomeTabRouterArgs>(name);
}

class HomeTabRouterArgs {
  const HomeTabRouterArgs({this.key});

  final dynamic key;

  @override
  String toString() {
    return 'HomeTabRouterArgs{key: $key}';
  }
}
