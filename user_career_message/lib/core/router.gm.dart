// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:user_career_message/core/tab_router.dart' as _i2;
import 'package:user_career_message/message/pages/message_page.dart' as _i1;

abstract class $MessageRouterModule extends _i3.AutoRouterModule {
  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    MessageRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.MessagePage(),
      );
    },
    MessageTabRouter.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MessageTabRouter(),
      );
    },
  };
}

/// generated route for
/// [_i1.MessagePage]
class MessageRoute extends _i3.PageRouteInfo<void> {
  const MessageRoute({List<_i3.PageRouteInfo>? children})
      : super(
          MessageRoute.name,
          initialChildren: children,
        );

  static const String name = 'MessageRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MessageTabRouter]
class MessageTabRouter extends _i3.PageRouteInfo<void> {
  const MessageTabRouter({List<_i3.PageRouteInfo>? children})
      : super(
          MessageTabRouter.name,
          initialChildren: children,
        );

  static const String name = 'MessageTabRouter';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
